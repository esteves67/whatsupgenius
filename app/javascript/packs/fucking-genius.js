import Vue from 'vue'
import Axios from 'axios'
import FuckingGenius from './components/fucking-genius/FuckingGenius.vue'
import VuePhoneNumberInput from 'vue-phone-number-input'
import 'vue-phone-number-input/dist/vue-phone-number-input.css'

Vue.prototype.$http = Axios.create({ baseURL: 'http://localhost:3000' })
Vue.component('vue-phone-number-input', VuePhoneNumberInput)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#fucking-genius',
    render: h => h(FuckingGenius)
  })
})
