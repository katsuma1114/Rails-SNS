import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const handleHeartDisplay = (hasLiked, articleId) => {
  if (hasLiked) {
    $('#' + articleId + '.active-heart').removeClass('hidden')
  } else {
    $('#' + articleId + '.inactive-heart').removeClass('hidden')
  }
}

const listenInactiveHeartEvent = (articleId) => {
  $('#' + articleId + '.inactive-heart').on('click', () => {
    axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('#' + articleId + '.active-heart').removeClass('hidden')
          $('#' + articleId + '.inactive-heart').addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

const listenActiveHeartEvent = (articleId) => {
  $('#' + articleId + '.active-heart').on('click', () => {
    axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('#' + articleId + '.active-heart').addClass('hidden')
          $('#' + articleId + '.inactive-heart').removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

document.addEventListener('DOMContentLoaded', () => {
  $('.active-heart').each(function() {
    const articleId = $(this).attr('id')

    axios.get(`/articles/${articleId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked, articleId)
    })
    .catch((e) => {
      console.log(e)
    })

    listenInactiveHeartEvent(articleId)
    listenActiveHeartEvent(articleId)
  })

  //モーダル
  $(function () {
    $('#openModal').click(function(){
        $('#modalArea').fadeIn();
    });
    $('#closeModal').click(function(){
      $('#modalArea').fadeOut();
    });
  });

  //ツイッターにシェアするかどうかを確認（誤操作防止）
  $('.share-twitter').click(function(){
    if (!confirm('Twitterにシェアしますか？')) {
      return false;
    } else {
      return true;
    }
  })
})