import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    allUsers:[
      {userId: 'hoza123', password: '123', name: 'Hoza', address: 'Seoul', src:'https://goo.gl/oqLfJR'},
      {userId: 'max123', password: '456', name: 'Max', address: 'Berlin', src:'https://goo.gl/Ksk9B9'},
      {userId: 'lego123', password: '789', name: 'Lego', address: 'Busan', src:'https://goo.gl/x7SpCD'}
    ]
  },
  getters: {
    allUserCount: function(state) {
      return state.allUsers.length;
    },
    countOfSeoul: state => {
      var count = 0;
      state.allUsers.forEach(user => {
        if (user.address === 'Seoul') count++;
      })
      return count;
    },
    percentOfSeoul: (state, getters) => {
      return Math.round(getters.countOfSeoul / getters.allUserCount * 100)
    }
  },
  mutations: {
    addUsers: (state, payload) => {
      state.allUsers.push(payload);
    }
  },
  actions: {
    // addUsers: (context) => {
    //   context.commit('addUsers');
    // },
    addUsers: ({ commit }, payload) => {  // function({commit}, payload) 같은의미
      commit('addUsers', payload);
    },
  }
})
