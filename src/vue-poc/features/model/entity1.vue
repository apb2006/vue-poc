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
              <v-chip>
              <v-avatar>
              <v-icon>{{ item.iconclass }}</v-icon>
              </v-avatar> 
            {{ entity }}
            </v-chip>
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
  <div v-if="item">
    <div>{{item.description}}</div>
   <code>{{item.code}}</code>
   </div>
     <pre>{{ xml }}</pre>
     
  </v-container>
   </v-card>
</template>

<script>{
  props: ['entity'],
  data:  function(){
    return {
      item: {description:null,
             code: null
      },

      loading: false,
      xml: null
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
    getxml(){
      HTTP.get("data/entity/"+this.entity,{ headers: {Accept: "text/xml"}})
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
