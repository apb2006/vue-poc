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
         <v-btn
       icon 
      :loading="loading"
      :disabled="loading"      
      @click="getItems"
    >
    <v-icon>refresh</v-icon>
    </v-btn> 
    <span>{{ entity }}</span>
    </v-toolbar>
    
   <v-data-table
      :headers="headers"
      :items="items"
      :search="search"
       v-model="selected"
       select-all
      class="elevation-1"
      :no-data-text="noDataMsg"
    >
    <template slot="items" slot-scope="props">
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
	    default: "entity"
	  },
	  noDataMsg:{
	    default: "No USERS found @todo"
	  },
	  entity:{
      default: "entity"
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
      getItems(){
        this.loading=true;
        HTTP.get(this.dataUri)
        .then(r=>{
           this.loading=false;
           console.log("items",r);
           this.items=r.data.items;
        })
     }
  },
  created:function(){
    console.log("qd-table");
    this.getItems();
  }
}
</script>
