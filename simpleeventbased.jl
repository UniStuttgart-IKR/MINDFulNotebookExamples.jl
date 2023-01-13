### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# ╔═╡ bac63278-6578-42bc-b4a0-4e88cf860dce
import Pkg

# ╔═╡ a91bcfcd-06ae-4ae9-a87a-add45f09a3c0
Pkg.activate(".")

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
md"# Doing event based simulation with `MINDFul.jl`"

# ╔═╡ 2b686237-bd05-42f4-90b7-33a6096753ca
Pkg.instantiate()

# ╔═╡ Cell order:
# ╠═839bc204-f9cf-4d6f-be1c-291fdd038f22
# ╟─7448a4ee-c29a-42c8-ab7e-9b1086ac1b55
# ╠═bac63278-6578-42bc-b4a0-4e88cf860dce
# ╠═a91bcfcd-06ae-4ae9-a87a-add45f09a3c0
# ╠═2b686237-bd05-42f4-90b7-33a6096753ca
