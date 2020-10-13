<!DOCTYPE html>
<template id="basexsettings">
  <v-card>
  <v-toolbar>
  <v-toolbar-title>BaseX settings</v-toolbar-title>
  <v-spacer></v-spacer>
  <v-toolbar-items>
   <v-checkbox
      v-model="changed"
      label="Changed only"
    ></v-checkbox>
    </v-toolbar-items>
  </v-toolbar>
  
  <v-card-text>
  
     <v-data-table
    :headers="headers"
    :items="filtered"
    class="elevation-1"  
    
  >
    <template slot="items" slot-scope="props">
      <td>{{ props.item.name }}</td>
      <td >{{ props.item.current }}</td>
      <td >{{ props.item.changed }}</td>
      <td class="text-xs-right">{{ props.item.default }}</td>
      <td>
        <qd-link :href="'http://docs.basex.org/wiki/Options#' + props.item.name.toUpperCase()">description</qd-link>
      </td>
    </template>
  </v-data-table>
   </v-card-text>
 
    </v-card> 
	</template>
	
<script>{
  data: ()=>({
    busy: false,
    items: [],
    changed: true,
    
    headers: [
      { text: 'Name', value: 'name'},
      {text: "current", value: "current"},
      {text: "changed", value: "changed"},
      {text: "default", value: "default"},
      {text: "description"}
      ],
      pagination: {
        descending: false,
        page: 1,
        rowsPerPage: 100 ,// -1 for All
        sortBy: 'name'
      }
  }),
  
  methods:{
    get(){
      this.busy=true

      HTTP.get("server/basexsettings")
      .then(r=>{
        this.busy=false
        this.items=r.data
      
        }) 
    }
  },
  computed: {
    // a computed getter
    filtered: function () {
       return this.items.filter(item=> item.changed == this.changed)
    }
  },
  created:function(){
    console.log("reports")
    this.get()
  }
}</script>
