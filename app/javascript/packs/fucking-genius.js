import Vue from 'vue'
import Axios from 'axios'
import FuckingGenius from './components/fucking-genius/FuckingGenius.vue'
import VuePhoneNumberInput from 'vue-phone-number-input'
import 'vue-phone-number-input/dist/vue-phone-number-input.css'

let baseUrl = process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : 'https://wug.robinhernie.dev'

Vue.prototype.$http = Axios.create({ baseURL: baseUrl })
Vue.component('vue-phone-number-input', VuePhoneNumberInput)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#fucking-genius',
    render: h => h(FuckingGenius)
  })
})
