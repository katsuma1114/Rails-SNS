import $ from 'jquery'
import axios from 'modules/axios'
import {
  handleHeartDisplay,
  listenInactiveHeartEvent,
  listenActiveHeartEvent
} from 'modules/handle_heart'

document.addEventListener('DOMContentLoaded', () => {
  $('.active-heart').each(function() {
    const articleId = $(this).attr('id')
    //いいね機能
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
})

