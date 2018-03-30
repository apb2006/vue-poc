<!DOCTYPE html>
<template id="namespace1">
<v-card>
	<v-toolbar >
	 <v-toolbar-title> Namespace: {{ namespace }}</v-toolbar-title>
	 <v-spacer></v-spacer>
	 <v-btn @click="getItem"
	  :loading="loading"
      :disabled="loading"
	 >Refresh</v-btn>
	 </v-toolbar>

  <v-container fluid grid-list-md>
  
  
      hello
  </v-container>
   </v-card>
</template>

<script>{
  props: ['namespace'],
  data:  function(){
    return {
      q: 'filter',
      item: {},
      loading: false
      }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/namespace",{params:this.q})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.item=r.data.items
        }) 
    }
  },
  created:function(){
    this.getItem()
  },
}
</script>
