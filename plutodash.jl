### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 5145f6b7-ddb7-45ac-a3c7-fb30dc364f15
using Pkg

# ╔═╡ 0c8710c0-bdd0-46a0-9e0a-76565e074430
Pkg.activate(".")

# ╔═╡ 247ea030-8bd4-11ee-1923-2914682ad01e
using Revise

# ╔═╡ f22fce0f-bc83-4903-9597-c8ae00e8c8e7
using WGLMakie

# ╔═╡ eb0ca9a4-7d10-4f77-ac7d-30d845bbfba4
using PlutoUI

# ╔═╡ 8024c5f9-bfe8-4fae-a6e1-0364b5688950
using HypertextLiteral

# ╔═╡ e6a036b2-a202-40b8-ba97-b664d148b770
using MINDFulPlutoGUI

# ╔═╡ 957302ee-001b-4850-a89f-7ee256457860
MINDFulPlutoGUI.insert_bootstrap()

# ╔═╡ 68010739-8e28-44fe-b75d-2c9f9498b2a3
begin
    MINDFulPlutoGUI.init()
    nothing
end

# ╔═╡ 1fbb319e-8a8e-40cc-acc2-58a5a07ac275
begin
    begin
        _n1_btn = @bind arg_node_1 MINDFulPlutoGUI.get_html_select("node_selection_select_1", "Node 1", ["1", "2", "3", "7"])
        _n2_btn = @bind arg_node_2 MINDFulPlutoGUI.get_html_select("node_selection_select_2", "Node 2", ["1", "2", "3", "7"])
        _n1_sn = @bind arg_domain_1 MINDFulPlutoGUI.get_html_select("domain_selection_select", "Domain 1", ["1", "2", "3", "7"])
        _n2_sn = @bind arg_domain_2 MINDFulPlutoGUI.get_html_select("domain_selection_select", "Domain 2", ["1", "2", "3", "7"])

        create_intent_bind = @bind create_intent MINDFulPlutoGUI.get_html_button("create_intent_button", "Create Intent")
        _topology = @bind topology MINDFulPlutoGUI.get_html_select("topology_select", "Topology", ["4nets", "nobel-germany", "nobel-germany-france-topzoo"], "topology_select")

        compile_button_bind = @bind compile_button MINDFulPlutoGUI.get_html_button("compile_button", "Compile", "add_toast_to_div('MINDFulPluto.jl', 'Compiling intent...')")
        uncompile_button_bind = @bind uncompile_button MINDFulPlutoGUI.get_html_button("uncompile_button", "Uncompile")
        install_button_bind = @bind install_button MINDFulPlutoGUI.get_html_button("install_button", "Install", "add_toast_to_div('MINDFulPluto.jl', 'Installing intent...')")
        uninstall_button_bind = @bind uninstall_button MINDFulPlutoGUI.get_html_button("uninstall_button", "Uninstall")
        remove_button_bind = @bind remove_button MINDFulPlutoGUI.get_html_button("remove_button", "Remove")

        dev_mode_button_bind = @bind dev_mode_button MINDFulPlutoGUI.get_html_button("dev_mode_button", "Developer Mode")
        intent_list_button_bind = @bind intent_list_button MINDFulPlutoGUI.get_html_button("intent_list_button", "Intent list")

        _intent_selection = @bind intent_selection MINDFulPlutoGUI.get_html_select("intent_selection_select", "Select Intent", [], "intent_selection_select")
        _wanted_pos = @bind wanted_pos MINDFulPlutoGUI.get_html_select("wanted_pos_select", "Position", ["2", "3"], "wanted_pos_select")
        plot_selection_bind = @bind plot_selection MINDFulPlutoGUI.get_html_select("plot_selection_select", "Plotting type", ["intentplot", "ibnplot"])

        draw_button_bind = @bind draw_button MINDFulPlutoGUI.get_html_button("draw_button", "Draw", "add_toast_to_div('MINDFulPluto.jl', 'Plotting Intent...')")

        MINDFulPlutoGUI.get_dashboard_main_div(embed_display(_n1_btn), embed_display(_n1_sn), embed_display(_n2_btn), embed_display(_n2_sn),
            embed_display(create_intent_bind), embed_display(plot_selection_bind), embed_display(draw_button_bind), embed_display(compile_button_bind),
            embed_display(uncompile_button_bind), embed_display(install_button_bind), embed_display(uninstall_button_bind), embed_display(_intent_selection),
            embed_display(_wanted_pos), embed_display(_topology), embed_display(remove_button_bind))
    end
end

# ╔═╡ 05e59d51-ade8-4916-8e29-02a4a03c2295
#Wrap parameters in env variables
MINDFulPlutoGUI.wrap_in_variable(; selection_n1=arg_node_1, selection_n2=arg_node_2, selection_n1_sn=arg_domain_1, selection_n2_sn=arg_domain_2, selection_plot=plot_selection, selection_intent=intent_selection, selection_pos=wanted_pos, topology=topology)

# ╔═╡ a2e91f7f-7df9-4daf-a0b7-cfadc83a601a
MINDFulPlutoGUI.button_caller_wrapper("draw", "asd")

# ╔═╡ 36ded27e-079a-4bed-9d94-abd6314ddca8
MINDFulPlutoGUI.button_caller_wrapper("draw", "asd")

