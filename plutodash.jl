### A Pluto.jl notebook ###
# v0.19.37

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
using Revise, WGLMakie, PlutoUI, HypertextLiteral, MINDFulPluto

# ╔═╡ 1fbb319e-8a8e-40cc-acc2-58a5a07ac275
begin
    begin
        MINDFulPluto.get_dashboard_main_div()
    end
end

# ╔═╡ 36ded27e-079a-4bed-9d94-abd6314ddca8
MINDFulPluto.plot_intent()

# ╔═╡ dcad27db-f258-4ac8-a17b-21397933a3a1
MINDFulPluto.plot_intent()

# ╔═╡ 0ed42b9e-dba7-40cb-b58d-7bd306dd384e
begin
	#get javascript values
	viewport_height_bind = @bind viewport_height html"""<input type="number" id="viewportHeight" value="">"""
	viewport_width_bind = @bind viewport_width html"""<input type="number" id="viewportWidth" value="">"""
	window_dpr_bind = @bind window_dpr html"""<input type="number" id="windowDevicePixelRatio" value="">"""


	@htl("""

	$(embed_display(viewport_height_bind))
	$(embed_display(viewport_width_bind))
	$(embed_display(window_dpr_bind))
	
	""")
end

# ╔═╡ 01e839e5-8cb4-4402-a5a3-ff2fdc89c035
begin
	viewport_height, viewport_width, window_dpr
	MINDFulPluto.viewport_settings["width"] = viewport_width
	MINDFulPluto.viewport_settings["height"] = viewport_height
	MINDFulPluto.viewport_settings["dpr"] = window_dpr
end

# ╔═╡ 00af9143-eebf-4d20-9ab2-5038070efc66
begin
	#inputs for intent commands
	intent_command_bind = @bind intent_command html"""<input type="text" id="intentCommandTextField" value="">"""
	
	@htl("""

	$(embed_display(intent_command_bind))
	
	""")
end

# ╔═╡ 1921d610-5308-4c4f-8a2b-54a067024701
MINDFulPluto.handle_command(intent_command)

# ╔═╡ 4838aca7-d253-42a7-9eb1-d3a74040d4af
#MINDFulPluto.update_width_devving()

# ╔═╡ 1f562bd9-17fe-49cb-83d0-11480eb4afca
MINDFulPluto.insert_scripts()

# ╔═╡ daceb10a-f60c-4f4f-b2ac-ff8bf68f8c8a
MINDFulPluto.intent_list

# ╔═╡ 77b3716e-aac5-47f0-8618-253afc079b4b
MINDFulPluto.draw_args

# ╔═╡ Cell order:
# ╠═5145f6b7-ddb7-45ac-a3c7-fb30dc364f15
# ╟─0c8710c0-bdd0-46a0-9e0a-76565e074430
# ╠═247ea030-8bd4-11ee-1923-2914682ad01e
# ╟─1fbb319e-8a8e-40cc-acc2-58a5a07ac275
# ╟─36ded27e-079a-4bed-9d94-abd6314ddca8
# ╟─dcad27db-f258-4ac8-a17b-21397933a3a1
# ╠═0ed42b9e-dba7-40cb-b58d-7bd306dd384e
# ╠═01e839e5-8cb4-4402-a5a3-ff2fdc89c035
# ╠═00af9143-eebf-4d20-9ab2-5038070efc66
# ╠═1921d610-5308-4c4f-8a2b-54a067024701
# ╠═4838aca7-d253-42a7-9eb1-d3a74040d4af
# ╠═1f562bd9-17fe-49cb-83d0-11480eb4afca
# ╠═daceb10a-f60c-4f4f-b2ac-ff8bf68f8c8a
# ╠═77b3716e-aac5-47f0-8618-253afc079b4b
