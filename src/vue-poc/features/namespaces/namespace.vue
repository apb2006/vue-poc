<!DOCTYPE html>
<template id="namespace">
<v-container fluid>
   <qd-table :headers="headers" data-uri="data/namespace" entity="namespace"  item-key="xmlns">
    <template v-slot:item.xmlns="{ item }" > 
	      <router-link :to="{name:'namespace1', query:{ id: item.xmlns}}">
                 {{ item.xmlns }}
          </router-link>
    </template>
      
    <template slot="no-results">
        No matching results.
    </template>
    
    <template slot="no-data">
        No matching items.
    </template>
   </qd-table>
 </v-container>
 </template>
 <script>{
  data:  function(){
    return {
      headers: [
        { text: 'namespace', value: 'xmlns'},
        { text: 'Description', value: 'description' },
        { text: 'Prefix', value: 'prefix' }
      ] 
      }
  }
}
</script>