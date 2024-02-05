function getViewportSize() {
    var viewportWidth;
    var viewportHeight;
    // the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
    if (typeof window.innerWidth != 'undefined') {
        viewportWidth = window.innerWidth,
            viewportHeight = window.innerHeight
        windowDevicePixelRatio = window.devicePixelRatio
    }

    //TODO: Add DPR to older versions
    /* // IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
    else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0) {
        viewportWidth = document.documentElement.clientWidth,
        viewportHeight = document.documentElement.clientHeight
    }
    // older versions of IE
    else {
        viewportWidth = document.getElementsByTagName('body')[0].clientWidth,
        viewportHeight = document.getElementsByTagName('body')[0].clientHeight
    } */


    const viewportHeightInput = document.getElementById('viewportHeight');
    const viewportWidthInput = document.getElementById('viewportWidth');
    const windowDevicePixelRatioInput = document.getElementById('windowDevicePixelRatio');

    viewportHeightInput.value = viewportHeight;
    viewportHeightInput.dispatchEvent(new CustomEvent("input"));

    viewportWidthInput.value = viewportWidth;
    viewportWidthInput.dispatchEvent(new CustomEvent("input"));

    windowDevicePixelRatioInput.value = windowDevicePixelRatio;
    windowDevicePixelRatioInput.dispatchEvent(new CustomEvent("input"));

    console.log("Set viewport fields")
}

window.addEventListener("resize", () => {
    getViewportSize();
})

//while element windowDevicePixelRatio is not set, keep trying to set it
const vpIntervalID = setInterval(() => {
    if (document.getElementById('windowDevicePixelRatio').value == "") {
        getViewportSize();
    }
    else {
        clearInterval(vpIntervalID);
    }
}, 1000);