<!DOCTYPE html>
<template id="entity1">
<v-card>
	<v-toolbar >
	 <v-toolbar-title> 
	 <v-breadcrumbs >
            <v-breadcrumbs-item  to="/entity" :exact="true">
            Entities
            </v-breadcrumbs-item>
            
              <v-breadcrumbs-item  >
            {{ entity }}
            </v-breadcrumbs-item>
        </v-breadcrumbs>
	 </v-toolbar-title>
	 <v-spacer></v-spacer>
	 <v-btn @click="getItem"
	  :loading="loading"
      :disabled="loading"
	 >Refresh</v-btn>
	 
	  <v-btn @click="getxml"
    :loading="loading"
      :disabled="loading"
   >XML</v-btn>
	 </v-toolbar>

  <v-container fluid grid-list-md>
  
  
     <pre>{{ xml }}</pre>
  </v-container>
   </v-card>
</template>

<script>{
  props: ['entity'],
  data:  function(){
    return {
      q: 'filter',
      item: {},
      loading: false,
      xml: null
      }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/entity/"+this.entity,{params:this.q})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.item=r.data.items
        }) 
    },
    getxml(){
      HTTP.get("data/entity/"+this.entity,{params:this.q, headers: {Accept: "text/xml"}})
      .then(r=>{
        console.log(r.data)
        this.xml=r.data;
            }) 
    }
  },
  created:function(){
    this.getItem()
  },
}
</script>
