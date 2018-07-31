<!DOCTYPE html>
<template id="namespace">
 <v-container fluid>
 <v-card>
   <v-toolbar >
   <v-toolbar-title>
   <v-breadcrumbs >
            <v-breadcrumbs-item  to="/namespace" :exact="true">
            Namespaces
            </v-breadcrumbs-item>
        </v-breadcrumbs>
   </v-toolbar-title>

   
     <v-btn @click="load" icon
    :loading="loading"
      :disabled="loading"
   ><v-icon>refresh</v-icon></v-btn>
   
   <v-spacer></v-spacer>
   
   <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   clearable></v-text-field>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="namespace"></vp-entitylink>
  
   </v-toolbar>
   <v-card-text>
    <v-data-table
    :headers="headers"
    :items="items"
    hide-actions
     :search="q"
    class="elevation-1"
  >
    <template slot="items" slot-scope="props">
      <td ><router-link :to="{path:'namespace/item?xmlns='+ props.item.xmlns}">
                 {{ props.item.xmlns }}
                </router-link></td>
      <td >{{ props.item.description }}</td>
      <td >{{ props.item.prefix }}</td>
     
    </template>
    <template slot="no-data">
      <v-alert :value="true" icon="warning">
        No matching items.
      </v-alert>
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
      rowsPerPageItems: [4, 8, 20],
      pagination: {
        rowsPerPage: 20
      },
      selected:[],
      headers: [
        
        { text: 'xmlns', value: 'xmlns' },
        
        { text: 'Description', value: 'description' },
        { text: 'Prefix', value: 'prefix' }
        ]
      }
  },
  methods: {
    load(){
    
      this.loading= true
      HTTP.get("data/namespace",{params:{q:this.q}})
      .then(r=>{
        this.items= r.data.items
        this.loading= false
        })
        .catch(error=> {
          console.log(error);
          this.loading= false
          alert("Get query error"+url)
        });
      
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
    console.log("namespaces")
  }
}
</script>
