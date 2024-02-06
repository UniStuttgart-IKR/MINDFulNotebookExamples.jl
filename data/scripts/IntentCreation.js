function createIntent() {
    //find domain_selection_select and get value
    const domain_1 = document.querySelector("#domain_selection_1").value;
    const domain_2 = document.querySelector("#domain_selection_2").value;
    const node_1 = document.querySelector("#node_selection_1").value;
    const node_2 = document.querySelector("#node_selection_2").value;
    const topology = document.querySelector("#topology_select").value;

    sendIntentCommand(`create_intent ${domain_1} ${domain_2} ${node_1} ${node_2} ${topology}`)
}

function updateDomainList() {
    const topology = document.querySelector("#topology_select").value;

    sendIntentCommand(`update_domain_list ${topology}`)
}

function updateNodeList(node_number) {
    const domain = document.querySelector(`#domain_selection_${node_number}`).value;
    const topology = document.querySelector("#topology_select").value;

    sendIntentCommand(`update_node_list ${topology} ${domain} ${node_number}`)
}

function drawIntent() {
    const intent_index = document.querySelector("#intent_selection_select").selectedIndex;
    const plottingType = document.querySelector("#plot_selection_select").value;
    const position = document.querySelector("#wanted_pos_select").value;

    sendIntentCommand(`draw_intent ${intent_index} ${plottingType} ${position}`)
}