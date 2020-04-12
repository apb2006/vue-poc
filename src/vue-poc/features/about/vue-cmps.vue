<!DOCTYPE html>
<template id="vueComps"> 
<v-container >
<v-card hover raised> 
    <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/about', text:'about'}, {text: 'vue-comps', disabled: false, menu: 'todo'}]"
         >crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer></v-spacer> 
	</v-toolbar> 
	<v-card-text>  <pre>{{ pack | pretty }}</pre> </v-card-text> 
</v-card> 
</v-container> 
</template>
<script>{
  data:  function(){
    return { 
      pack: null,
      fab: false,
      showmenu: false
  }
  },
  methods:{
	  refresh(){
	      HTTP.get("package.json")
	      .then(r=>{
	        console.log("status",r)
	        this.pack=r.data
	      })  
	    },
  },
  created(){
	  this.refresh()
  }
}</script>
