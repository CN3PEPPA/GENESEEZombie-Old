$(document).ready(function() {
    window.addEventListener("message", function(event) {
        var html = ""

        if (event.data.mode == 'sucesso') {
            html = "<div id='showitem'><b><sucesso>+</sucesso> " + event.data.item + "</b></div>"
        }

        if (event.data.mode == 'negado') {
            html = "<div id='showitem'><b><negado>-</negado> " + event.data.item + "</b></div>"
        }

        $(html).fadeIn(500).appendTo("#notifyitens").delay(5000).fadeOut(500);
    })
});