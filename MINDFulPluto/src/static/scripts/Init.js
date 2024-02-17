function initJS() {
    tsparticlesWrapper();
    reformatNotebook();

    updateButtonAvailabilities();
    sendIntentCommand("update_ui");
}

async function waitTillPageLoad() {
    // while (document.readyState !== "complete") {
    //     await new Promise(resolve => setTimeout(resolve, 100));
    //     console.log(document.readyState);
    // }

    while (true) {
        try {
            add_toast_to_div("MINDFulPluto.jl", "Page loaded.");
            
            //get toast div
            let toastContainer = document.getElementById("toast_container");
            //remove all children
            while (toastContainer.firstChild) {
                toastContainer.removeChild(toastContainer.firstChild);
            }
            break;
        }
        catch (e) {
            await new Promise(resolve => setTimeout(resolve, 1000));
            console.log(document.readyState);
        }

    }

    initJS();
}
waitTillPageLoad();
