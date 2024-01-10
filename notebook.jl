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

# ╔═╡ 2b86cc8a-a550-4943-95dc-55b60684ec54


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
        _n1_btn = @bind arg_node_1 html"""
        <!--html-->
            <select class="form-select btn btn-outline-light btn-lg domain node_selection_select_1" aria-label="Node 1">
                <option selected>Node 1</option>
                <option value=1>1</option>
                <option value=2>2</option>
                <option value=3>3</option>
            </select>
        <!--!html-->
        """
        _n2_btn = @bind arg_node_2 html"""
        <!--html-->
            <select class="form-select btn btn-outline-light btn-lg domain node_selection_select_2" aria-label="Node 2">
                <option selected>Node 2</option>
                <option value=1>1</option>
                <option value=2>2</option>
                <option value=3>3</option>
            </select>
        <!--!html-->
        """
        _n1_sn = @bind arg_domain_1 html"""
        <!--html-->
            <select class="form-select btn btn-outline-light btn-lg domain domain_selection_select" aria-label="Domain 1">
                <option selected>Domain 1</option>
                <option value=1>1</option>
                <option value=2>2</option>
                <option value=3>3</option>
            </select>
        <!--!html-->
        """
        _n2_sn = @bind arg_domain_2 html"""
        <!--html-->
            <select class="form-select btn btn-outline-light btn-lg domain domain_selection_select" aria-label="Domain 2">
                <option selected>Domain 2</option>
                <option value=1>1</option>
                <option value=2>2</option>
                <option value=3>3</option>
            </select>
        <!--!html-->
        """

        create_intent_bind = @bind create_intent html"""
        <!--html-->
            <button class="btn btn-outline-light btn-lg create-intent node">
              Create Intent
            </button>
        <!--!html-->
        """

        plot_selection_bind = @bind plot_selection html"""
        <!--html-->
            <select class="form-select intent-list btn btn-outline-light btn-lg node" aria-label="Plotting type">
                <option>Plotting type</option>
                <option selected>intentplot</option>
                <option>ibnplot</option>
            </select>
        <!--!html-->
        """

        draw_button_bind = @bind draw_button html"""
        <!--html-->
        <button class="btn btn-outline-light btn-lg create-intent node">
              Draw
          </button>
          <!--!html-->
          """

        compile_button_bind = @bind compile_button html"""
        <!--html-->
        <button class="btn btn-outline-light btn-lg create-intent node">
              Compile
          </button>
          <!--!html-->
          """

        uncompile_button_bind = @bind uncompile_button html"""
        <!--html-->
        <button class="btn btn-outline-light btn-lg create-intent node">
              Uncompile
          </button>
          <!--!html-->
          """

        install_button_bind = @bind install_button html"""
        <!--html-->
        <button class="btn btn-outline-light btn-lg create-intent node">
              Install
          </button>
          <!--!html-->
          """

        uninstall_button_bind = @bind uninstall_button html"""
        <!--html-->
        <button class="btn btn-outline-light btn-lg create-intent node">
              Uninstall
          </button>
          <!--!html-->
          """

        dev_mode_button_bind = @bind dev_mode_button html"""
        <!--html-->
            <button class="btn btn-outline-light btn-lg create-intent node">
                Developer Mode
            </button>
        <!--!html-->
        """

        _intent_selection = @bind intent_selection html"""
        <!--html-->
        <select class="form-select intent-list btn btn-outline-light btn-lg node" aria-label="Intent" id="intent_selection_select">
        		 <option selected>Select Intent</option>
        </select>
        <!--!html-->
        """

        _wanted_pos = @bind wanted_pos html"""
        <!--html-->
        <select class="form-select intent-list btn btn-outline-light btn-lg node" aria-label="Position" id="wanted_pos_select">
        	<option selected>Position</option>
        	<option>2</option>
        	<option>3</option>
        </select>
        <!--!html-->"""

        _topology = @bind topology html"""
        <!--html-->
        <select class="form-select intent-list btn btn-outline-light btn-lg node" aria-label="Topology" id="topology_select">
            <option selected>Topology</option>
            <option>4nets</option>
            <option>nobel-germany</option>
            <option>nobel-germany-france-topzoo</option>
        </select>
        <!--!html-->"""

        html_div = @htl("""
 	<!--html-->
     <body>
     <div class="d-flex align-items-center justify-content-center">
     <div class=" d-flex main-card">
         <div class="left-wrapper">
             <div class="top-desc d-flex align-items-center">
                 <span class="container-fluid title-span justify-content-center align-items-center input-group-text no-border">MINDFulPlutoGUI v0.1</span>
             </div>


             <div class="menu-bar">
                 <div class="container">
                     <div class="row menu-buttons">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap" onclick="

                        //show all cards 
                        document.querySelectorAll('.card').forEach((card, i) => {
                            card.style.display = 'block';
                        });

                        //hide last 2 cells 
                        var cells = document.querySelectorAll('.show_input ');
                        cells = Array.prototype.slice.call(cells, -2);
                        cells.forEach((cell, i) => {
                            cell.style.display = 'none';
                        });

                        document.querySelectorAll('.code_folded').forEach((card, i) => {
                                //if col in className of card 
                                if (card.className.includes('col')) {
                                    card.style.display = 'none';
                                }
                        });


                        cells = document.querySelectorAll('.code_folded ');
                        cells = Array.prototype.slice.call(cells, -2);

                        cells.forEach((cell, i) => {
                            cell.querySelector('.cm-editor').style.background = 'transparent';

                            cell.style.display = 'inline-block';
                            cell.style.verticalAlign = 'top';
                            cell.style.width = '30vw';
                            cell.style.maxWidth = '30vw';
                            cell.style.height = '50vh';
                            cell.style.margin = '2.5%';
                            cell.style.textAlign = 'start';

                            cell.style.background = 'rgba(217, 147, 232, 0.1)';
                            cell.style.borderRadius = '16px';
                            cell.style.boxShadow = '0 4px 30px rgba(0, 0, 0, 0.1)';

                            cell.style.padding = '20px 20px 20px 20px';

                            //find element pluto-trafficlight
                            cell.querySelector('pluto-trafficlight').style.display = 'none';

                            var log_container = cell.querySelector('pluto-logs-container');
                            if (log_container != null) {
                                log_container.style.display = 'transparent';
                            }

                            //remove pluto-log-icon
                            var log_icon = cell.querySelector('pluto-log-icon');
                            if (log_icon != null) {
                                log_icon.style.display = 'none';
                            }

                            //find class=Stdout and change style 
                            var stdout = cell.querySelector('pluto-log-dot')
                            if (stdout != null) {
                                stdout.style.background = 'transparent';
                                stdout.style.border = '2px solid #FFFFFF';
                            }
                            
                            var rich_output = cell.querySelector('pluto-output');
                            if (rich_output != null) {
                                rich_output.style.borderRadius = '16px';
                                rich_output.style.background = 'black';
                            }
                            

                        });

                        var p_nb = document.getElementsByTagName('pluto-notebook')[0];
                        p_nb.style.marginTop = '31vh';
                        p_nb.style.marginLeft = '20vw';
                        p_nb.style.marginRight = '-25vw';
                        p_nb.style.backgroundColor = 'transparent';

                        
                         
                      
                     ">
                             Visualisation
                         </button>
                     </div>
                     <div class="row menu-buttons">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap">
                             Topology settings
                         </button>
                    </div>
                    <div class="row menu-buttons">
                        <button class="btn btn-outline-light btn-lg create-intent text-nowrap" onclick="

                            //hide all cards 
                            document.querySelectorAll('.card').forEach((card, i) => {
                                card.style.display = 'none';
                            });

                            Array.prototype.slice.call(document.querySelectorAll('.code_folded'), -3).forEach((card, i) => {
                                //if col in className of card 

                                card.style.display = 'none';
                            });

                            //get last 3 cells 
                            var cells = document.querySelectorAll('.show_input ');

                            //only last 3 cells 
                            cells = Array.prototype.slice.call(cells, -2);

                            //move cells to top of screen in a grid 
                            cells.forEach((cell, i) => {
                                cell.querySelector('.cm-editor').style.background = 'transparent';

                                cell.style.display = 'inline-block';
                                cell.style.verticalAlign = 'top';
                                cell.style.width = '30vw';
                                cell.style.margin = '2.5%';
                                cell.style.textAlign = 'start';

                                cell.style.background = 'rgba(217, 147, 232, 0.1)';
                                cell.style.borderRadius = '16px';
                                cell.style.boxShadow = '0 4px 30px rgba(0, 0, 0, 0.1)';

                                cell.style.padding = '20px 20px 20px 20px';

                                //find element pluto-trafficlight
                                cell.querySelector('pluto-trafficlight').style.display = 'none';

                                var log_container = cell.querySelector('pluto-logs-container');
                                if (log_container != null) {
                                    log_container.style.display = 'transparent';
                                }

                                //remove pluto-log-icon
                                var log_icon = cell.querySelector('pluto-log-icon');
                                if (log_icon != null) {
                                    log_icon.style.display = 'none';
                                }

                                //find class=Stdout and change style 
                                var stdout = cell.querySelector('pluto-log-dot')
                                if (stdout != null) {
                                    stdout.style.background = 'transparent';
                                    stdout.style.border = '2px solid #FFFFFF';
                                }
                                
                                

                            });

                            //change pluto-notebook style 
                            var p_nb = document.getElementsByTagName('pluto-notebook')[0];
                            p_nb.style.marginTop = '1.5vh';
                            p_nb.style.marginLeft = '20vw';
                            p_nb.style.marginRight = '-25vw';
                            p_nb.style.backgroundColor = 'transparent';

                            


                            
                         
                        ">
                             Developer Mode
                        </button>
                     </div>
                     <div class="row menu-buttons">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap">
                             Alternative GUI?
                         </button>
                     </div>
                     <div class="row menu-buttons settings">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap">
                             Dashboard settings
                         </button>
                     </div>
                 </div>
             </div>


         </div>

         <div class="container-fluid content">

             <div class="row flex-nowrap">
                 <div class="col">

                     <div class="card">
                         <div class="card-header text-center">
                             Intent Creation
                         </div>
                         <div class="card-body">

                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(_n1_sn))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(_n1_btn))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(_n2_sn))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(_n2_btn))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(create_intent_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(_topology))
                                 </div>
                             </div>

                         </div>
                     </div>

                 </div>
                 <div class="col">

                     <div class="card">
                         <div class="card-header text-center">
                             Intent Editing
                         </div>
                         <div class="card-body">

                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                     <select class="form-select btn btn-outline-light btn-lg node" aria-label="Node 1">
                                         <option selected>Comp algo</option>
                                         <option value=1>1</option>
                                         <option value=2>2</option>
                                         <option value=3>3</option>
                                     </select>
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                     <button class="btn btn-outline-light btn-lg create-intent node">
                                         Remove
                                     </button>
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(compile_button_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(uncompile_button_bind))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(install_button_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(uninstall_button_bind))
                                 </div>
                             </div>

                         </div>
                     </div>


                 </div>
                 <div class="col">
                     <div class="card">
                         <div class="card-header text-center">
                             Drawing
                         </div>
                         <div class="card-body">

                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(_intent_selection))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(draw_button_bind))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(plot_selection_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                     <button class="btn btn-outline-light btn-lg create-intent node">
                                         Remove
                                     </button>
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $(embed_display(_wanted_pos))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                     <button class="btn btn-outline-light btn-lg create-intent node">
                                         Placeholder
                                     </button>
                                 </div>
                             </div>

                         </div>
                     </div>
                 </div>
             </div>

         </div>
     </div>
 </div>
 </body>

 	<style>

        body {
            background: linear-gradient(40deg, hsla(237, 90%, 4%, 1) 0%, hsla(266, 85%, 20%, 1) 100%);
            
        }
        
        .main {
            height: 30vh;
        }
        
        .main-card {
            width: 90vw;
            height: 90vh;
        
            margin: 5vh 0 5vh 0;
        
            background: rgba(251, 168, 255, 0.12);
            border-radius: 16px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }
        
        .menu-bar {
            height: 80vh;
            width: 10vw;
            padding: 2vh 1vw 2vh 1vw;
            margin: 2vh 2vw 2vh 2vh;

            padding-left: 12px;
            padding-right: 12px;
        }
        
        .top-desc {
            width: 10vw;
            height: 4vh;
            padding: 2vh 1vw 2vh 1vw;
            margin: 2vh 2vw 2vh 2vh;
        
            /*font-weight: bold;*/
            font-size: 16px;
            color: white;
        
            /*background: rgba(144, 81, 224, 0.34) !important;*/

            padding-left: 12px;
            padding-right: 12px;
        }
        
        .heading {
        
        }
        
        .menu-buttons {
            padding: 0vh 0 2vh 0;
            height: 5vh;
        }
        
        .settings {
            margin-top: 52vh;
        }
        
        .content {
            padding: 2vh 2vw 2vh 2vw;
        }
        
        .card, .menu-bar, .top-desc {
            background: rgba(217, 147, 232, 0.1);
            border-radius: 16px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            /*backdrop-filter: blur(10.2px);*/
        }
        
        .card-header {
            padding: 20px 20px 0px 20px;
            font-weight: bold;
            font-size: 30px;
            color: white;
        }
        
        .domain, .node {
            max-width: 10vw;
            margin: 1vh 0vw 0 0;
            width: 10vw;
            min-width: 4vw;
        }
        
        .create-intent {
            width: 10vw;
            min-width: 5vw;
        }

        .title-span {
            font-weight: bold;
            font-size: 16px;
            color: white;
            background: transparent;
            border: none;
        }
        
        /*.div-creating {*/
        /*    width: 30vw;*/
        /*    margin-left: 10vw;*/
        /*}*/
        
        .div-editing {
            width: 50vw;
            margin-right: 10vw;
        }
        
        .create-intent:hover, .domain:hover, .node:hover, .domain:focus, .node:focus {
            background: #359b9b;
            color: white;
        }
        
        .create-intent:focus {
            background-color: rgba(255, 255, 255, 0);
        
        }

    </style>
 	<!--!html-->
    """)


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

