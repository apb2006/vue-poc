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
    :items-per-page="20"
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
          { text: 'Title', value: 'title' }
    	  ], 
  }
  },
  methods:{
	  refresh(){
		  var hits=this.$router.options.routes;
		  this.routes=hits.map(function(v,i){
			  return {"index":i,
				      "path": v.path,
				      "name":"ww",
				      "title": v.meta && v.meta.title
		  }});
		  console.log("routes: ",hits)
	    },
  },
  created(){
	  this.refresh()
  }
}</script>
