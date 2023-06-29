### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ f5e6f716-e838-11ed-1bd2-8d3a022443c5
import Pkg

# ╔═╡ 2fbf420a-f944-4b33-b126-eb7010548795
Pkg.activate(".")

# ╔═╡ 179e6ac8-6fa2-406a-8020-da2828132fdf
using MINDFul, MINDFulCompanion

# ╔═╡ 213c1c30-6f8a-4828-8e7a-45eb473822f5
using GraphIO, NestedGraphsIO, NestedGraphs, Graphs, MetaGraphs, AttributeGraphs

# ╔═╡ dcb30dbe-3583-436e-a46e-a32a2cf05387
using CairoMakie, MINDFulMakie, PlutoUI

# ╔═╡ 7573f72d-64e1-4d61-8d8e-2ca4c2bc3dee
using Random, Distributions, Unitful, UUIDs, StatsBase

# ╔═╡ b528971a-f661-44ac-9066-403650f79001
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

# ╔═╡ ff58f7e6-d133-4393-a308-7b63707d460c
md"# Using Intent Directed Acyclic Graphs (DAGs) in Multi-Domain IP-Optical Networks

This notebook contains a walkthrough of a design to adapt intent DAGs into multi-domain networks and an example.
The implementation can be found on the included packages.

An intent DAG is an advanced technique that enables resource reuse via grooming in a centralized or non-centralized fashion.
Using hierarchical multi-step intent compilation (like intent trees or intent DAGs) and intent delegation fosters MD flexibility, promotes accountability, and respects confidentiality. 
Intent DAGs can further increase interoperability and enable cross-domain grooming with border node optical bypass.


A related manuscript is at works and under review"

# ╔═╡ 6d418df1-5d22-4b70-ae8d-bff52dcfdaa7
const MINDF = MINDFul

# ╔═╡ befbac6b-29dd-4457-8664-a6f2170c34fd
md"MINDFulCompanion.jl contains a heuristic grooming-enabled RMSA algorithm we are going to use here. The algorithm is inspired from:

> V. Gkamas, K. Christodoulopoulos and E. Varvarigos, \"A Joint Multi-Layer Planning Algorithm for IP Over Flexible Optical Networks,\" in Journal of Lightwave Technology, vol. 33, no. 14, pp. 2965-2977, 15 July15, 2015, doi: 10.1109/JLT.2015.2424920.

modified to use intent DAGs as described in:

> F. Christou and A. Kirstädter, \"Grooming connectivity in-tents in ip-optical networks using directed acyclic graphs\", in (accepted) Photonic Networks; 24th ITG-Symposium, preprint in https://arxiv.org/abs/2304.09711, 2023.

and further modified (paper currently in review process) for multi-domain operation. The algorithm is `MINDFulCompanion.jointrmsagenerilizeddijkstra!`
"

# ╔═╡ 376bd565-f14d-4be6-9a4c-e7879ab1c1c4
const MINDFC = MINDFulCompanion

# ╔═╡ 04b0b43a-7aac-4ea1-9bd9-cbc7624e1269
md"# Functions definition"

# ╔═╡ 78370945-9c91-4f35-957c-2664d7c0196e
md"To get the IBNs with the topology"

# ╔═╡ d9853453-888e-4069-9e02-035572e9533d
function ibn4nets()
	globalnet = open("data/4nets.graphml") do io
		loadgraph(io, "global-network", GraphIO.GraphML.GraphMLFormat(), NestedGraphs.NestedGraphFormat())
	end
	simgraph = MINDFul.simgraph(globalnet; 
								distance_method = MINDF.euclidean_dist,
								router_lcpool=MINDFC.defaultlinecards(), 
								router_lccpool=MINDFC.defaultlinecardchassis(), 
								router_lcccap=6,
								transponderset=MINDFC.defaulttransmissionmodules())
	MINDFul.nestedGraph2IBNs!(simgraph)
end

# ╔═╡ 916f6ff2-23aa-4fd1-a2aa-7d7ac6a35152
md"Dummy time progression for event-based simulation"

# ╔═╡ 12277464-e051-487c-bb69-060bfa7793bd
nexttime() = MINDF.COUNTER("time")u"hr"

# ╔═╡ e711e8af-ed2c-41b4-862e-2a0ae318ad56
md"This function generates demands following a truncated normal distribution"

# ╔═╡ 68433c12-00b8-49c5-ad6a-4e59101cbab9
function generatedemands_normal(vecnum, rng = Random.MersenneTwister(0); mu=200, sigma=50, low=50, high=750)
    distr = truncated(Normal(mu, sigma), low, high)
    [rand(rng, distr) for _ in 1:vecnum]
