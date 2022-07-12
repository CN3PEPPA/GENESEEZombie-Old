$(function() {
    window.addEventListener("message", function (event) {
        var _ = event.data

        if (_.NotifyType == "sucesso") {
            $(`
            <div class='notify success'>
                <div class='notify-icon'>
                    <img class='icon' src='assets/sucesso.png'>
                </div>
                <div class='notify-content'>
                    <div class='notify-type'>Sucesso</div>
                    <div class='notify-text'>${_.NotifyString}</div>
                </div>
            </div>
        `).appendTo("#container").hide().fadeIn(750).delay(5000).fadeOut(750);
        }else if (_.NotifyType == "negado") {
            $(`
            <div class='notify error'>
                <div class='notify-icon'>
                    <img class='icon' src='assets/negado.png'>
                </div>
                <div class='notify-content'>
                    <div class='notify-type'>Erro</div>
                    <div class='notify-text'>${_.NotifyString}</div>
                </div>
            </div>
            `).appendTo("#container").hide().fadeIn(750).delay(5000).fadeOut(750);
        }else if (_.NotifyType == "anuncio") {
            $(`
            <div class='notify announce'>
                <div class='notify-icon'>
                    <img class='icon' src='assets/anuncio.png'>
                </div>
                <div class='notify-content'>
                    <div class='notify-type'>Anúncio</div>
                    <div class='notify-text'>${_.NotifyString}</div>
                </div>
            </div>
            `).appendTo("#container").hide().fadeIn(750).delay(15000).fadeOut(750);
        }else if (_.NotifyType == "aviso") {
            $(`
            <div class='notify warning'>
                <div class='notify-icon'>
                    <img class='icon' src='assets/aviso.png'>
                </div>
                <div class='notify-content'>
                    <div class='notify-type'>Aviso</div>
                    <div class='notify-text'>${_.NotifyString}</div>
                </div>
            </div>
            `).appendTo("#container").hide().fadeIn(750).delay(5000).fadeOut(750);
        }else if (_.NotifyType == "importante") {
            $(`
            <div class='notify important'>
                <div class='notify-icon'>
                    <img class='icon' src='assets/importante.png'>
                </div>
                <div class='notify-content'>
                    <div class='notify-type'>Importante</div>
                    <div class='notify-text'>${_.NotifyString}</div>
                </div>
            </div>
            `).appendTo("#container").hide().fadeIn(750).delay(5000).fadeOut(750);
        }
    })
})