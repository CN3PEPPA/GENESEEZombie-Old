$(function() {
  window.onload = (e) => {
      window.addEventListener('message', (event) => {
          var item = event.data;
          if (item.type === "ui") {
              if (item.display === true) {
                  $("#body").css('display', 'flex');
                  var start = new Date();
                  var maxTime = item.time;
                  var text = item.text;
                  var timeoutVal = Math.floor(maxTime / 100);
                  animateUpdate();

                  $('.progress-title').text(text);

                  function updateProgress(percentage) {
                    $('.progress-bar-inner').css("width", percentage + "%");
                  }

                  function animateUpdate() {
                      var now = new Date();
                      var timeDiff = now.getTime() - start.getTime();
                      var perc = Math.round((timeDiff / maxTime) * 100);
                      if (perc <= 100) {
                          updateProgress(perc);
                          setTimeout(animateUpdate, timeoutVal);
                      } else {
                          $("#body").css('display', 'none');
                      }
                  }
              } else {
                  $("#body").css('display', 'none');
              }
          }
      });
  };
});