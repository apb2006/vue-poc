// vue-poc application routes
const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  //
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else if (to.hash) {
      return { selector: to.hash, behavior: 'smooth' }

    } else {
      return { x: 0, y: 0 }
    }
  },
  routes: [
    { path: '/', component: Home, meta:{title:"Home"} },
    { path: '/session', component: Session ,meta: {title:"Session"}},
    
    {path: '/images', redirect: '/images/item' },
    { path: '/images/item', name:'images', component: Images, meta:{title: "Images"} },
    { path: '/images/report', name:"image-reports", component: Report, props: true, meta:{title: "Image report"}},
    { path: '/images/item/:id', name:"image",component: Image, props: true, meta:{title: "Image details"}},
    { path: '/images/thumbnail', component: Thumbnail, meta:{title:"Thumbnail generator"} },
    { path: '/images/keywords', component: Keywords, meta:{title:"Image keywords"} },
    { path: '/images/dates', component: Dates, meta:{title:"Image dates"} },
    { path: '/images/people', component: People, meta:{title:"Image people"} },
    
    { path: '/entity', component: Entity, meta:{title:"Entities"} },
    { path: '/namespace', component: Namespace, meta:{title:"Namespaces"} },
    { path: '/select', component: Select, meta:{title:"Select"} },
    { path: '/search', component: Search, meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/server/users', component: Users,meta:{title:"Users"} },
    { path: '/server/repo', component: Repo,meta:{title:"Repository"} },
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} },
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"xmldb"} },
    { path: '/ping', component: Ping,meta:{title:"Ping"} },
    { path: '/settings', component: Settings, meta:{title:"Settings"} },
    { path: '/acesettings', component: Acesettings, meta:{title:"Editor settings"} },
    { path: '/history', component: History, meta:{title:"File History"} },
    { path: '/puzzle', component: Puzzle, meta:{title:"Jigsaw"} },
    { path: '/svg', component: Svg, meta:{title:"SVG"} },
    { path: '/transform', component: Transform, meta:{title:"XSLT2 Transform"} },
    { path: '/validate', component: Validate, meta:{title:"Validate"} },
    { path: '/eval', component: Eval, meta:{title:"Evaluate XQuery"} },
    { path: '/logs', component: Log, meta:{title:"Server logs"} },
    { path: '/tasks', component: Task, meta:{title:"Runnable tasks"} },
    { path: '/tasks/model', component: Model, meta:{title:"build model"} },
    { path: '/tasks/xqdoc', component: Xqdoc, meta:{title:"build xqdoc"} },
    { path: '/tasks/vuecompile', component: Vuecompile, meta:{title:"vue compile"} },
    { path: '/jobs', component: Jobs, meta:{title:"Jobs running"} },
    { path: '/jobs/:job',  name:"jobShow", component: Job, props: true, meta:{title:"Job Status"} },
    { path: '/timeline', component: Timeline,meta:{title:"timeline"} },
    { path: '/map', component: Map,meta:{title:"map"} },
    { path: '/form', component: Brutusin,meta:{title:"Form demo"} },
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