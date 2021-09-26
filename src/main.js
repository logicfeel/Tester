import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import router from './router'
import store from './store'
// import 'expose-loader?$!expose-loader?jQuery!jquery'

// import {$, jQuery} from 'jquery';
// import jQuery from 'jquery';


Vue.config.productionTip = false

export const EventBus = new Vue()

var abc = new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
