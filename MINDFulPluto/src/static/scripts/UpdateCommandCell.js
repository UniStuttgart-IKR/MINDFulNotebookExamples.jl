function sendIntentCommand(command) {
    const intentCommandTextField = document.getElementById('intentCommandTextField');
    
    intentCommandTextField.value = command;
    intentCommandTextField.dispatchEvent(new CustomEvent("input"));

    console.log("Sent intent command: " + command);
}