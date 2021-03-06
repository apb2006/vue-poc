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
    
    { path: '/about', component: { template: '<router-view/>' }  ,children:[
        {path: '', component: About, meta:{title:"About Vue-poc"} },
        {path: 'package', component: Package, meta:{title:"Javascript components"} },
        {path: 'routes', component: Routes, meta:{title:"Routes"} },
        {path: 'routes2', name: 'routes', component: Routes2, meta:{title:"Routes2"} },
        {path: 'vue-cmps', component: VueComps, meta:{title:"Vue components"} },
     ]},
     
     { path: '/action', component: { template: '<router-view/>' }  ,children:[
    	 { path: 'edit', name: "edit",component: Edit,meta:{title:"Ace editor"} },
    	 { path: 'eval', component: Eval, meta:{title:"Evaluate XQuery"} },
    	 { path: 'eval/:id', component: Evalid, props: true, meta:{title:"Run details"} },
    	 { path: 'tabs', name: "multi-edit", component: Tabs,meta:{title:"tab test"} },   
    	 { path: 'transform', component: Transform, meta:{title:"XSLT2 Transform"} },
    	 { path: 'validate', component: Validate, meta:{title:"Validate"} },    	    
    	 
     ]},
    { path: '/components',component: { template: '<router-view/>' }, 
     	children: [ 
    	  {path:'', component: Components,meta:{title:"Components"}, props:{protocol:"xmldb"} },
    	  {path:':name', name:"component1", component: Component1, meta:{title:"Component"}, props: true },
     ]},
    
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"xmldb"} },
    { path: '/documentation', component: Documentation, meta:{title:"documentation"} },
    { path: '/documentation/xqdoc', component: Xqdocs, meta:{title:"XQdoc"} },
    
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} }, 
    
    {path: '/images', component: { template: '<router-view/>' }, 
    	children: [
		    {path: '', redirect: 'item' },		
		    { path: 'item', name:'images', component: Images, meta:{title: "Images"} },
		    { path: 'report', name:"image-reports", component: Report, props: true, meta:{title: "Image report"}},
		    { path: 'item/:id', name:"image",component: Image, props: true, meta:{title: "Image details"}},
		    { path: 'thumbnail', component: Thumbnail, meta:{title:"Thumbnail generator"} },
		    { path: 'keywords', component: Keywords, meta:{title:"Image keywords"} },
		    { path: 'dates', component: Dates, meta:{title:"Image dates"} },
		    { path: 'people', component: People, meta:{title:"Image people"} }
    ]},
        
    { path: '/logdate', component: Basexlogdate, meta:{title:"log files"} },
    { path: '/logdate/:date', component: Basexlogdate1, props:true, meta:{title:"log files"} },
    
    {path: '/model', component: { template: '<router-view/>' }, 
    	children: [
		    {path: '', redirect: 'schema' },	
		    { path: 'schema', name:"schema", component: Schema, meta:{title:"Schemas"} },
		    { path: 'taxonomy', component: Taxonomy, meta:{title:"Taxonomies"} },
		    { path: 'mimetype', component: Mimetype, meta:{title:"Mimetypes"} },
		    { path: 'namespace', name: "namespace", component: Namespace, meta:{title:"Namespaces"} },
		    { path: 'namespace/item', name: "namespace1", component: Namespace1, meta:{title:"Namespace"} },
		    { path: 'entity', component: Entity, meta:{title:"Entities"} },
		    { path: 'entity/:entity', component: { template: '<router-view/>' }
	          ,children: [
	        	  {
	                  path: '',
	                  component: Entity1, props: true, meta:{title:"Entity"} 
	                }, 
	                { 
	                	path: 'data', component: Entity1data, props: true, meta:{title:"Entity data"}   
	                }
	          ]
		    } 
         ]},
    { path: '/session', component: Session ,meta: {title:"Session"}},  
    { path: '/select', component: Select, meta:{title:"Select"} },
    { path: '/search', component: Search, meta:{title:"Search"} },
  
    


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
    
    { path: '/performance', component: { template: '<router-view/>' }
	    ,children: [
			    	{ path: 'ping', component: Ping, meta:{title:"Ping"} },
			        { path: 'dicetest', component: Dicetest, meta:{title: "Dice test"} }
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
      { path: 'jobs/:job',  name:"job1", component: Job, props: true, meta:{title:"Job Status"} },
      { path: 'services',  component: Services, meta:{title:"Services"} },
      { path: 'services/:service',  name:"service1", component: Service1, props: true, meta:{title:"Service info"} },
      { path: 'upload', component: Upload, meta:{title:"Upload"} },
     
      { path: 'settings', component: Basexsettings, meta:{title: "BaseX settings"} },
      
      { path: 'users', component: Users, meta:{title: "Users"} },
      { path: 'repo', name: 'repo', component: Repo, meta:{title: "BaseX Repository"} },
      { path: 'repo1', name: "repo1", component: Repo1,  props: true, meta:{title: "Repository item"} },
     ]
    },
    { path: '/history', component: { template: '<router-view/>' }
    ,children: [
      { path: 'files', component: Filehistory, meta:{title: "File History"} },
      { path: 'tasks',  name: "taskhistory", component: Taskhistory, meta:{title: "Task History"} }
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
      
    { path: '/logs', component: Log, meta:{title:"Server logs"} },
    { path: '/map', component: Leaflet,meta:{title:"map"} },     
    { path: '/tasks', component: { template: '<router-view/>' } ,  children:[
		    { path: '', component: Tasks, meta:{title:"Runnable tasks"} },
		    { path: 'vuecompile', component: Vuecompile, meta:{title:"vue compile"} },
		    { path: ':task',  props: true, component: { template: '<router-view/>' },
		    	children:[
		        {path:"",  props: true, component: Tasks1 },
		    	{path: "run", component: Runtask, props: true,  meta:{title:"Run task"} },
		    	]}
    ]},  
    { path: '/view', component: { template: '<router-view/>' } ,  children:[
    	    { path: 'svg', component: Viewsvg, meta:{title:"SVG test"} }
    	    ]},
   
   { path: '*', component: Notfound, meta:{title:"Page not found"} }
  ],
});

// set page title
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

// req auth?
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

// update browser url to have query from params
router.addParamsToLocation=function(params) {
	  console.log("router.addParamsToLocation: ",params)
	  history.pushState(
	    {},
	    null,
	    this.$router.options.base + this.$route.path +
	      '?' +
	      Object.keys(params)
	        .map(key => {
	          if (params[key])
	          return (
	            encodeURIComponent(key) + '=' + encodeURIComponent(params[key])
	          )
	        })
	        .join('&')
	  )
	}