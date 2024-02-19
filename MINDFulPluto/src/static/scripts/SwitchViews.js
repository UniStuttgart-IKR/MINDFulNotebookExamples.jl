function changeViewDisplay(target, visible) {
    const display = visible ? 'block' : 'none';
    const display_flex = visible ? 'flex' : 'none';

    if (visible === true) {
        //hide everything
        changeViewDisplay('visualisation', false);
        changeViewDisplay('intenttable', false);
        changeViewDisplay('devmode', false);
    }

    switch (target) {
        case "visualisation":
            //hide content > .row (vis)
            document.querySelectorAll('.content > .row').forEach((card, i) => {
                card.style.display = display_flex;
            });

            //hide plotting cells
            Array.prototype.slice.call(document.querySelectorAll('.code_folded'), -2).forEach((card, i) => {
                card.style.display = display;
            });

            if (visible === true) {
                setVisualisationModeCellStyle();
            }
            break;

        case "intenttable":
            //hide content > .table-container
            document.querySelectorAll('.content > .table-container').forEach((card, i) => {
                card.style.display = display_flex;
            });
            break;

        case "devmode":
            //hide last 2 cells (dev mode)
            let cells = document.querySelectorAll('.show_input ');
            cells = Array.prototype.slice.call(cells, -2);
            cells.forEach((cell, i) => {
                cell.style.display = display;
            });

            if (visible === true) {
                setDevmodeCellStyle();
            }

            break;

        default:
            break;
    }
}

function setVisualisationModeCellStyle() {
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

        let log_container = cell.querySelector('pluto-logs-container');
        if (log_container != null) {
            log_container.style.display = 'transparent';
        }

        //remove pluto-log-icon
        let log_icon = cell.querySelector('pluto-log-icon');
        if (log_icon != null) {
            log_icon.style.display = 'none';
        }

        //find class=Stdout and change style 
        let stdout = cell.querySelector('pluto-log-dot')
        if (stdout != null) {
            stdout.style.background = 'transparent';
            stdout.style.border = '2px solid #FFFFFF';
        }

        let rich_output = cell.querySelector('pluto-output');
        if (rich_output != null) {
            rich_output.style.borderRadius = '16px';
            rich_output.style.background = 'black';
        }


    });

    let p_nb = document.getElementsByTagName('pluto-notebook')[0];
    p_nb.style.marginTop = '31vh';
    p_nb.style.marginLeft = '20vw';
    p_nb.style.marginRight = '-25vw';
    p_nb.style.backgroundColor = 'transparent';
}

function setDevmodeCellStyle() {
    //get last 3 cells 
    let cells = document.querySelectorAll('.show_input ');

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

        let log_container = cell.querySelector('pluto-logs-container');
        if (log_container != null) {
            log_container.style.display = 'transparent';
        }

        //remove pluto-log-icon
        let log_icon = cell.querySelector('pluto-log-icon');
        if (log_icon != null) {
            log_icon.style.display = 'none';
        }

        //find class=Stdout and change style 
        let stdout = cell.querySelector('pluto-log-dot')
        if (stdout != null) {
            stdout.style.background = 'transparent';
            stdout.style.border = '2px solid #FFFFFF';
        }



    });

    //change pluto-notebook style 
    let p_nb = document.getElementsByTagName('pluto-notebook')[0];
    p_nb.style.marginTop = '1.5vh';
    p_nb.style.marginLeft = '20vw';
    p_nb.style.marginRight = '-25vw';
    p_nb.style.backgroundColor = 'transparent';
}

function reformatNotebook() {
    //find body
    let body = document.querySelector("body");
    //set overflow hidden
    body.style.overflow = "hidden";


    //find <main>
    let main = document.querySelector("main");

    //set main style to max-width 100%
    main.style.maxWidth = "100%";
    //set main color to darkslategray

    //find rich-output class and remove backgroundColor
    document.querySelectorAll(".rich_output").forEach((cell, i) => {
        cell.style.background = "transparent";
    });

    //remove header
    document.querySelector("header").style.display = "none";

    //remove footer
    document.querySelector("footer").style.display = "none";


    //place first cell ath the top and 2nd cell at the bottom
    document.querySelectorAll(".code_folded ").forEach((cell, i) => {
        if (i == 0) {
            cell.style.display = "none";
        }
        else if (i == 1) {
            cell.style.position = "absolute";
            cell.style.top = "0";
            cell.style.left = "0";
            cell.style.width = "100%";
            cell.style.margin = "0";
        }
    });

    //hide shown cells
    document.querySelectorAll(".show_input").forEach((cell, i) => {
        cell.style.display = "none";
    });

    //hide div with class="helpbox-true hidden "
    document.querySelectorAll(".helpbox-true.hidden").forEach((cell, i) => {
        cell.style.display = "none";
    });

    //find title=Drag to move cell
    document.querySelectorAll("pluto-shoulder").forEach((cell, i) => {
        cell.style.display = "none";
        cell.style.width = "0px";
    });

    //find tag main and set class to container-fluid
    document.getElementsByTagName("main")[0].className = "container";
    //document.getElementsByTagName("main")[0].style += " padding-bottom: 0px;";


    //find tag pluto-notebook and set class to row
    document.getElementsByTagName("pluto-notebook")[0].className = "row";
    document.getElementsByTagName("pluto-notebook")[0].style = "width: 100vw;";
    document.getElementsByTagName("pluto-notebook")[0].style = "background: rgba(0,0,0,0) !important;";
    document.getElementsByTagName("pluto-notebook")[0].style = "margin-top: 30vh; margin-left:10vw; margin-right:10vw;";

    //find shown cells and set class to col except for the first one
    document.querySelectorAll(".code_folded").forEach((cell, i) => {
        if (i > 1) {
            cell.className += "col";
        } else {

        }
    });


    //show all cards 
    document.querySelectorAll('.card').forEach((card, i) => {
        card.style.display = 'block';
    });

    //hide last 2 cells 
    let cells = document.querySelectorAll('.show_input ');
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

        cell.style.padding = '1vw 1vw 1vw 1vw';

        //find element pluto-trafficlight
        cell.querySelector('pluto-trafficlight').style.display = 'none';

        let log_container = cell.querySelector('pluto-logs-container');
        if (log_container != null) {
            log_container.style.display = 'transparent';
        }

        //remove pluto-log-icon
        let log_icon = cell.querySelector('pluto-log-icon');
        if (log_icon != null) {
            log_icon.style.display = 'none';
        }

        //find class=Stdout and change style 
        let stdout = cell.querySelector('pluto-log-dot')
        if (stdout != null) {
            stdout.style.background = 'transparent';
            stdout.style.border = '2px solid #FFFFFF';
        }

        let rich_output = cell.querySelector('pluto-output');
        if (rich_output != null) {
            rich_output.style.borderRadius = '16px';
            rich_output.style.background = 'black';
        }


    });

    let p_nb = document.getElementsByTagName('pluto-notebook')[0];
    p_nb.style.marginTop = '31vh';
    p_nb.style.marginLeft = '20vw';
    p_nb.style.marginRight = '-25vw';
    p_nb.style.backgroundColor = 'transparent';
}