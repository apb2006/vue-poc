<!DOCTYPE html>
<template id="namespace">
 <v-container fluid  grid-list-md>
<v-toolbar >
   <v-toolbar-title>Namespaces</v-toolbar-title>
   <v-spacer></v-spacer>
   <v-btn @click="load"
    :loading="loading"
      :disabled="loading"
   >Refresh</v-btn>
   Text
   </v-toolbar>
    <v-data-table
    :headers="headers"
    :items="items"
    hide-actions
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
      <v-alert :value="true" color="error" icon="warning">
        Sorry, nothing to display here :(
      </v-alert>
    </template>
  </v-data-table>
   
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
    
  },
  created:function(){
    this.q=this.$route.query.q || this.q;
    this.load();
    console.log("namespaces")
  }
}
</script>
