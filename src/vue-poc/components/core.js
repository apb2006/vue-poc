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

// read and write settings 
// https://vuejs.org/v2/guide/state-management.html
var settings = {
    debug: true,
    getItem (key) {
      if (this.debug) console.log('getItem',key);
      return new Promise((resolve, reject) => {
        localforage.getItem(key)
        .then((value) => {
          console.log('GET setting', key,value);
          resolve(value)
        }).catch((err) => {
          console.log('GET failed');
          reject(err)
      });
      });
    },
    setItem (key,value,callback) {
      if (this.debug) console.log('setItem',key,value);
      return new Promise((resolve, reject) => {
      localforage.setItem(key, value) 
      .then((value) => {
        console.log('SET ',key, value);
        return new Promise((resolve, reject) => {resolve(value);})
      }).catch((err) => {
        console.log('set failed');
        return new Promise((resolve, reject) => {reject(err);})
      });
    })
    }
  };

Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
  console.error(err, vm, info);
  alert("vue error");
};

//Returns a function, that, as long as it continues to be invoked, will not
//be triggered. The function will be called after it stops being called for
//N milliseconds. If `immediate` is passed, trigger the function on the
//leading edge, instead of the trailing. https://gist.github.com/nmsdvid/8807205
function debounce(func, wait, immediate) {
 var timeout;
 return function() {
     var context = this, args = arguments;
     clearTimeout(timeout);
     timeout = setTimeout(function() {
         timeout = null;
         if (!immediate) func.apply(context, args);
     }, wait);
     if (immediate && !timeout) func.apply(context, args);
 };
};

// used by vue-ace      
var Events = new Vue({});


const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  routes: [
    { path: '/', component: Home,meta:{title:"Home"} },
    { path: '/session', component: Session ,meta:{title:"Session"}},
    { path: '/images/item', component: Images, meta:{title:"Images"} },
    { path: '/images/report', name:"image-reports",component: Report, props: true, meta:{title: "Image report"}},
    { path: '/images/item/:id', name:"image",component: Image, props: true, meta:{title: "Image details"}},
    { path: '/images/thumbnail', component: Thumbnail, meta:{title:"Thumbnail generator"} },
    { path: '/select', component: Select, meta:{title:"Select"} },
    { path: '/search', component: Search, meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
   
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} },
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"basexdb"} },
    { path: '/ping', component: Ping,meta:{title:"Ping"} },
    { path: '/settings', component: Settings, meta:{title:"Settings"} },
    { path: '/history', component: History, meta:{title:"File History"} },
    { path: '/puzzle', component: Puzzle, meta:{title:"Jigsaw"} },
    { path: '/eval', component: Eval, meta:{title:"Evaluate XQuery"} },
    { path: '/logs', component: Log, meta:{title:"Server logs"} },
    { path: '/tasks', component: Task, meta:{title:"Runnable tasks"} },
    { path: '/tasks/model', component: Model, meta:{title:"build model"} },
    { path: '/tasks/xqdoc', component: Xqdoc, meta:{title:"build xqdoc"} },
    { path: '/tasks/vuecompile', component: Vuecompile, meta:{title:"vue compile"} },
    { path: '/jobs', component: Jobs, meta:{title:"Jobs running"} },
    { path: '/jobs/:job',  name:"jobShow", component: Job, props: true, meta:{title:"Job Status"} },
    { path: '/timeline', component: Timeline,meta:{title:"timeline"} },
    { path: '/about', component: About,meta:{title:"About Vue-poc"} },
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
    alert:{show:false,msg:"Hello"},
    items:[
      {href: '/',text: 'Home', icon: 'home'    }, 
      {
        icon: 'folder_open',
        text: 'Collections' ,
        model: false,
        children: [
       {href: '/database', text: 'Databases',icon: 'developer_mode' },
       {href: '/files', text: 'File system',icon: 'folder' },
      {href: '/edit',text: 'Edit',icon: 'mode_edit'},
      {href: '/history',text: 'history',icon: 'history'}
      ]},
      {
        icon: 'directions_run',
        text: 'Actions' ,
        model: false,
        children: [
      {href: '/eval',text: 'Query',icon: 'play_circle_outline'},      
      {href: '/tasks',text: 'Tasks',icon: 'history'}
      ]},
      {
        icon: 'cast_connected',
        text: 'Server' ,
        model: false,
        children: [
          {href: '/jobs',text: 'Running jobs',icon: 'dashboard'},   
          {href: '/logs',text: 'Server logs',icon: 'dns'},
          {href: '/ping',text: 'Ping',icon: 'update'}
      ]},
      {
        icon: 'camera_roll',
        text: 'Images' ,
        model: false,
        children: [
          {href: '/images/item',text: 'Collection',icon: 'photo_camera'},
          {href: '/thumbnail',text: 'Thumbnail',icon: 'touch_app'},
          {href: '/images/report',text: 'Image reports',icon: 'report'}
          ]},
      {
        icon: 'more_horiz',
        text: 'More' ,
        model: false,
        children: [
      {href: '/session',text: 'Session',icon: 'person'}, 
      {href: '/select',text: 'Select',icon: 'extension'},
      {href: '/puzzle',text: 'Puzzle',icon: 'extension'},       
      {href: '/tabs',text: 'Tabs',icon: 'switch_camera'}, 
      {href: '/timeline',text: 'Time line',icon: 'timelapse'}
      ]},
      
      {href: '/settings',text: 'Settings',icon: 'settings'  },
      {href: '/about',text: 'About', icon: 'help'    }, 
    ]

  }},
  methods: {
      session(){
        this.$router.push({path: '/session'})
      },
      search(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
      logout(){
        HTTP.get("logout").then(r=>{
          alert("logout")
        }) 
      },
      showAlert(msg){
        this.alert.msg=moment().format()+" "+ msg
        this.alert.show=true
      }
  },
  created(){
    console.log("create-----------")
    // Add a response interceptor

    HTTP.interceptors.response.use(
    (response)=> {
      // Do something with response data
      return response;
    },
    (error) =>{
      // Do something with response error
      this.showAlert("http error:\n"+error.response.data)
      return Promise.reject(error);
    });
    
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
