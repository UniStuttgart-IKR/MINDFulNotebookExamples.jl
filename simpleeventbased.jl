### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# ╔═╡ bac63278-6578-42bc-b4a0-4e88cf860dce
import Pkg

# ╔═╡ a91bcfcd-06ae-4ae9-a87a-add45f09a3c0
Pkg.activate(".")

# ╔═╡ 6473d54f-344f-4271-8f21-723033485437
using MINDFul, GraphIO, NestedGraphsIO, NestedGraphs, Graphs

# ╔═╡ 0f7cead6-1f2e-4044-a01c-9cf10326865c
using DiscreteEvents, Distributions, Random, Logging, Unitful

# ╔═╡ 839bc204-f9cf-4d6f-be1c-291fdd038f22
html"""
<style>
	main {
		margin: 0 auto;
		max-width: 2000px;
    	padding-left: max(160px, 10%);
    	padding-right: max(160px, 10%);
	}
</style>
"""

# ╔═╡ 7448a4ee-c29a-42c8-ab7e-9b1086ac1b55
md"# Doing event-based simulation with `MINDFul.jl`

In this notebook, we demonstrate a simple way of using `MINDFul.jl` in an event-based simulation.
We will use [`DiscreteEvents.jl`](https://github.com/pbayer/DiscreteEvents.jl) as the event-based simulation library, although other choices can be made."

# ╔═╡ 71540933-7a26-4715-b355-6d29b19d2d79
const MINDF = MINDFul

# ╔═╡ 4b661417-38f8-4dd7-9e61-2d633d4b9757
import MetaGraphs as MG

# ╔═╡ 5272c7d0-727f-4be3-8d9a-225990b95442
md"### Some helper functions" 

# ╔═╡ d72eb4d8-8859-485d-a7ec-f76af377f1f1
# a function to add compile and intstall an intent
function addcompileinstall(ibn, conint; time)
    intentidx = addintent!(ibn, conint)
	deploy!(ibn, intentidx, MINDF.docompile, MINDF.SimpleIBNModus(), MINDF.shortestavailpath!; time)
	deploy!(ibn, intentidx, MINDF.doinstall, MINDF.SimpleIBNModus(), MINDF.directinstall!; time)
end

# ╔═╡ 00b5521c-b261-4891-988f-f08bd0d91fae
getfiberview(ibn::IBN, edg::Edge) = MG.get_prop(ibn.ngr, edg, :link)

# ╔═╡ 6e3a5d21-e994-4e3a-a5cb-0892ebc145b2
# Get edges as if the graph was undirected
undirectededges(g) = Iterators.filter((e -> e.src < e.dst) ,edges(g))

# ╔═╡ 014ccada-5ad0-46ea-a0b0-106915dda8ee
# Mean Time To Failure is set to one month
MTTF() = 24*30u"hr"

# ╔═╡ 07cc0088-a0c0-4187-a5ad-84fc04c19392
# Mean Time To Repair is set to one day
MTTR() = 24u"hr"

# ╔═╡ bb63e586-5ce6-4d03-b564-0363bd9a2a00
# Toogle repair times with failure times
function toggle_operation_N_event!(vd::Vector, clock, ibn, dev1, dev2, i = 2)
    function clostog()
        set_operation_status!(ibn, dev1, !dev1.operates; time=tau(clock))
        set_operation_status!(ibn, dev2, !dev2.operates; time=tau(clock))
        nextevent = ustrip(u"hr", vd[i]())
        distr = Exponential(nextevent)
        event!(clock, clostog, after , distr)
        i = 3 - i
    end
end

# ╔═╡ afd243a7-9d3c-4ecc-81f2-bbb5efd3c03e
# Loads events in a clock.
# Scans all edges in myibns and adds a toggling MTTF/MTTR event for each
function loadevents!(clock, myibns)
    ldistrs = [MTTF, MTTR]
    for ibn in myibns
        for edg in undirectededges(ibn.ngr)
            dev1 = getfiberview(ibn, edg) # outgoing edge
            dev2 = getfiberview(ibn, reverse(edg)) # incoming edge
			
            # initialize as working
			set_operation_status!(ibn, dev1, true; time=tau(clock), forcelog=true)
			set_operation_status!(ibn, dev2, true; time=tau(clock), forcelog=true)

			# first event will be an failure according to MTTF
			meanexp = ustrip(u"hr", ldistrs[1]())
			distr = Exponential(meanexp)
			event!(clock, toggle_operation_N_event!(ldistrs, clock, ibn, dev1, dev2), after, distr)
        end
    end
end

# ╔═╡ 7a9d9486-a8bc-4a86-8928-c5f8e42ba40f
function runsim!(myibns; seed=1)
    Random.seed!(seed)

	# define clock needed for event based simulation
    clock = DiscreteEvents.Clock(unit=Unitful.hr)

	# load the events in the simulation calendar
    loadevents!(clock, myibns)

	# prepare a bunch of intents
    conints = [ConnectivityIntent((myibns[1].id,2), (myibns[3].id,1), [CapacityConstraint(50), GoThroughConstraint((2,1))]),
               ConnectivityIntent((myibns[1].id,2), (myibns[3].id,5), [CapacityConstraint(50), GoThroughConstraint((2,1))]),
               ConnectivityIntent((myibns[1].id,2), (myibns[3].id,7), [CapacityConstraint(50), GoThroughConstraint((2,1))])]

	# install the intents at time 0
	let time=0u"hr"
		with_logger(ConsoleLogger(stderr, Logging.Error)) do
			for conint in conints
				addcompileinstall(myibns[1], conint; time)
			end
		end
	end

	# run simulation for a year
	let year =  365 * 24u"hr"
		run!(clock, year)
	end

    return clock
end


# ╔═╡ e3b9a3bd-0ea2-4a1e-90e7-3b097c4be769
md"### Prepare the simulation-able graph"

# ╔═╡ 16934504-1472-4589-b5c5-46f0c0937a48
myibns = 
let
	# read in the NestedGraph
	globalnet = open(joinpath("data/4nets.graphml")) do io
	    loadgraph(io, "global-network", GraphMLFormat(), NestedGraphs.NestedGraphFormat())
	end
	# convert it to a NestedGraph compliant with the simulation specifications
	globalsimgraph = MINDFul.simgraph(globalnet)
	# convert it to IBNs
	myibns = MINDFul.nestedGraph2IBNs!(globalsimgraph)
end

# ╔═╡ f3df6af6-fde8-4c41-ad3a-dca5c4dde213
md"### Do the simulation."

# ╔═╡ 0b44c992-5282-41ed-bd0c-a83abdc8684e
runsim!(myibns)

# ╔═╡ 250687bb-d00f-4caf-bc0e-61a1f6acbcc2
md"The log now contains all status transitions for all edges of the graph.
`false` means the link failed and `true` that the link got repaired."

# ╔═╡ 063a519c-cd88-43cd-b3fc-bfb9a04a77b4
[e => getfiberview(myibns[1], e).logstate.logtime for e in edges(myibns[1].ngr)]

# ╔═╡ c5ec705e-e689-4a88-99dc-fa9d1e44f2db
md"We can also see the log status of all the intents"

# ╔═╡ ef5d31d7-2efd-41a0-bada-aa0d86eac514
[getid(myibns[1].intents[i]) => getuserintent(myibns[1].intents[i]).logstate.logtime for i in eachindex(myibns[1].intents)]

# ╔═╡ 23fa03d2-12f5-4185-b56e-eaa3c329286a
md"Based on these logs, we can start an evaluation of the intent system, like the intet compilation algorithms and the state-machine deployed !"

# ╔═╡ Cell order:
# ╟─839bc204-f9cf-4d6f-be1c-291fdd038f22
# ╟─7448a4ee-c29a-42c8-ab7e-9b1086ac1b55
# ╠═bac63278-6578-42bc-b4a0-4e88cf860dce
# ╠═a91bcfcd-06ae-4ae9-a87a-add45f09a3c0
# ╠═6473d54f-344f-4271-8f21-723033485437
# ╠═71540933-7a26-4715-b355-6d29b19d2d79
# ╠═0f7cead6-1f2e-4044-a01c-9cf10326865c
# ╠═4b661417-38f8-4dd7-9e61-2d633d4b9757
# ╟─5272c7d0-727f-4be3-8d9a-225990b95442
# ╠═d72eb4d8-8859-485d-a7ec-f76af377f1f1
# ╠═00b5521c-b261-4891-988f-f08bd0d91fae
# ╠═6e3a5d21-e994-4e3a-a5cb-0892ebc145b2
# ╠═014ccada-5ad0-46ea-a0b0-106915dda8ee
# ╠═07cc0088-a0c0-4187-a5ad-84fc04c19392
# ╠═7a9d9486-a8bc-4a86-8928-c5f8e42ba40f
# ╠═afd243a7-9d3c-4ecc-81f2-bbb5efd3c03e
# ╠═bb63e586-5ce6-4d03-b564-0363bd9a2a00
# ╟─e3b9a3bd-0ea2-4a1e-90e7-3b097c4be769
# ╠═16934504-1472-4589-b5c5-46f0c0937a48
# ╟─f3df6af6-fde8-4c41-ad3a-dca5c4dde213
# ╠═0b44c992-5282-41ed-bd0c-a83abdc8684e
# ╟─250687bb-d00f-4caf-bc0e-61a1f6acbcc2
# ╠═063a519c-cd88-43cd-b3fc-bfb9a04a77b4
# ╟─c5ec705e-e689-4a88-99dc-fa9d1e44f2db
# ╠═ef5d31d7-2efd-41a0-bada-aa0d86eac514
# ╟─23fa03d2-12f5-4185-b56e-eaa3c329286a