end

# ╔═╡ 7d7aa111-93b5-4191-81a4-bfb056d09dc0
md"This function gets all demands, translates them to connecivity intents, adds them in the intent framework, compiles them and installs them. The source IBN target is used for the intent delivery."

# ╔═╡ d8b14d8b-e385-4900-919f-b314136714d6
function generatedems(ibns, rng; mu = 200)
    demdict = Dict{Tuple{Int,Int,Int,Int}, Float64}()
    for ibn1 in ibns
        nv1 = nv(MINDF.getgraph(ibn1))
        bds1 = MINDF.bordernodes(ibn1; subnetwork_view=false)
        for ibn2 in ibns
            nv2 = nv(MINDF.getgraph(ibn2))
            bds2 = MINDF.bordernodes(ibn2; subnetwork_view=false)
			demvec = generatedemands_normal(nv1 * nv2, rng; mu)
			for v1 in 1:nv1
				for v2 in 1:nv2
					getid(ibn1) == getid(ibn2) && v1 == v2 && continue
					if v1 ∉ bds1 && v2 ∉ bds2
						demdict[(getid(ibn1), v1, getid(ibn2), v2)] = demvec[(v1-1) * nv2 + v2]
					end
				end
            end
        end
    end
    demdict
end

# ╔═╡ 14c16d62-255b-4d28-901f-2b0bf791ec99
md"This function gets a demands, translates them to a connecivity intent, adds it in the intent framework, compile it and installs it."

# ╔═╡ 21f4504a-0d58-48fa-ae7b-c78b524d6d09
function compileNinstall!(ibn::IBN, ds, ns, dt, nt, demval)
	conint = ConnectivityIntent((ds,ns), (dt, nt), demval)
	intentid = addintent!(ibn, conint)
	deploy!(ibn, intentid, MINDF.docompile, MINDF.SimpleIBNModus(), MINDFulCompanion.jointrmsagenerilizeddijkstra!; time=nexttime())
	deploy!(ibn, intentid, MINDF.doinstall, MINDF.SimpleIBNModus(), MINDF.directinstall!; time=nexttime());
	return intentid
end

# ╔═╡ 021dc7be-77b1-409c-8a5a-e5f9dbff994f
function compileNinstall!(ibns, demands)
    for ((ds,ns,dt,nt), demval) in demands
        compileNinstall!(ibns[ds], ds, ns, dt, nt, demval)

		# check consistency
		if !all([let 
			fv = MINDF.getlink(ibn,e); 
			fv.spectrum_src == fv.spectrum_dst; 
		end for ibn in ibns for e in edges(ibn.ngr)])
			break
		end
    end
end

# ╔═╡ c0c5b3bd-cdac-4152-889d-724c69b50eeb
md"# Simulation"

# ╔═╡ 5321f7fb-042e-4ed4-94fd-01286b0f5c27
md"Load the dummy multi-domain network"

# ╔═╡ 4f76e4e3-ad89-4980-bb51-fa6d216a75a2
myibns = ibn4nets()     

# ╔═╡ 0e8f6aa5-6185-4fb3-85ef-0757f91b3157
md"Fix the seed for reproducibility"

# ╔═╡ b64d5db9-d1c6-45af-9f41-7ce61d2d59a1
rng = Random.MersenneTwister(0)     

# ╔═╡ 4524354a-1fd6-417c-b29b-15c9358adeef
md"Generate some demands"

# ╔═╡ fb7176c7-4ffa-4898-a326-983a73f137c8
demands = generatedems(myibns, rng; mu=100)

# ╔═╡ e3043e7d-5434-4d88-b9c1-6368db6578c9
md"## Handle a single intent"

# ╔═╡ da736895-9d18-4ab7-aee4-186a9d530c6c
md"Let's assume we want to first handle the demand between the 3rd node of the 1st domain and the 6th node of the 3rd domain, i.e. :"

# ╔═╡ d24ddeb7-04fa-452b-8679-36a9912f0127
demkey1 = (1,3,3,6)

# ╔═╡ c5637933-2678-47dd-9bd6-84887672f286
demands[demkey1...] #[src_domain, src_node, dst_domain, dst_node]

# ╔═╡ 896122d0-03c8-4626-9987-32996b370411
intentid1 = compileNinstall!(myibns[1], demkey1..., demands[demkey1...])

