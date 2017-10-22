<!DOCTYPE html>
<!-- card showing table -->
<template id="qd-table">
 <v-container fluid>
  <v-card >
   <v-toolbar >
    <v-text-field
        append-icon="search"
        label="Filter user"
        single-line
        hide-details
        v-model="search"
      ></v-text-field>   
      <v-spacer></v-spacer>
      <v-btn @click="getData">Refresh</v-btn>   
    </v-toolbar>
<v-data-table
      :headers="headers"
      :items="items"
      :search="search"
       v-model="selected"
       select-all
      class="elevation-1"
      no-data-text="No users found @todo"
    >
    <template slot="items" scope="props">
    <slot></slot>
    </template>
  </v-data-table>
  </v-card>
 </v-container>
</template>

<script>{
	  props: {
	    headers: {
	      default: [
	        {
	          text: 'Name',
	          left: true,
	          value: 'id'
	        },
	        { text: 'Permission', value: 'state' }
	      ]
	  },
	  dataUri:{
	    default: "users"
	  }
  },
  data:  function(){
    return {
      loading: false,
      items: [],
      search: null,
      selected: [],

      }
  },
  methods:{
      getData(){
        this.loading=true;
        HTTP.get(this.dataUri)
        .then(r=>{
           this.loading=false
           this.items=r.data
        })
     }
  },
  created:function(){
    console.log("qd-table")
    this.getData()
  }
}
</script>
