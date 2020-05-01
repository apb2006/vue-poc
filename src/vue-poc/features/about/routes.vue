<!DOCTYPE html>
<template id="routes"> 
<v-container>
<v-card hover raised> 
    <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/about', text:'about'}, {text: 'routes', disabled: false, menu: 'todo'}]"
         >crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer></v-spacer> 
	</v-toolbar> 
	<v-card-text>  
	<v-data-table
    :headers="headers"
    :items="routes"
    :items-per-page="100"
    class="elevation-1"
  ></v-data-table>
	 <pre>{{ pack | pretty }}</pre> </v-card-text> 
</v-card> 
</v-container> 
</template>
<script>{
  data:  function(){
    return { 
      pack: null,
      fab: false,
      showmenu: false,
      routes:null,
      headers:[
    	  { text: '#', value: 'index' },
    	  { text: 'Path', value: 'path' },
    	  { text: 'Name', value: 'name' },
          { text: 'Title', value: 'title' },
          { text: 'Children', value: 'children' }
    	  ], 
  }
  },
  methods:{
	  refresh(){
		  var hits=this.$router.options.routes;
		  hits=hits.map(function(v,i){
			  return {"index":i,
				      "path": v.path,
				      "name": v.name,
				      "title": v.meta && v.meta.title,
				      "children": v.children && v.children.length
		  }});
		  hits.sort((a,b)=>a.path.localeCompare(b.path) )
		  this.routes=hits
		  console.log("routes: ",hits)
	    },
  },
  created(){
	  this.refresh()
  }
}</script>
