import Vue from 'vue'
import Vuex from 'vuex'

// import { BindModelAjax } from '../dist/src/bind-model-ajax.js';
// var BindModelAjax = require('../dist/src/bind-model-ajax');


// var jQuery = require('../dist/jquery-1.4.1');

// var _W = require('../dist/src/_w-meta-1.6.1.js');

// var EntityTable = require('../dist/src/entity-table').EntityTable;

// import { EntityTable } from '../dist/src/entity-table.js';
// var EntityTable = require('../dist/src/entity-table.js');



// var table = new EntityTable('T1');
var table = new _W.Meta.Entity.EntityTable('T1');
table.items.add('userId');
table.items.add('password');
table.items.add('name');
table.items.add('address');
table.items.add('src');

table.items.src.value = "SSS";

var row = table.newRow();
row['userId'] = 'R100';
row['password'] = 'R200';
row['name'] = 'R200';
row['address'] = 'R200';
row['src'] = 'R200';
table.rows.add(row);
var row = table.newRow();
row['userId'] = 'R101';
row['password'] = 'R202';
row['name'] = 'R203';
row['address'] = 'R204';
row['src'] = 'R205';
table.rows.add(row);


// var test = require('../dist/test-vue');
// console.log(typeof BindModelAjax)

// var vm = new BindModelAjax();

// table.rows.forEach(row => {
//   console.log(1)
// })

console.log(1)
if (typeof _W === 'object') _W.table = table;


Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    // allUsers:[
    //   {userId: 'hoza123', password: '123', name: 'Hoza', address: 'Seoul', src:'https://goo.gl/oqLfJR'},
    //   {userId: 'max123', password: '456', name: 'Max', address: 'Berlin', src:'https://goo.gl/Ksk9B9'},
    //   {userId: 'lego123', password: '789', name: 'Lego', address: 'Busan', src:'https://goo.gl/x7SpCD'}
    // ]
    allUsers: [table.rows[0], table.rows[1]],
    all: table.rows,
    obj: {
      aaa: 10,
      bbb: 20
    },
    item: table.items,
    table: table
  },
  getters: {
    allUserCount: function(state) {
      return state.allUsers.length;
    },
    countOfSeoul: state => {
      var count = 0;

      // for (var i = 0; state.allUsers.count > i; i++ ) {
      //   if (state.allUsers[i].address === 'Seoul') count++;        
      // }
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
      var row = table.newRow();
      row['userId'] = payload.userId;
      row['password'] = payload.password;
      row['name'] = payload.name;
      row['address'] = payload.address;
      row['src'] = payload.src;
      table.rows.add(row);
      console.log('Save')
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
