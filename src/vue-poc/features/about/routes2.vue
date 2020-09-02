<!DOCTYPE html>
<template id="routes2"> 
<v-container >
  <v-card hover raised> 
  <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/about', text:'about'}, {text: 'routes tree', disabled: false, menu: 'todo'}]"
         >crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer>
	<v-text-field
        v-model="search"
        label="Search routes"
        prepend-icon="filter_list"
        flat
        solo-inverted
        hide-details
        clearable
        clear-icon="mdi-close-circle-outline"
      ></v-text-field>
	</v-spacer>
	<v-btn  @click="refresh"> 
	<v-icon>refresh</v-icon>
    </v-btn>
	</v-toolbar> 
	<v-card-text>
	 <v-row>
      <v-col >  
	 <v-treeview style="max-height: calc(100vh - 210px); overflow-y: auto;"
    v-model="tree"
    :open="open"
    :items="items"
    activatable
    item-key="index"
    :search="search"
    :filter="filter"
    open-on-click
    v-on:update:active="doActive"
  >
    <template v-slot:prepend="{ item, open }">
      <v-icon v-if="item.children">
        {{ open ? 'mdi-folder-open' : 'mdi-folder' }}
      </v-icon>
      <v-icon v-else>mdi-file-document-outline</v-icon>
    </template>
    
    <template v-slot:label="{ item, open }">
    <v-card :id="'path'+item.index">
    <v-card-title style="padding:0">
     
     {{ item.name }} 
    
     <v-spacer></v-spacer>
    
         {{ item.index }} 
   
       </v-card-title>
       </v-card>
    </template>
    
  </v-treeview>
  </v-col>
  
  <v-col v-if="active">
  <v-card>
  <v-toolbar> 
  <v-card-title>
  {{ active.path}}
  </v-card-title>
   <router-link :to="active.path"><v-icon>link</v-icon></router-link>
  <v-spacer></v-spacer>
  <v-btn @click="$vuetify.goTo('#path'+ active.index)">{{ active.index }}</v-btn>
  </v-toolbar>
  <v-card-text>ffgfgfgf bbfb
  <pre><code>{{ active | pretty }}</code></pre>
  </v-card-text>
  </v-card>
  </v-col>
  </v-row>
</v-card>

</v-container> 
</template>
<script>{
  data:  () => ({
	  showmenu: false,
      open: [],    
      tree: [],
      items: [],
      active:null, // object from routelist or null.
      routes: [],
      search:null
    }),

  methods:{
	  refresh(){
		  var hits=this.routelist();
		  console.log("routelist",this.$router.options.routes)
		  this.items=hits
		  
	    },
	    doActive(a){
	    	this.active= a[0]?this.findItem(this.routelist(),a[0],"index"):null
	    	console.log("act",a[0],this.active)
	    },
	    routelist(){
	    	 var hits=this.$router.options.routes;
			  var index=0;
			  var pick=function(list,parent){
				  return list.map(function(route){
					  const path=(parent.path?parent.path + "/":"")+ route.path+(route.children?"/":"")
					  const data={
							  "index":++index,
						      "refname": route.name,
						      "path": route.path,
						      "name": path,
						      "title": route.meta && route.meta.title
					  };
					  if(route.children){
						  data.children=pick(route.children,data)  
					  }
					 return data
				  })
				  };
			  hits=pick(hits,{})
			  hits.sort((a,b)=>a.name.localeCompare(b.name) )
			  return hits	
	    },
	    findItem (tree, value, key = 'id', reverse = false) {
	    	  const stack = tree
	    	  while (stack.length) {
	    	    const node = stack[reverse ? 'pop' : 'shift']()
	    	    if (node[key] === value) return node
	    	    node.children && stack.push(...node.children)
	    	  }
	    	  return null
	    	}
  },
  
  watch: {
	    active: function (a) {
	    	const query = Object.assign({}, this.$route.query);
	    	if(a){
			 query.index = a.index
	    	}else 
	    		delete query.index;
			 this.$router.push({ query });
	    }
  },
  
  created(){
	  this.routes=this.routelist()
	  console.log("routes: ",this.routes)
	  this.refresh()
	  if(this.$route.query.index){
		    const index= parseInt(this.$route.query.index)
	    	//const h= this.findItem(this.routes,index)
	    	//console.log("search",h, index)
	    	//this.active=h
	    }
  }
}</script>
