<!DOCTYPE html>
<!-- show single item from repository -->
<template id="repo1">
<v-card >
	<v-toolbar>
	 <v-toolbar-title> 
	  <v-breadcrumbs divider="/">
            <v-breadcrumbs-item  :to="{name: 'repo'}" :exact="true">
            Repository
            </v-breadcrumbs-item>
              <v-breadcrumbs-item  >
            {{ repo }}
            </v-breadcrumbs-item>
        </v-breadcrumbs>
   </v-toolbar-title>
      
	 <v-spacer></v-spacer>
	 
	 <v-btn icon @click="getItem"
	  :loading="loading"
      :disabled="loading"
	 ><v-icon>refresh</v-icon></v-btn>
	
	 </v-toolbar>

  <v-container fluid >
	 todo
  </v-container>
   </v-card>
</template>

<script>{
  

  data:  function(){
    return {
      repo:null,
      loading: false
     
      }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/entity/"+this.entity)
      .then(r=>{
        this.loading=false
        this.item=Object.assign({}, this.item, r.data)
        }) 
    },
    code(item){
      return item.modules + " " +  item.namespaces + " " +item.code       
    },
    getxml(){
      HTTP.get("data/entity/"+this.entity,{ headers: {Accept: "text/xml"}})
      .then(r=>{
        this.xml=r.data;
            }) 
    },
    todo(){
      alert("TODO");
    }
  },
  computed: {
    dataurl(){
         return '/vue-poc/api/data/' + this.entity;
       },
       xquery(){
         return '/vue-poc/api/data/' + this.entity;
       }   
  },
  created:function(){
	  this.repo=this.$route.query.id;
    //this.getItem()
  },
}
</script>
