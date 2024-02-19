function add_toast_to_div(heading, message) {
    let random_id_string = Math.floor(Math.random() * 10000).toString(36);
    console.log(random_id_string)
    const toastHTML = `
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false" 
        data-bs-delay="10000" id=${random_id_string}>
            <div class="toast-header bg-transparent">
                <strong class="me-auto">${heading}</strong>
                <small>0 seconds ago</small>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="progress" style="height: 1px;">
                <div class="progress-bar" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
            <div class="toast-body">
                ${message}           
            </div>       
        </div>
        `;

    const toastContainer = document.getElementById("toast_container");
    toastContainer.innerHTML = toastHTML + toastContainer.innerHTML;

    let toast = new bootstrap.Toast(document.getElementById(random_id_string));
    toast.show();

    jQuery(document).ready(function($) {
        $(`#${random_id_string}`).on('shown.bs.toast', function() {
            $(`#${random_id_string} > .progress > .progress-bar`).each(function(i) {
                // Todo: Create time variable from Toast
                let displayTime = $('.toast').attr('data-bs-delay');
                $(this).animate({
                    width: $(this).attr('aria-valuenow') + '%'
                });
                $(this).css({
                    webkittransition: 'width '+displayTime+'ms ease-in-out',
                    moztransition: 'width '+displayTime+'ms ease-in-out',
                    otransition: 'width '+displayTime+'ms ease-in-out',
                    transition: 'width '+displayTime+'ms ease-in-out'
                });
                // $(this).prop('Counter', 0).animate({
                //     Counter: $(this).attr('aria-valuenow')
                // }, {
                //     duration: 8000,
                //     step: function(now) {
                //         $(this).closest(".toast")
                //             .find(".progressbar-number")
                //             .text(Math.ceil(now));
                //     }
                // });
            });
        });
    })

    setTimeout(function () {
        let toast = new bootstrap.Toast(document.getElementById(random_id_string));
        toast.dispose();

        setTimeout(function () {
            toastContainer.removeChild(document.getElementById(random_id_string));
        }, 100);

    }, parseInt($('.toast').attr('data-bs-delay'), 10) + 400);

}