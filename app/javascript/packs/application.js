// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {
  //モーダル
  $(function () {
    $('#openModal').click(function(){
        $('#modalArea').fadeIn();
    });
    $('#closeModal,#modalBg').click(function(){
      $('#modalArea').fadeOut();
    });
  });

  //モーダル2
  $('#openModal2').click(function(){
    $('#modalArea2').fadeIn();
  });
  $('#closeModal2').click(function(){
    $('#modalArea2').fadeOut();
  });

  //ツイッターにシェアするかどうかを確認（誤操作防止）
  $('.share-twitter').click(function(){
    if (!confirm('Twitterにシェアしますか？')) {
      return false;
    } else {
      return true;
    }
  })
  //avatar保存ボタン表示
  $('.avatar-upload').click(function(){
    $('.changed-file').removeClass('hidden')
  })
})