# ╔═╡ dcad27db-f258-4ac8-a17b-21397933a3a1
MINDFulPlutoGUI.button_caller_wrapper("draw", "asd";)

# ╔═╡ 06f0a5a3-b546-40e8-8e30-c6392ea25e3e
MINDFulPlutoGUI.button_caller_wrapper("create_intent", create_intent;)

# ╔═╡ 98709f18-9f50-4d13-ba9e-15780d62f2a2
MINDFulPlutoGUI.button_caller_wrapper("compile_intent", compile_button;)

# ╔═╡ da567849-9f10-46ff-a8dd-c537b5a90048
MINDFulPlutoGUI.button_caller_wrapper("uncompile_intent", uncompile_button;)

# ╔═╡ d76778b2-fafb-4017-ad1e-3572ed4b799e
MINDFulPlutoGUI.button_caller_wrapper("install_intent", install_button;)

# ╔═╡ 56a90e03-6fb9-47ba-86d8-cbd96f7c66d7
MINDFulPlutoGUI.button_caller_wrapper("uninstall_intent", uninstall_button;)

# ╔═╡ 15db2153-781d-4a70-9cbb-a85c1774fbd3
MINDFulPlutoGUI.button_caller_wrapper("remove_intent", remove_button;)

# ╔═╡ 4fbae048-e383-41da-bb76-10d23241b15d
MINDFulPlutoGUI.update_domain_and_node_list("domain", topology)

# ╔═╡ 04b12cc9-e83c-46c7-b3fb-12bd01a56c40
MINDFulPlutoGUI.update_domain_and_node_list("node1", arg_domain_1)

# ╔═╡ 744c90ce-02a9-4924-874c-9de65209d557
MINDFulPlutoGUI.update_domain_and_node_list("node2", arg_domain_2)

# ╔═╡ 8807bcad-8926-4ea0-9ba2-40ea47500a87
begin
	topology
    if topology != "Topology"
	    MINDFulPlutoGUI.send_toast("Loading topology $(topology)...")
    end
end

# ╔═╡ e9acb26d-07de-45d4-8bcd-88616842565d
#= begin
    install_button
    MINDFulPlutoGUI.update_intent_list_html()
end =#

# ╔═╡ aa5dbee4-f5eb-4889-a0d5-8b9014570409
MINDFulPlutoGUI.resize_cells()

# ╔═╡ c7fcbb44-29c2-471b-bab1-4d4b591840f4
MINDFulPlutoGUI.trigger_update_of_draw_cell(draw_button)

# ╔═╡ daceb10a-f60c-4f4f-b2ac-ff8bf68f8c8a
MINDFulPlutoGUI.intent_list

# ╔═╡ 77b3716e-aac5-47f0-8618-253afc079b4b
intent_states = [MINDFulPlutoGUI.get_intent_state(MINDFulPlutoGUI.intent_list[i]["ibns"][MINDFulPlutoGUI.intent_list[i]["sn"]], MINDFulPlutoGUI.intent_list[i]["id"]) for i in 1:length(MINDFulPlutoGUI.intent_list)]

# ╔═╡ Cell order:
# ╠═5145f6b7-ddb7-45ac-a3c7-fb30dc364f15
# ╟─0c8710c0-bdd0-46a0-9e0a-76565e074430
# ╠═247ea030-8bd4-11ee-1923-2914682ad01e
# ╠═f22fce0f-bc83-4903-9597-c8ae00e8c8e7
# ╠═eb0ca9a4-7d10-4f77-ac7d-30d845bbfba4
# ╠═8024c5f9-bfe8-4fae-a6e1-0364b5688950
# ╠═e6a036b2-a202-40b8-ba97-b664d148b770
# ╠═957302ee-001b-4850-a89f-7ee256457860
# ╠═68010739-8e28-44fe-b75d-2c9f9498b2a3
# ╟─1fbb319e-8a8e-40cc-acc2-58a5a07ac275
# ╠═05e59d51-ade8-4916-8e29-02a4a03c2295
# ╟─a2e91f7f-7df9-4daf-a0b7-cfadc83a601a
# ╟─36ded27e-079a-4bed-9d94-abd6314ddca8
# ╟─dcad27db-f258-4ac8-a17b-21397933a3a1
# ╠═06f0a5a3-b546-40e8-8e30-c6392ea25e3e
# ╠═98709f18-9f50-4d13-ba9e-15780d62f2a2
# ╠═da567849-9f10-46ff-a8dd-c537b5a90048
# ╠═d76778b2-fafb-4017-ad1e-3572ed4b799e
# ╠═56a90e03-6fb9-47ba-86d8-cbd96f7c66d7
# ╠═15db2153-781d-4a70-9cbb-a85c1774fbd3
# ╠═4fbae048-e383-41da-bb76-10d23241b15d
# ╠═04b12cc9-e83c-46c7-b3fb-12bd01a56c40
# ╠═744c90ce-02a9-4924-874c-9de65209d557
# ╠═8807bcad-8926-4ea0-9ba2-40ea47500a87
# ╠═e9acb26d-07de-45d4-8bcd-88616842565d
# ╠═aa5dbee4-f5eb-4889-a0d5-8b9014570409
# ╠═c7fcbb44-29c2-471b-bab1-4d4b591840f4
# ╠═daceb10a-f60c-4f4f-b2ac-ff8bf68f8c8a
# ╠═77b3716e-aac5-47f0-8618-253afc079b4b
