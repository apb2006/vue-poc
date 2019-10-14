<!DOCTYPE html>
<!-- 
 cards for log sources
 -->
<template id="logarchive">
 <v-container fluid>
 <v-card>
 
   <v-toolbar >
   <v-toolbar-title>
    <v-breadcrumbs :items="crumbs" >
         <template slot="item" slot-scope="props">
             <v-breadcrumbs-item  :to="props.item.to" :disabled="props.item.disabled" :exact="true">
                  {{ props.item.text }}
              </v-breadcrumbs-item>
          </template>
     </v-breadcrumbs>
   </v-toolbar-title>
     <v-btn @click="load" icon :loading="loading"
      :disabled="loading"
   ><v-icon>refresh</v-icon></v-btn>
   
   <v-spacer></v-spacer>
   
   <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   clearable></v-text-field>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="basexlogfile"></vp-entitylink> 
   </v-toolbar>
   
   <v-card-text>
    <v-data-table
    :headers="headers"
    :items="items"
    :loading="loading"
    hide-default-footer
     :search="q"
    class="elevation-1"
  >
  
  <template v-slot:item.xmlns="{ item }" > 
	      <td ><router-link :to="{path:'namespace/item?xmlns='+ item.xmlns}">
                 {{ item.xmlns }}
                </router-link></td>
    </template>
      
    <template slot="no-results">
        No matching results.
    </template>
    
    <template slot="no-data">
        No matching items.
    </template>
  </v-data-table>
   </v-card-text>
   </v-card>
   </v-container>
</template>

<script>{
  data:  function(){
    return {
      items: [],
      loading: false,
      q: "",
      message: 'bad route!',
     
      selected:[],
      headers: [
        
        { text: 'xmlns', value: 'xmlns' },
        
        { text: 'Description', value: 'description' },
        { text: 'Prefix', value: 'prefix' }
        ],
        crumbs:[{to:"/namespace", text:"namespaces"}]
      }
  },
  methods: {
    load(){
    
      this.loading= true
      HTTP.get("data/basexlogfile",{params:{q:this.q}})
      .then(r=>{
        this.items= r.data.items
        this.loading= false
        })
      
    },
    setfilter(){
      console.log("TODO",this.q)
      this.$router.push({  query: {url:this.url,q:this.q }})
    },
  },
  watch:{
    $route(vnew,vold){
      console.log("ROUTE",vnew,vold)    
      var url=this.$route.query.url
      this.url=url?url:"/";
      if(vnew.query.url != vold.query.url) this.load() 
    }
  },

  created:function(){
    this.q=this.$route.query.q || this.q;
    this.load();
    console.log("logarchive")
  }
}
</script>