# ╔═╡ f30d7fa3-8065-40b6-b428-226e1ce95cf7


# ╔═╡ 4fbae048-e383-41da-bb76-10d23241b15d
MINDFulPlutoGUI.update_domain_and_node_list("domain", topology)

# ╔═╡ 04b12cc9-e83c-46c7-b3fb-12bd01a56c40
MINDFulPlutoGUI.update_domain_and_node_list("node1", arg_domain_1)

# ╔═╡ 744c90ce-02a9-4924-874c-9de65209d557
MINDFulPlutoGUI.update_domain_and_node_list("node2", arg_domain_2)

# ╔═╡ aa5dbee4-f5eb-4889-a0d5-8b9014570409
MINDFulPlutoGUI.resize_cells()

# ╔═╡ c7fcbb44-29c2-471b-bab1-4d4b591840f4
MINDFulPlutoGUI.trigger_update_of_draw_cell(draw_button)

# ╔═╡ d24883ee-716b-421e-a8f5-ac0a3fcab60e


# ╔═╡ daceb10a-f60c-4f4f-b2ac-ff8bf68f8c8a
MINDFulPlutoGUI.intent_list

# ╔═╡ 77b3716e-aac5-47f0-8618-253afc079b4b
"Hello world"

# ╔═╡ Cell order:
# ╠═5145f6b7-ddb7-45ac-a3c7-fb30dc364f15
# ╟─0c8710c0-bdd0-46a0-9e0a-76565e074430
# ╠═247ea030-8bd4-11ee-1923-2914682ad01e
# ╠═f22fce0f-bc83-4903-9597-c8ae00e8c8e7
# ╠═eb0ca9a4-7d10-4f77-ac7d-30d845bbfba4
# ╠═8024c5f9-bfe8-4fae-a6e1-0364b5688950
# ╠═e6a036b2-a202-40b8-ba97-b664d148b770
# ╠═2b86cc8a-a550-4943-95dc-55b60684ec54
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
# ╠═f30d7fa3-8065-40b6-b428-226e1ce95cf7
# ╠═4fbae048-e383-41da-bb76-10d23241b15d
# ╠═04b12cc9-e83c-46c7-b3fb-12bd01a56c40
# ╠═744c90ce-02a9-4924-874c-9de65209d557
# ╠═aa5dbee4-f5eb-4889-a0d5-8b9014570409
# ╠═c7fcbb44-29c2-471b-bab1-4d4b591840f4
# ╠═d24883ee-716b-421e-a8f5-ac0a3fcab60e
# ╠═daceb10a-f60c-4f4f-b2ac-ff8bf68f8c8a
# ╠═77b3716e-aac5-47f0-8618-253afc079b4b
