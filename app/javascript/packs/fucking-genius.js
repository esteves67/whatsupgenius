import Vue from 'vue'
import FuckingGenius from './components/fucking-genius/FuckingGenius.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#fucking-genius',
    render: h => h(FuckingGenius)
  })
})

