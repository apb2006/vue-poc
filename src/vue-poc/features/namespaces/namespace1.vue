<!DOCTYPE html>
<template id="namespace1">
<v-card>
	<v-toolbar >
	 <v-toolbar-title> 
   <v-breadcrumbs >
            <v-breadcrumbs-item  to="/namespace" :exact="true">
            Namespaces
            </v-breadcrumbs-item>
            
              <v-breadcrumbs-item  >
            {{ xmlns }}
            </v-breadcrumbs-item>
        </v-breadcrumbs>
   </v-toolbar-title>
	 <v-toolbar-title>

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
      HTTP.get("data/namespace/item",{id: this.xmlns})
      .then(r=>{
        this.loading=false;
        console.log(r.data)
        this.item= r.data
        }) 
    }
  },
  created:function(){
    this.xmlns=this.$route.query.xmlns;
    this.getItem()
  },
}
</script>
