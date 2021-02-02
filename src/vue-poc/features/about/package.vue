<!DOCTYPE html>
<template id="package"> 
<v-container >
   <qd-table :headers="headers" :init-items="pack"   item-key="name">
	    <template v-slot:title >
	    	<qd-breadcrumbs @todo="showmenu= ! showmenu" 
	         :crumbs="[{to: '/about', text:'about'}, {text: 'Client components', disabled: false, menu: 'todo'}]"
	         >crumbs</qd-breadcrumbs> 
	    </template> 
	    <template v-slot:item.name="{ item }" > 
		      <router-link :to="{name:'namespace1', query:{ id: item.name}}">
	                 {{ item.name }}
	          </router-link>
	    </template>   
   </qd-table> 
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
