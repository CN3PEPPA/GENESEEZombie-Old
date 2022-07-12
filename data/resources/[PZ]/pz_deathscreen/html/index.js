$(function () {
  window.addEventListener("message", function (event) {
    var convertedMinutes = event.data.deathtimer

    convertedMinutes = Math.floor(event.data.deathtimer / 60)
    convertedSeconds = Math.floor(event.data.deathtimer % 60)
    let min = convertedMinutes < 10 ? `0${convertedMinutes}` : convertedMinutes;
    let sec = convertedSeconds < 10 ? `0${convertedSeconds}` : convertedSeconds;

    var item = event.data;
    // Desmaiado
    if (item.setDisplay) {
      $(".main-content").css("display", "flex");
      $("#clock").html(`${min == 0 ? '00': min}:${sec == 0 ? '00': sec}`);
    } else {
      $(".main-content").css("display", "none");
    }
    if (min <= 12 ) {
      $(".btn-surrender").css("display", "flex")
    }
  });
});

function abrirModal() {
  document.getElementById("popup-1").classList.toggle("active");
}

function fecharModal() {
  document.getElementById("popup-1").classList.toggle("active");
}

function simAceita() {
  document.getElementById("popup-1").classList.toggle("active");
  $.post("https://pz_deathscreen/ButtonRevive");
}