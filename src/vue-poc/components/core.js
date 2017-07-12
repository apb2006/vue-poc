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


      
var Events = new Vue({});


const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  routes: [
    { path: '/', component: Home,meta:{title:"Home"} },
    { path: '/people', component: People ,meta:{title:"People"}},
    { path: '/images', component: Images,meta:{title:"Images"} },
    { path: '/select', component: Select,meta:{title:"Select"} },
    { path: '/search', component: Search,meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/thumbnail', component: Thumbnail,meta:{title:"Thumbnail generator"} },
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} },
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"basexdb"} },
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
       {href: 'database', text: 'Databases',icon: 'account_balance' },
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
      {href: 'eval',text: 'Query',icon: 'play_circle_outline'},      
      {href: 'jobs',text: 'Running jobs',icon: 'dashboard'},
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
      {href: 'images',text: 'Images',icon: 'camera_roll'}, 
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
