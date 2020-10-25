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

   <qd-table :headers="headers" data-uri="server/basexsettings2"  item-key="name" :filter="constrain" >
      <template v-slot:item.name="{ item }" >    
	       <v-chip>{{ item.name }}</v-chip>
    </template>
    
    <template v-slot:item.changed="{ item }" >    
       <v-simple-checkbox v-model="item.changed" disabled></v-simple-checkbox>
    </template>
    
    <template v-slot:item.description="{ item }" > 
	     <qd-link :href="'http://docs.basex.org/wiki/Options#' + item.name.toUpperCase()">BaseX doc</qd-link>
    </template>
    
   </qd-table>
   
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
      {text: "description", value: "description"}
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
    },
    customFilter(value, search, item) {
        return item.changed == this.changed &&
        value != null &&
        search != null &&
        typeof value === 'string' &&
        value.toString().indexOf(search) !== -1
    },
    foo(){
    	
    }
  },
  computed: {
    // a computed getter
    filtered: function () {
       return this.items.filter(item=> item.changed == this.changed)
    },
    constrain: function(){
    	return this.changed?[ {name:"changed", value:true} ]:[]
    }
  },
  created:function(){
    console.log("reports")
    this.get()
  }
}</script>
