$(function () {
    window.addEventListener("message", function (event) {
      var convertedMinutes = event.data.sleeptimer
  
      convertedMinutes = Math.floor(event.data.sleeptimer / 60)
      convertedSeconds = Math.floor(event.data.sleeptimer % 60)
      let min = convertedMinutes < 10 ? `0${convertedMinutes}` : convertedMinutes;
      let sec = convertedSeconds < 10 ? `0${convertedSeconds}` : convertedSeconds;
  
      var item = event.data;
      // Desmaiado
      if (item.action == "display") {
        $(".main-content").css("display", "flex");
        $(".title").html(item.message);
        $("#clock").html(`${min == 0 ? '00': min}:${sec == 0 ? '00': sec}`);
      } else if(item.action == "hide") {
        $(".main-content").css("display", "none");
      }
    });
  });