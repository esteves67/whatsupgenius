import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'
import FuckingGenius from './components/fucking-genius/FuckingGenius.vue'
import VuePhoneNumberInput from 'vue-phone-number-input'
import 'vue-phone-number-input/dist/vue-phone-number-input.css'


VuePhoneNumberInput
Vue.use(Vuex)
Vue.use(VueResource)
Vue.component('vue-phone-number-input', VuePhoneNumberInput)

Vue.http.interceptors.push(function (request, next) {
  request.headers.set('Content-Type', 'application/json')
  request.headers.set('X-CSRF-Token', document.getElementsByName('csrf-token')[0].content)
  next();
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#fucking-genius',
    render: h => h(FuckingGenius)
  })
})
