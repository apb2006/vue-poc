<!DOCTYPE html>
<template id="namespace1">
<v-card>
	<v-toolbar >
	
   <v-breadcrumbs >
       <v-breadcrumbs-item  :to="{name: 'namespace'}" :exact="true">Namespaces</v-breadcrumbs-item>
       <v-breadcrumbs-divider  >/</v-breadcrumbs-divider>     
       <v-breadcrumbs-item  ><v-toolbar-title>{{ xmlns }}</v-toolbar-title></v-breadcrumbs-item>
   </v-breadcrumbs>
  
	 <v-spacer></v-spacer>
	 <v-btn @click="getItem" icon
	  :loading="loading"
      :disabled="loading"
	 ><v-icon>refresh</v-icon></v-btn>
	 </v-toolbar>

  <v-container fluid grid-list-md>
  
  
      hello
      <div>{{ item.prefix }}</div>
      <div>{{ item.xmlns }}</div>
      <div>{{ item.description }}</div>
  </v-container>
   </v-card>
</template>

<script>{
  data:  function(){
    return {
      xmlns: '',
      item: {},
      loading: false
      }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/namespace/item",{params: {id: this.xmlns}})
      .then(r=>{
        this.loading=false;
        //console.log(r.data)
        this.item= r.data
        }) 
    }
  },
  created:function(){
    this.xmlns=this.$route.query.id;
    this.getItem()
  },
}
</script>
