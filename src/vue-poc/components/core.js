// base -----------------------
localforage.config({
  name: 'vuepoc'
});
const HTTP = axios.create({
  baseURL: "/vue-poc/api/",
  headers: {
    'X-Custom-Header': 'vue-poc',
    accept: 'application/json'
  }
});
const axios_json={ headers: {accept: 'application/json'}};

const Auth={
    user:"guest",
    permission:null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  }
};
Vue.use(Auth);
Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
  console.error(err, vm, info);
  alert("vue error");
};

Vue.component('my-component', {
  
  props: ['href'],
  template: '<a :href="href" :target="href" > {{href}}<v-icon>link</v-icon></a>',
    created:function(){
      console.log("my-component");
    },  
});

Vue.component('nav-list', {
  
  props: ['items'],
  template:` 
<v-list dense>
<template v-for="(item, i) in items">
  <v-layout
    row
    v-if="item.heading"
    align-center
    :key="i"
  > 
    <v-flex xs6>
      <v-subheader v-if="item.heading">
        {{ item.heading }}
      </v-subheader>
    </v-flex>
    <v-flex xs6 class="text-xs-center">
      <a href="#!" class="body-2 black--text">EDIT</a>
    </v-flex>
  </v-layout>
  <v-list-group v-else-if="item.children" v-model="item.model" no-action>

      <v-list-tile slot="item" :href="item.href" router ripple>
       <v-list-tile-action>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-tile-action>
          <v-list-tile-title>
            {{ item.text }}
          </v-list-tile-title>
          <v-spacer></v-spacer>
        <v-list-tile-action>
          <v-icon>{{ item.model ? 'keyboard_arrow_up' : 'keyboard_arrow_down' }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
        
        </v-list-tile-content>
      </v-list-tile>
      
    <template  v-for="(child, i) in item.children">
      <v-list-tile  :key="i" :href="child.href" router ripple>
        <v-list-tile-action v-if="child.icon">
          <v-icon>{{ child.icon }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>
            {{ child.text }}
          </v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </template>
  </v-list-group>

    <v-list-tile v-else :href="item.href" router ripple>
      <v-list-tile-action>
        <v-icon>{{ item.icon }}</v-icon>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title>
          {{ item.text }}
        </v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>
</template>
</v-list>`,
   created:function(){
      console.log("my-component");
    }
    });
      
var Events = new Vue({});


const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  routes: [
    { path: '/', component: Home,meta:{title:"Home"} },
    { path: '/people', component: People ,meta:{title:"People"}},
    { path: '/options', component: Options,meta:{title:"Options"} },
    { path: '/select', component: Select,meta:{title:"Select"} },
    { path: '/search', component: Search,meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/thumbnail', component: Thumbnail,meta:{title:"Thumbnail generator"} },
    { path: '/files', component: Files,meta:{title:"File system"} },
    { path: '/files', component: Files,meta:{title:"File system"} },
    { path: '/ping', component: Ping,meta:{title:"Ping"} },
    { path: '/settings', component: Settings,meta:{title:"Settings"} },
    { path: '/history', component: History,meta:{title:"File History"} },
    { path: '/puzzle', component: Puzzle,meta:{title:"Jigsaw"} },
    { path: '/eval', component: Eval,meta:{title:"Evaluate XQuery"} },
    { path: '/logs', component: Log,meta:{title:"Server logs"} },
    { path: '/tasks', component: Task,meta:{title:"Runnable tasks"} },
    { path: '/jobs', component: Job,meta:{title:"Jobs"} },
    { path: '*', component: Notfound,meta:{title:"Page not found"} }
  ],
});
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if ("admin"==Auth.permission) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next() // make sure to always call next()!
  }
});

Vue.use(Vuetify);
const app = new Vue({
  router,
  data:function(){return {
    q:"",
    status:{},
    drawer:true,
    mini: false,
    items:[
      {href: '/',text: 'Home', icon: 'home'    }, 
      {
        icon: 'folder_open',
        text: 'Collections' ,
        model: false,
        children: [
      {href: 'files', text: 'File system',icon: 'folder' },
      {href: 'edit',text: 'edit',icon: 'mode_edit'},
      {href: 'history',text: 'history',icon: 'history'},
      {href: 'logs',text: 'Server logs',icon: 'dns'}
      ]},
      {
        icon: 'directions_run',
        text: 'Actions' ,
        model: false,
        children: [
      {href: 'eval',text: 'Evaluate',icon: 'play_circle_outline'},      
      {href: 'jobs',text: 'Jobs',icon: 'dashboard'},
      {href: 'tasks',text: 'Tasks',icon: 'history'}, 
      ]},
      {
        icon: 'more_horiz',
        text: 'More' ,
        model: false,
        children: [
      {href: 'people',text: 'People',icon: 'person'}, 
      {href: 'select',text: 'select',icon: 'extension'},
      {href: 'puzzle',text: 'Puzzle',icon: 'extension'}, 
      {href: 'options',text: 'options',icon: 'domain'}, 
      {href: 'tabs',text: 'tabs',icon: 'switch_camera'}, 
      {href: 'ping',text: 'ping',icon: 'update'},
      {href: 'thumbnail',text: 'thumbnail',icon: 'touch_app'}
      ]},
      {href: 'settings',text: 'settings',icon: 'settings'  }
    ]

  }},
  methods: {
      
      search(){
        this.$router.push({path: 'search',query: { q: this.q }})
      },
      logout(){
        HTTP.get("logout").then(r=>{
          alert("logout")
        })
       
      }
  },
  created(){
    console.log("create-----------")
    HTTP.get("status")
    .then(r=>{
      console.log("status",r.data)
      Object.assign(Auth,r.data)
      this.$forceUpdate()
    }) 
  },
  beforeDestroy(){
    console.log("destory-----------")
    
  }
  }).$mount('#app');
