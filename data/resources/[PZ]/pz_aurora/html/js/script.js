$(document).ready(function () {
  window.addEventListener("message", function (event) {
    
    let data = event.data.type;
    let value = event.data.content;

    if (data == 'showMenu' && value == true) {
      $("body").css('display', 'flex');
    }

    if (data == 'showMenu' && value == false) {
      $("body").css('display', 'none');
    }

    document.onkeyup = function (data) {
      if (data.which == 27) {
        $("body").hide(200);
        $.post('https://pz_aurora/close', JSON.stringify({}));
      }
    }

  });

  var page = 1

  function showPage(page) {
    $('img').hide(200);
    $(`#${page}`).show(200);
  }

  $('#btnBack').click( e => {
    if ( page > 1 ){
      page--
      showPage(page)
    }
  });
  $('#btnForward').click( e => {
    if ( page < 9 ){
      page++
      showPage(page)
    }
  });
});
