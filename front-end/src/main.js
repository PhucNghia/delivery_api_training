require('bootstrap')
import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'

window.axios = axios
window.HOST = "http://localhost:3000"

Vue.config.productionTip = false
new Vue({
  render: h => h(App),
}).$mount('#app')