# ╔═╡ 922ad6d6-3abf-48b6-83d2-d44887f81056
md"The intent should be satisfied, as there is no way the resources were scarce"

# ╔═╡ 0a89b939-9e8e-47da-bb78-e873c78e2009
issatisfied(myibns[1], intentid1)

# ╔═╡ b98499c3-4e0f-4ed6-a70c-e2681c93506b
md"We plot the intent using MINDFulMakie.jl"

# ╔═╡ 5b099fdb-8df7-46c6-9b01-d3e3151569cf
let
	fig = Figure()
	ax = Axis(fig[1,1])
	ibnplot!(ax, myibns, intentidx=[intentid1])
	hidedecorations!(ax)
	fig
end

# ╔═╡ 50ce26be-8963-4e18-81b2-b2178fa0fd03
md"The different node colors show the different domains. The domains are not controlled centralized and they have information only about the whereabouts of the border nodes.
Everything else is handled by the intent DAG (Directed Acyclic Graph) delegation scheme.

The purple line is the path to handle the connectivity intent. The purple rings denote IP port allocation. We see that Optical-Electical-Optical conversion was not needed in the border nodes. This is because the intent DAG delegation imposes some specific intent constraints:
- `BorderTerminateConstraint` imposes the lightpath intent to end in the optical layer 
- `BorderInitiateConstraint` imposes the lightpath intent to start in the optical layer" 

# ╔═╡ 609a8246-412d-4ff7-b9a8-f771a10a15d7
md"### Intent implementation

The intents are compiled with `MINDFulCompanion.jointrmsagenerilizeddijkstra!`, which uses intent DAGs. This means that the user intent is recursively broken down to lower-level intents. The overall structure forms a DAG. Let's have a look on the just compiled intent DAG."

# ╔═╡ daf4e1ca-dab1-4d73-b443-be56eb4b90d6
let
	fig = Figure(resolution=(2200, 1000))
	a = Axis(fig[1, 1], yautolimitmargin = (0.6, 0.2), title="Installed intent DAG IBN[1]")
	intentplot!(a, myibns[1], intentid1)
	fig
end

# ╔═╡ 035d24d7-d668-4260-b189-2463b78ad8c2
md"The leafs of the DAG are low-level intents (except for the `RemoteIntent`):
- `NodeRouterPortIntent` allocates an IP router port 
- `NodeTransmoduleIntent` allocates an transmission module
- `NodeSpectrumIntent` allocates spectrum slots in the optical fiber
- `NodeROADMINtent` configures the node ROADM for the crossing lightpath

As you can see electrical activity exists only in node 3.

The `DomainConnectivityIntent`, `LightpathIntent` and `SpectrumIntent` are higher-level intents. Let's have a look at the lightpath intent:"

# ╔═╡ 7d85bbd8-e194-486e-ab80-b3b7ec6cf6d9
getintentnode(myibns[1], UUID(0x3))

# ╔═╡ 6c7113c9-c33f-4e92-b177-c711b80cc904
md"The lightpath is across the nodes `[3,5,6,10]`. The node `10` is the internal representation of the 1st node for the 2nd domain:"

# ╔═╡ b28c6f16-cee0-448f-9e03-ed0f02a159a7
MINDF.globalnode(myibns[1], 10)

# ╔═╡ 78a32374-971b-4155-bf6a-9357ac358c39
md"The lightpath contains the constraint $(getconstraints(getintent(myibns[1], UUID(0x3)))). This constraint makes the lightpath intent to end in the optical layer. The connection will be continued by the delegated intent UUID(0xf):"

# ╔═╡ 326f6f01-588d-4fb8-a9d5-ef078c283cbf
getintentnode(myibns[1], UUID(0xf))

# ╔═╡ 9d7cd973-7537-4618-b729-af9e5302765c
md"This intent has a `BorderInitiateConstraint` together with all the lightpath requirements that are needed in order for the second domain to continue this connection further."

# ╔═╡ a24cc446-294b-41d9-9b59-4c081a919a87
getconstraints(getintent(myibns[1], UUID(0xf)))

# ╔═╡ e88565d1-de15-46ad-b488-382dd311c90f
md"By alternating between `BorderTerminateConstraint` and `BorderInitaiteConstraint` multi-domain lightpath provisioning becomes possible.

The remote intent informs us that the intent was delegated to the 2nd domain with an id of `0x1`"

# ╔═╡ 8caee1a6-2b08-407c-957c-8a339c65aa07
getintentnode(myibns[2], UUID(0x1))

