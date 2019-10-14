<!DOCTYPE html>
<!-- card showing table -->
<template id="qd-table">
 <v-container fluid>
  <v-card >
   <v-toolbar >
    <v-text-field
        prepend-icon="filter_list" 
        label="Filter items..."
        single-line
        hide-details
        v-model="search"
        clearable
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
       show-select
      class="elevation-1"
      :no-data-text="noDataMsg"
    >
    <template slot="items" slot-scope="props">
     <td >
        <v-checkbox
          primary
          hide-details
          v-model="props.selected"
        ></v-checkbox>
      </td>
      <td v-for="col in headers" :key="col.name">{{ foo(props,col) }}</td>
    </template>
  </v-data-table>
  </v-card>
 </v-container>
</template>

<script>{
	  props: {
	    headers: {
	      default: [
	        { text: 'Name', value: 'id'},
	        { text: 'Permission', value: 'state' }
	      ]
	  },
	  dataUri:{
	    default: "entity"
	  },
	  noDataMsg:{
	    default: "No data found."
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
           console.log("items",r.data.items,"headers ",this.headers);
           this.items=r.data.items;
        })
     },
     foo(props,header){
       //console.log("value ",header)
       if(header){
         return  props.item[header.value]
       }
       return props.selected
     }
  },
  created:function(){
    console.log("qd-table");
    this.getItems();
  }
}
</script>
