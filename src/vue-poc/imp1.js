var fish =  { path: '/tasks', component: { template: '<router-view/>' } ,  
             children:[
    		    { path: '', component: Tasks, meta:{title:"Runnable tasks"} },
    		    { path: 'model', component: Model, meta:{title:"build model"} },
    		    { path: 'vuecompile', component: Vuecompile, meta:{title:"vue compile"} },
    		    { path: ':task',  props: true, component: { template: '<router-view/>' },
    		    children:[
    		        {path:"",  props: true, component: Tasks1 },
    		    	{path: "run", component: Runtask, props: true,  meta:{title:"Run task"} }
    		    	]}
    ]};
export {fish};