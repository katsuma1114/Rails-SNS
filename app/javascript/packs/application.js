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
import axios from 'axios'
import { csrfToken } from 'rails-ujs'


axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const handleFollowBtn = (hasFollowed) => {
    if (hasFollowed) {
        $('.btn-following').removeClass('hidden')
      } else {
        $('.btn-follow').removeClass('hidden')
      }
}

document.addEventListener('DOMContentLoaded', () => {

    const dataset = $('#account-show').data();
    const accountId = dataset.accountId

    axios.get(`/accounts/${accountId}/follows`)
      .then((response) => {
          const hasFollowed = response.data.followStatus
          handleFollowBtn(hasFollowed)
      })
})