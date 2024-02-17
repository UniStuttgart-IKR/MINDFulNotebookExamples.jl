function updateIntentTable(intent_names, intent_configs, intent_toplogies, intent_states) {
    const buttonStates = {
        "uncompiled": {
            "remove": "",
            "compile": "",
            "uncompile": "disabled",
            "install": "disabled",
            "uninstall": "disabled"
        },
        "compiled": {
            "remove": "disabled",
            "compile": "disabled",
            "uncompile": "",
            "install": "",
            "uninstall": "disabled"
        },
        "installed": {
            "remove": "disabled",
            "compile": "disabled",
            "uncompile": "disabled",
            "install": "disabled",
            "uninstall": ""
        }
    }



    //find intent list
    let intent_list = document.querySelector("#intent_selection_select");

    //find out which option was selected in intent_list
    let selected_value = intent_list.value;

    //clear intent list except first option
    while (intent_list.options.length > 1) {
        intent_list.remove(1);
    }

    //add intents to intent list
    intent_names.forEach((intent, i) => {
        let option = document.createElement("option");
        option.value = intent;
        option.innerHTML = intent;
        //check if intent was selected
        if (selected_value != undefined) {
            if (selected_value == intent) {
                option.selected = true;
            }
        }
        intent_list.appendChild(option);
    });
    console.log("updated intent list with selected intent: " + selected_value);

    //---------update intent-table---------

    console.log(intent_states);
    let intent_table = document.querySelector(".table > tbody");

    //clear all <tr> except first one
    while (intent_table.childElementCount > 0) {
        intent_table.removeChild(intent_table.lastChild);
    }

    //add new <tr> for each intent
    intent_names.forEach((intent_name, index) => {
        let new_row = document.createElement("tr");
        new_row.innerHTML = `
            <th scope="row">${index + 1}</th>
            <td>${intent_name}</td>
            <td>${intent_toplogies[index]}</td>
            <td>${intent_configs[index]}</td>
            <td>${intent_states[index]}</td>
            <td class="action-buttons">
                            <button class='btn btn-outline-light btn-sm ${buttonStates[intent_states[index]].remove}' onclick='sendIntentCommand("remove_intent ${index + 1}")'>
                                Remove
                            </button>
                            <button class='btn btn-outline-light btn-sm ${buttonStates[intent_states[index]].compile}' onclick='sendIntentCommand("compile_intent ${index + 1}")'>
                                Compile
                            </button>
                            <button class='btn btn-outline-light btn-sm ${buttonStates[intent_states[index]].uncompile}' onclick='sendIntentCommand("uncompile_intent ${index + 1}")'>
                                Uncompile
                            </button>
                            <button class='btn btn-outline-light btn-sm ${buttonStates[intent_states[index]].install}' onclick='sendIntentCommand("install_intent ${index + 1}")'>
                                Install
                            </button>
                            <button class='btn btn-outline-light btn-sm ${buttonStates[intent_states[index]].uninstall}' onclick='sendIntentCommand("uninstall_intent ${index + 1}")'>
                                Uninstall
                            </button>
                        </td>
        `;
        intent_table.appendChild(new_row);
    });


}

function updateDomainListJS(domain_names) {
    console.log(domain_names)
    //find domain list
    let domain_lists = document.querySelectorAll(".domain_selection_select");

    //for each domain list
    domain_lists.forEach((domain_list, j) => {
        //find out which option was selected in domain_list
        let selected_value = domain_list.value;


        //clear domain list except first option
        while (domain_list.options.length > 1) {
            domain_list.remove(1);
        }


        //add domains to domain list

        domain_names.forEach((domain, i) => {
            let option = document.createElement("option");
            option.value = domain;
            option.innerHTML = domain;
            //check if domain was selected
            if (selected_value != undefined) {
                if (selected_value == domain) {
                    option.selected = true;
                }
            }

            domain_list.appendChild(option);

        });
    });

    //reset domain list to first option
    domain_lists.forEach((domain_list, j) => {
        domain_list.value = domain_list.options[0].value;
    });


    add_toast_to_div('MINDFulPluto.jl', 'Topology loaded.')
}

function updateNodeListJS(nodes, nodeNumber) {
    console.log(nodes)
    //find node list
    let node_list = document.querySelector(`.node_selection_select_${nodeNumber}`);


    //find out which option was selected in node_list
    let selected_value = node_list.value;


    //clear node list except first option
    while (node_list.options.length > 1) {
        node_list.remove(1);
    }


    //add nodes to node list

    nodes.forEach((node, i) => {
        let option = document.createElement("option");
        option.value = node;
        option.innerHTML = node;
        //check if node was selected
        if (selected_value != undefined) {
            if (selected_value == node) {
                option.selected = true;
            }
        }

        node_list.appendChild(option);

    });
}

function updateDomainDrawingList(domains) {
    const domainDrawingList = document.querySelector("#domain_drawing_select");

    while (domainDrawingList.options.length > 1) {
        domainDrawingList.remove(1);
    }

    domains.forEach((domain, i) => {
        let option = document.createElement("option");
        option.value = domain;
        option.innerHTML = domain;
        domainDrawingList.appendChild(option);
    });
}

function updateButtonAvailabilities() {
    const domain1 = document.querySelector("#domain_selection_1");
    const domain2 = document.querySelector("#domain_selection_2");
    const node1 = document.querySelector("#node_selection_1");
    const node2 = document.querySelector("#node_selection_2");
    const topology = document.querySelector("#topology_select");

    const intentSelection = document.querySelector("#intent_selection_select");
    const plottingType = document.querySelector("#plot_selection_select");
    const position = document.querySelector("#wanted_pos_select");
    const domainDrawing = document.querySelector("#domain_drawing_select");

    //if all selected indexes are not 0, enable create_intent button
    if (domain1.selectedIndex != 0 && domain2.selectedIndex != 0 && node1.selectedIndex != 0 && node2.selectedIndex != 0 && topology.selectedIndex != 0) {
        document.querySelector("#create_intent").disabled = false;
    } else {
        document.querySelector("#create_intent").disabled = true;
    }

    //if topology is selected, enable both domain buttons
    if (topology.selectedIndex != 0) {
        domain1.disabled = false;
        domain2.disabled = false;
    } else {
        domain1.disabled = true;
        domain2.disabled = true;
    }

    //if domain1 is selected, enable node1 button
    if (domain1.selectedIndex != 0) {
        node1.disabled = false;
    } else {
        node1.disabled = true;
    }

    //if domain2 is selected, enable node2 button
    if (domain2.selectedIndex != 0) {
        node2.disabled = false;
    } else {
        node2.disabled = true;
    }

    //Drawing

    //if intentSelection, plottingType, position and domainDrawing are selected, enable draw_intent button
    if (intentSelection.selectedIndex != 0 && plottingType.selectedIndex != 0 && position.selectedIndex != 0 && domainDrawing.selectedIndex != 0) {
        document.querySelector("#draw_intent").disabled = false;
    } else {
        document.querySelector("#draw_intent").disabled = true;
    }

    //if intentSelection is selected, enable plottingType
    if (intentSelection.selectedIndex != 0) {
        plottingType.disabled = false;
    } else {
        plottingType.disabled = true;
    }

    //if plottingType is selected, enable domainDrawing
    if (plottingType.selectedIndex != 0) {
        domainDrawing.disabled = false;
    } else {
        domainDrawing.disabled = true;
    }

    //if position is selected, enable remove button
    if (position.selectedIndex != 0) {
        document.querySelector("#remove_plot").disabled = false;
    } else {
        document.querySelector("#remove_plot").disabled = true;
    }
}