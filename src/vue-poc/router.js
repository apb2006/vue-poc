// vue-poc application routes
const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  //
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else if (to.hash) {
      return { selector: to.hash, behavior: 'smooth',offset: {x:0, y: 80} }

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
    
    { path: '/documentation', component: Documentation, meta:{title:"documentation"} },
    
    { path: '/logdate', component: Basexlogdate, meta:{title:"log files"} },
    { path: '/logdate/:date', component: Basexlogdate1, props:true, meta:{title:"log files"} },
    
    { path: '/entity', component: Entity, meta:{title:"Entities"} },
    { path: '/entity/:entity',  name:"entity1", component: Entity1, props: true, meta:{title:"Entity"} },
    
    { path: '/namespace', component: Namespace, meta:{title:"Namespaces"} },
    { path: '/namespace/item', component: Namespace1, meta:{title:"Namespace"} },
    
    { path: '/select', component: Select, meta:{title:"Select"} },
    { path: '/search', component: Search, meta:{title:"Search"} },
    { path: '/tabs', name: "multi-edit", component: Tabs,meta:{title:"tab test"} },
  
    { path: '/edit', name: "edit",component: Edit,meta:{title:"Ace editor"} },
 
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} },
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"xmldb"} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/settings', component: { template: '<router-view/>' }
         ,children: [
           {
             path: '',
             component: Showsettings, meta:{title:"Settings", requiresAuth:true}
           },
          {
            path: 'keys',
            component: Keys, 
            meta:{title:"keys"} 
          },
          {
            path: 'ace',
            component: Acesettings, 
            meta:{title:"Editor settings"} 
          }
          ]
    },
    
    { path: '/server', component: { template: '<router-view/>' }
    ,children: [
      {
        path: '',
        component: Settings, 
        meta:{title:"Settings ***", requiresAuth:true }
      },
      { 
        path: 'logs', name:"logs",
        component: Log, 
        meta:{title:"Server logs"}
      },
      { 
        path: 'logs/add', name:"addlog",
        component: Logadd, 
        meta:{title:"add Server logs"}
      },
      
      { path: 'jobs', name:"jobs", component: Jobs, meta:{title:"Jobs running"} },
      { path: 'jobs/:job',  name:"jobShow", component: Job, props: true, meta:{title:"Job Status"} },
      { path: 'services',  component: Services, meta:{title:"Services"} },
      { path: 'upload', component: Upload,meta:{title:"Upload"} },
     
      { path: 'settings', component: Basexsettings,meta:{title:"BaseX settings"} },
      { path: 'ping', component: Ping,meta:{title:"Ping"} },
      { path: 'dicetest', component: Dicetest,meta:{title:"Dice test"} },
      { path: 'users', component: Users,meta:{title:"Users"} },
      { path: 'repo', component: Repo,meta:{title:"Repository"} },
     ]
    },
    { path: '/history', component: { template: '<router-view/>' }
    ,children: [
      { path: 'files', component: Filehistory, meta:{title: "File History"} },
      { path: 'tasks', name: 'taskhistory', component: Taskhistory, meta:{title: "Task History"} },
      ]
    },
    { path: '/labs', component: { template: '<router-view/>' }
    ,children: [
      { path: 'scratch', component: Scratch, meta:{title:"scratch"} },
      { path: 'svg', component: Svg, meta:{title:"SVG"} },
      { path: 'svg2', component: Svg2, meta:{title:"SVG2"} },
      { path: 'timeline', component: Timeline,meta:{title:"timeline"} },
      { path: 'tree', component: Tree, meta:{title:"tree"} },
      { path: 'tree2', component: Tree2, meta:{title:"tree2"} },
      { path: 'form', component: Brutusin, meta:{title:"Form demo"} },
      { path: 'websocket', component: Websocket,meta:{title:"Web socket"} },
      { path: 'markdown', component: Markdown,meta:{title:"Markdown"} },
      ]
    },
    
    { path: '/puzzle', component: Puzzle, meta:{title:"Jigsaw"} },
    { path: '/html', component: Testhtml, meta:{title:"HTML test"} },
    
    { path: '/transform', component: Transform, meta:{title:"XSLT2 Transform"} },
    { path: '/validate', component: Validate, meta:{title:"Validate"} },
    
    { path: '/eval', component: Eval, meta:{title:"Evaluate XQuery"} },
    { path: '/eval/:id', component: Evalid, props: true, meta:{title:"Run details"} },
    
    { path: '/logs', component: Log, meta:{title:"Server logs"} },
    
    { path: '/tasks', component: { template: '<router-view/>' } ,  children:[
		    { path: '', component: Tasks, meta:{title:"Runnable tasks"} },
		    { path: 'model', component: Model, meta:{title:"build model"} },
		    { path: 'vuecompile', component: Vuecompile, meta:{title:"vue compile"} },
		    { path: ':task',  props: true, component: { template: '<router-view/>' },
		    	children:[
		        {path:"",  props: true, component: Tasks1 },
		    	{path: "run", component: Runtask, props: true,  meta:{title:"Run task"} },
		    	]}
    ]},  
   
   
    { path: '/map', component: Leaflet,meta:{title:"map"} },     
    
    { path: '/about', component: { template: '<router-view/>' }  ,children:[
      {path: '', component: About, meta:{title:"About Vue-poc"} },
      {path: 'package', component: Package, meta:{title:"Javascript components"} },
      {path: 'routes', component: Routes, meta:{title:"Routes"} },
      {path: 'vue-cmps', component: VueComps, meta:{title:"Vue components"} },
   ]},
   
   { path: '*', component: Notfound, meta:{title:"Page not found"} }
  ],
});
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

router.beforeEach((to, from, next) => {
  //console.log("before: ",to)
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    console.log("matched: ",Auth)
    if ("admin"!=Auth.role) {
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