let prefix, category, sex, variation, id;

function sendData(data, url) {
  $.post('http://pz_clothing/' + url, JSON.stringify(data))
}

function selectPreview(data) {
  $('#variationId').html(variation);
  variation = 0
  category = data.category
  sex = data.sex
  prefix = data.prefix
  id = data.id

  id = {
    variation: variation,
    category: data.category,
    sex: data.sex,
    prefix: data.prefix,
    id: data.id
  }

  $('#colorSelection').show();
  sendData(id, 'previewClothing');
}

function selectVariation() {
  data = {
    variation: variation,
    category: category,
    sex: sex,
    prefix: prefix,
    id: id.id
  }
  sendData(data, 'previewClothing');
}

$('#downColor').click(() => {
  if (variation !== 0) {
    variation--;
  }
  $('#variationId').html(variation)
  selectVariation()
})
$('#upColor').click(() => {
  if (variation < 25) {
    variation++;
  }
  $('#variationId').html(variation)
  selectVariation()
})

$('#saveClothing').click(() => {
  data = {
    variation,
    category,
    sex,
    prefix,
    id: id.id
  }
  sendData(data, 'saveClothing')
  variation = 0
})

$(document).ready(function () {
  window.addEventListener("message", function (event) {

    $('#colorSelection').hide();

    let data = event.data.type;
    let value = event.data.content;
    let extras = event.data.extras;

    if (data == 'showMenu' && value == true) {
      $('#itemContainer').html('')
      $('#variationId').html(variation)

      for (let i = 0; i < extras.list.length; i++) {
        $(`
          <div class="item" onClick="selectPreview({
            category: '${extras.category}', 
            sex: '${extras.sex}', 
            prefix: '${extras.prefix}', 
            id: '${extras.list[i]}'
          })">
            <img src="https://arcadiuscity.com/sources/roupas/vrp_roupas/${extras.category}/${extras.sex}/${extras.prefix}(${extras.list[i]}).jpg" alt="item">
          </div>
        `).appendTo('#itemContainer')
      }

      $(".main-content").css('display', 'flex');
    }

    if (data == 'showMenu' && value == false) {
      $(".main-content").css('display', 'none');
    }

    document.onkeyup = function (data) {
      if (data.which == 27) {
        $('.main-content').hide(200);
        $.post('http://pz_clothing/close', JSON.stringify({}));
      }
    }
  })
});


