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