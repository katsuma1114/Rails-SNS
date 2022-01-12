// import $ from 'jquery'
// import axios from 'axios'
// import { csrfToken } from 'rails-ujs'


// axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

// const handleFollowBtn = (hasFollowed) => {
//     if (hasFollowed) {
//         $('.btn-following').removeClass('hidden')
//       } else {
//         $('.btn-follow').removeClass('hidden')
//       }
// }

// document.addEventListener('DOMContentLoaded', () => {

//     const dataset = $('#account-show').data();
//     const accountId = dataset.accountId

//     axios.get(`/accounts/${accountId}/follows`)
//       .then((response) => {
//           const hasFollowed = response.data.followStatus
//           handleFollowBtn(hasFollowed)
//       })
// })