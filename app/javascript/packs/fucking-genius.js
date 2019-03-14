import Vue from 'vue';
import Vuex from "vuex";
import VueResource from "vue-resource";
import FuckingGenius from './components/fucking-genius/FuckingGenius.vue';

Vue.use(Vuex);
Vue.use(VueResource);

Vue.http.interceptors.push(function (request, next) {
  request.headers.set('Content-Type', 'application/json');
  request.headers.set('Access-Control-Allow-Origin', '*');
  request.headers.set('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  request.headers.set('Access-Control-Allow-Methods', 'POST, GET, PUT, DELETE, OPTIONS');
  request.headers.set('X-CSRF-Token', document.getElementsByName('csrf-token')[0].content);
  next();
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#fucking-genius',
    render: h => h(FuckingGenius)
  })
})

