<!DOCTYPE html>
<template id="repo">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/basex.repo" entity="basex.repo" item-key="name"
   :show-select="false" :query.sync="query">
   <template v-slot:item.name="{ item }">
      <router-link :to="{name: 'repo1', query: {id: item.name }}">{{ item.name }} </router-link>
   </template>
   <template v-slot:actions>
         <v-list-item @click="remove">
           <v-list-item-avatar><v-icon>delete</v-icon></v-list-item-avatar>
           <v-list-item-title>Delete</v-list-item-title>
         </v-list-item>
   </template>
   </qd-table>
 </v-container>

</template>

<script>{
  data:  function(){
    return {
      selected: [],
      query: {filter:null},
      entity: "basex.repo",
      headers: [
        { text: 'Name', value: 'name'},
        { text: 'Type', value: 'type' },
        { text: 'Version', value: 'version' }
      ] 
      }
  },
  methods:{
	remove(){
		alert("Not yet")
	}  
  },
  watch: {
		"query":{
		    handler:function(vnew,vold){
		      //console.log("watch",this.query)	     
		      this.$router.push({  query: this.query?this.query:null })
		      },
		    deep:true
		  }
  },
created:function(){
  console.log("repo")
 // this.query.filter=this.$route.query.filter || this.query.filter
}
}
</script>
