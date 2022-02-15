import $ from 'jquery'
import axios from 'modules/axios'

//いいねの表示切り替え
const handleHeartDisplay = (hasLiked, articleId) => {
    if (hasLiked) {
      $('#' + articleId + '.active-heart').removeClass('hidden')
    } else {
      $('#' + articleId + '.inactive-heart').removeClass('hidden')
    }
  }
  
  //いいね機能
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
  //いいね解除機能
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

export {
    handleHeartDisplay,
    listenInactiveHeartEvent,
    listenActiveHeartEvent
}  