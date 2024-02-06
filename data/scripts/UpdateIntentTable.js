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