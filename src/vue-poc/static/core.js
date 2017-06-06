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

//Define the date time format filter
Vue.filter("formatDate", function(date) {
    return moment(date).format("MMMM D, YYYY")
});
Vue.filter('readablizeBytes', function (bytes,decimals) {
  if(bytes == 0) return '0 Bytes';
  var k = 1000,
      dm = decimals || 2,
      sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
      i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
});
Vue.filter("any", function(any) {
  return "ANY"
});

Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
  console.error(err, vm, info);
  alert("vue error");
};

Vue.component('my-component', {
  template: '<div>A custom <v-chip>component!</v-chip></div>',
    created:function(){
      console.log("my-component");
    },  
});

var Events = new Vue({});


const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  routes: [
    { path: '/', component: Home },
    { path: '/people', component: People ,meta:{title:"People"}},
    { path: '/options', component: Options,meta:{title:"Options"} },
    { path: '/select', component: Select,meta:{title:"Select"} },
    { path: '/search', component: Search,meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/stepper', component: Stepper,meta:{title:"Stepper"} },
    { path: '/files', component: Files,meta:{title:"Files"} } 
  ],
});
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (true) {
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
    title:"my title2",
    mini: false,
    items: [{
      href: '/',
      router: true,
      title: 'Home',
      icon: 'home'    
    }, {
      href: 'files',
      router: true,
      title: 'files',
      icon: 'folder' 
    }, {
      href: 'edit',
      router: true,
      title: 'edit',
      icon: 'mode_edit'    
    }, {
      href: 'search',
      router: true,
      title: 'search',
      icon: 'search'
  }, {
      href: 'people',
      router: true,
      title: 'People',
      icon: 'person'      
   }, {
      href: 'select',
      router: true,
      title: 'select',
      icon: 'extension'
  }, {
      href: 'options',
      router: true,
      title: 'options',
      icon: 'domain'
  }, {
    href: 'tabs',
    router: true,
    title: 'tabs',
    icon: 'switch_camera'
  }, {
    href: 'login',
    router: true,
    title: 'login',
    icon: 'account_balance' 
}, {
  href: 'stepper',
  router: true,
  title: 'stepper',
  icon: 'touch_app'
}]
  
  }},
  methods: {
      
      search(){
        this.$router.push({path: 'search',query: { q: this.q }})
      }
  },
  created(){
    console.log("create-----------")
    HTTP.get("status")
    .then(r=>{
      console.log("status",r)
      this.status=r.data
    }) 
  },
  beforeDestroy(){
    console.log("destory-----------")
    
  }
  }).$mount('#app');