# ╔═╡ f3d4d262-9fbc-4d15-a611-ff57154074f9
md"The DAG of this intent in the second domain is uknown to the external domains. IBN[2] has complete confidentialy and liberty on how to compile this intent."

# ╔═╡ 60957c65-faa0-48d9-b476-06bdafe44a20
md"### Multilayer multigraph internals

`MINDFulCompanion.jointrmsagenerilizeddijkstra!` works internally by translating the IP-optical network into a multilayer multigraph. For example IBN[1] will be represented as following:"

# ╔═╡ 1b5c672d-f785-4e16-8a14-0b306d15b860
function drawmult(ibns, ibnid)
	fixedcoords(x) = (args...) -> x
	fcfun = fixedcoords(MINDFulMakie.coordlayout(myibns[ibnid].ngr))
	mlgr = MINDFC.mlnodegraphtomlgraph(myibns[ibnid], 3.2)		
	mlverts = NestedGraphs.getmlvertices(mlnodegraphtomlgraph(myibns[ibnid].ngr))
	return mlgr, fcfun, mlverts
end

# ╔═╡ 9c5fdea2-f5f9-4c93-92c4-a6d2de6d55f1
let
	f = Figure(resolution=(2000,1000))
	
	mlgr, fcfun, mlverts = drawmult(myibns, 1)
	a,p = netgraphplot(f[1,1], mlgr, multilayer=true, multilayer_vertices=mlverts, layout=fcfun, nlabels=repr.(vertices(mlgr)),
		axis=(title="IBN[1], lightpath from 6=>19 (starts electrical, finishes optical)",))
	hidedecorations!(a)

	mlgr, fcfun, mlverts = drawmult(myibns, 2)
	a,p = netgraphplot(f[1,2], mlgr, multilayer=true, multilayer_vertices=mlverts, layout=fcfun, nlabels=repr.(vertices(mlgr)),
		axis=(title="IBN[2], lightpath from 15=>17 (lightpath segment)",))
	hidedecorations!(a)

	mlgr, fcfun, mlverts = drawmult(myibns, 3)
	a,p = netgraphplot(f[2,2], mlgr, multilayer=true, multilayer_vertices=mlverts, layout=fcfun, nlabels=repr.(vertices(mlgr)),
		axis=(title="IBN[3], lightpath from 16=>12 (starts optical, finishes electrical)",))
	hidedecorations!(a)

	f
end

# ╔═╡ ba3d88a4-190d-4977-aca9-d24e66c05dd9
md"## Handle all connectivity intents"

# ╔═╡ 554131f0-ce84-40fb-94e1-1972e9680e6a
# ╠═╡ show_logs = false
compileNinstall!(myibns, demands)

# ╔═╡ 6efedc71-ec6f-4d60-83f0-4ea6c5a03f7f
md"Intent DAGs are an efficient structure which can reuse low-level intents for new user intents. The previous lightpath intent with id 0x3 is now used by 3 more user intents ! 
Have a look in the DAG:"

# ╔═╡ f8f45109-976d-4bcc-a526-6ed88f51f24f
let
	fig = Figure(resolution=(3000, 1000))
	a = Axis(fig[1, 1], yautolimitmargin = (0.6, 0.2), title="Installed intent DAG IBN[1]")
	intentplot!(a, myibns[1], UUID(0x3))
	fig
end

# ╔═╡ 34d16ab5-341c-4268-8eb1-809b727736cb
md"The intent (1,5,3,1) with UUID(0x356): 
- starts from node 5 of the first (black) domain. There is one ring for one IP port allocaiton.
- goes to node 3 to be groomed into the lightpath. There are 2 rings for two IP ports, which are needed for the O-E-O conversion and the grooming.
- comes out in the 6th node of the 3rd (pink) domain where the light path ends.
- continues to the 1st intra-domain node of the pink domain."

# ╔═╡ f4322d49-03c2-487e-aec3-3c6fea856aeb
let
	fig = Figure()
	ax = Axis(fig[1,1])
	ibnplot!(ax, myibns, intentidx=[UUID(0x1), UUID(0x356)])
	hidedecorations!(ax)
	fig
end

