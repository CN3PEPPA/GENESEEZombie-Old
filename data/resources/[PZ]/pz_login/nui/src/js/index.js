$(function() {
    init();

    var actionContainer = $("body");

    window.addEventListener('message', function(event) {
        var item = event.data;

        if (item.showmenu) {
            $('body').css("display", "flex");
        }

        if (item.hidemenu) {
            actionContainer.fadeOut(200);
        }
    });
});

function init() {
    $("#auroraBtn").click(function() {
        var spawn = "aurora";
        dataSpawn(spawn);
    });

    $(".none").click(function() {
        dataSpawn("");
    });
}

function dataSpawn(data) {
    $.post("http://pz_login/ButtonClick", JSON.stringify(data), data => {});
}