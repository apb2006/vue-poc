<!DOCTYPE html>
<template id="package"> 
<v-container >
<v-card hover raised> 
    <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/about', text:'about'}, {text: '3rd party components', disabled: false, menu: 'todo'}]"
         >crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer></v-spacer> 
	</v-toolbar>
	 <v-data-table
    :headers="headers"
    :items="pack"
    :items-per-page="100"
    class="elevation-1"
  ></v-data-table> 
</v-card> 
</v-container> 
</template>
<script>{
  data:  function(){
    return { 
      pack: [],
      fab: false,
      showmenu: false,
      headers:[
    	  { text: 'name', value: 'name' },
    	  { text: 'version', value: 'version' }
    	  ], 
  }
  },
  methods:{
	  refresh(){
	      HTTP.get("package.json")
	      .then(r=>{
	        console.log("status",r)
	        var m=r.data.dependencies
	        var d = Object.keys(m).map(function (v,i){return {"name": v ,"version": m[v]}});
	        this.pack=d.sort((a,b)=>a.name.localeCompare(b.name))
	      })  
	    },
  },
  created(){
	  this.refresh()
  }
}</script>
