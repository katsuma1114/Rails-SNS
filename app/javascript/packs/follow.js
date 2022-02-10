import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'


axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

//フォローボタンの操作
const handleFollowBtn = (hasFollowed) => {
    if (hasFollowed) {
        $('.btn-following').removeClass('hidden')
      } else {
        $('.btn-follow').removeClass('hidden')
      }
}

// フォロワー数カウントアップ機能
const followersUpCounter = () => {
    const followerCount = Number($(".follower_count").text());
    const countUp = followerCount + 1;
    $(".follower_count").text(countUp);
}

// フォロワー数カウントダウン機能
const followersDownCounter = () => {
    const followerCount = Number($(".follower_count").text());
    const countUp = followerCount - 1;
    $(".follower_count").text(countUp);
}

document.addEventListener('DOMContentLoaded', () => {

    const dataset = $('#account-show').data();
    const accountId = dataset.accountId

    axios.get(`/accounts/${accountId}/follows`)
      .then((response) => {
          const hasFollowed = response.data.followStatus
          handleFollowBtn(hasFollowed)
      })

      //フォロー機能
      $('.btn-follow').on('click', () => {
        axios.post(`/accounts/${accountId}/follows`)
          .then((response) => {
            if (response.data.status === 'ok') {
                followersUpCounter()

                $('.btn-following').removeClass('hidden')
                $('.btn-follow').addClass('hidden')
            }
          })
          .catch((e) => {
            window.alert('Error')
            console.log(e)
          })
      })
      
      //アンフォロー機能
      $('.btn-following').on('click', () => {
        axios.post(`/accounts/${accountId}/unfollows`)
          .then((response) => {
            if (response.data.status === 'ok') {
                followersDownCounter()

                $('.btn-follow').removeClass('hidden')
                $('.btn-following').addClass('hidden')
            }
          })
          .catch((e) => {
            window.alert('Error')
            console.log(e)
          })
      })
})