# ╔═╡ Cell order:
# ╟─b528971a-f661-44ac-9066-403650f79001
# ╟─ff58f7e6-d133-4393-a308-7b63707d460c
# ╠═f5e6f716-e838-11ed-1bd2-8d3a022443c5
# ╠═2fbf420a-f944-4b33-b126-eb7010548795
# ╠═179e6ac8-6fa2-406a-8020-da2828132fdf
# ╠═213c1c30-6f8a-4828-8e7a-45eb473822f5
# ╠═dcb30dbe-3583-436e-a46e-a32a2cf05387
# ╠═7573f72d-64e1-4d61-8d8e-2ca4c2bc3dee
# ╠═6d418df1-5d22-4b70-ae8d-bff52dcfdaa7
# ╟─befbac6b-29dd-4457-8664-a6f2170c34fd
# ╠═376bd565-f14d-4be6-9a4c-e7879ab1c1c4
# ╟─04b0b43a-7aac-4ea1-9bd9-cbc7624e1269
# ╟─78370945-9c91-4f35-957c-2664d7c0196e
# ╠═d9853453-888e-4069-9e02-035572e9533d
# ╟─916f6ff2-23aa-4fd1-a2aa-7d7ac6a35152
# ╠═12277464-e051-487c-bb69-060bfa7793bd
# ╟─e711e8af-ed2c-41b4-862e-2a0ae318ad56
# ╠═68433c12-00b8-49c5-ad6a-4e59101cbab9
# ╟─7d7aa111-93b5-4191-81a4-bfb056d09dc0
# ╠═d8b14d8b-e385-4900-919f-b314136714d6
# ╟─14c16d62-255b-4d28-901f-2b0bf791ec99
# ╠═21f4504a-0d58-48fa-ae7b-c78b524d6d09
# ╠═021dc7be-77b1-409c-8a5a-e5f9dbff994f
# ╟─c0c5b3bd-cdac-4152-889d-724c69b50eeb
# ╟─5321f7fb-042e-4ed4-94fd-01286b0f5c27
# ╠═4f76e4e3-ad89-4980-bb51-fa6d216a75a2
# ╟─0e8f6aa5-6185-4fb3-85ef-0757f91b3157
# ╠═b64d5db9-d1c6-45af-9f41-7ce61d2d59a1
# ╟─4524354a-1fd6-417c-b29b-15c9358adeef
# ╠═fb7176c7-4ffa-4898-a326-983a73f137c8
# ╟─e3043e7d-5434-4d88-b9c1-6368db6578c9
# ╟─da736895-9d18-4ab7-aee4-186a9d530c6c
# ╠═d24ddeb7-04fa-452b-8679-36a9912f0127
# ╠═c5637933-2678-47dd-9bd6-84887672f286
# ╠═896122d0-03c8-4626-9987-32996b370411
# ╟─922ad6d6-3abf-48b6-83d2-d44887f81056
# ╠═0a89b939-9e8e-47da-bb78-e873c78e2009
# ╟─b98499c3-4e0f-4ed6-a70c-e2681c93506b
# ╠═5b099fdb-8df7-46c6-9b01-d3e3151569cf
# ╟─50ce26be-8963-4e18-81b2-b2178fa0fd03
# ╟─609a8246-412d-4ff7-b9a8-f771a10a15d7
# ╠═daf4e1ca-dab1-4d73-b443-be56eb4b90d6
# ╟─035d24d7-d668-4260-b189-2463b78ad8c2
# ╠═7d85bbd8-e194-486e-ab80-b3b7ec6cf6d9
# ╟─6c7113c9-c33f-4e92-b177-c711b80cc904
# ╠═b28c6f16-cee0-448f-9e03-ed0f02a159a7
# ╟─78a32374-971b-4155-bf6a-9357ac358c39
# ╠═326f6f01-588d-4fb8-a9d5-ef078c283cbf
# ╟─9d7cd973-7537-4618-b729-af9e5302765c
# ╠═a24cc446-294b-41d9-9b59-4c081a919a87
# ╟─e88565d1-de15-46ad-b488-382dd311c90f
# ╟─8caee1a6-2b08-407c-957c-8a339c65aa07
# ╟─f3d4d262-9fbc-4d15-a611-ff57154074f9
# ╟─60957c65-faa0-48d9-b476-06bdafe44a20
# ╟─1b5c672d-f785-4e16-8a14-0b306d15b860
# ╠═9c5fdea2-f5f9-4c93-92c4-a6d2de6d55f1
# ╟─ba3d88a4-190d-4977-aca9-d24e66c05dd9
# ╠═554131f0-ce84-40fb-94e1-1972e9680e6a
# ╟─6efedc71-ec6f-4d60-83f0-4ea6c5a03f7f
# ╠═f8f45109-976d-4bcc-a526-6ed88f51f24f
# ╟─34d16ab5-341c-4268-8eb1-809b727736cb
# ╠═f4322d49-03c2-487e-aec3-3c6fea856aeb
