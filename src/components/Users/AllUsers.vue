<template>
  <div>
    <h1>1. 기본형</h1>
    <h1>All Users({{all}})</h1>
    <h2>서울 User :  {{count}} ({{percent}})%</h2>
    <h3>allUsers : {{allUsers.length}}</h3>
    <h3>all : {{$store.state.all.count}}</h3>
    <v-list two-line>
      <v-list-tile 
        v-for="(user, index) in $store.state.allUsers"
        :key="index"
        avatar
      >
        <v-list-tile-avatar color="grey lighten-3">
          <img :src="user.src">
        </v-list-tile-avatar>

        <v-list-tile-content>
          <v-list-tile-title v-html="user.name"></v-list-tile-title>
          <v-list-tile-sub-title>id:#{{index}} / {{user.address}} 거주</v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>

    <h1>1.rows 로딩방식</h1>
    <v-list two-line>
      <v-list-tile 
        v-for="(user, index) in $store.state.all"
        :key="index"
      >
      {{user.name}}..
      <v-text-field
      label="이미지"
      v-model="user.src"
    ></v-text-field>
      </v-list-tile>
    </v-list>
    
    <h1>2.지역정의 row 로딩방식</h1>
    <v-list two-line>
      <v-list-tile 
        v-for="(user, index) in in_all"
        :key="index"
      >
      {{user.name}}..
      <v-text-field
      label="이미지"
      v-model="user.src"
    ></v-text-field>
      </v-list-tile>
    </v-list>

    <h1>3.item.src.value 바인딩 확인</h1>
    <h1>{{$store.state.item['src'].value}}</h1>
    <v-text-field
      label="이미지"
      v-model="$store.state.item['src'].value"
    ></v-text-field>

    <h1>4.table 로딩방식</h1>
    <v-text-field
      label="아이템"
      v-model="$store.state.table.items['src'].value"
    ></v-text-field>
    <v-text-field
      label="로우"
      v-model="$store.state.table.rows[0]['src']"
    ></v-text-field>

    <h1>5.items.src.value, rows[0].src 값 확인</h1>
    <h1>items.value : {{$store.state.table.items['src'].value}}</h1>
    <h2>rows : {{$store.state.table.rows[0]['src']}}</h2>
    <h3>{{in_all.count}}</h3>
    <h3>{{src}}</h3>

    <h1>6. 태그를 통한 alls 전달</h1>
    <v-list two-line>
      <v-list-tile 
        v-for="(user, index) in alls"
        :key="index"
      >
      {{user.name}}..
      <v-text-field
      label="이미지"
      v-model="user.src"
    ></v-text-field>
      </v-list-tile>
    </v-list>


  </div>
</template>

<script>
import { EventBus } from '@/main.js'
import { mapGetters, mapState } from 'vuex'
// import { store } from '@/store.js'

  export default {
    props: ['src', 'alls'],
    data() {
      return {
        // 내부에 선언 사용하는 경우
        in_all: this.$store.state.all,
        // src: "초기값"
      }
    },
    computed: {
      // ...mapGetters(['allUserCount', 'countOfSeoul', 'percentOfSeoul'])
      ...mapGetters({
        all: 'allUserCount',
        count: 'countOfSeoul',
        percent: 'percentOfSeoul',
      }),
      // map 방식은 오류발새함  JSON.stringify(val, null, 2) <==
      // ...mapState(['allUsers', 'all'])   
      ...mapState(['allUsers'])

    },
    mounted() {
      EventBus.$on('signUp', users => {
        this.$store.state.allUsers.push(users)
      })
    }
  }
</script>
