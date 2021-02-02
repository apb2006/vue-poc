<!DOCTYPE html>
<template id="component1">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/quodatum.cmpx" entity="quodatum.cmpx"  item-key="name">
   <template v-slot:item.name="{ item }" > 
	     <router-link v-if="item" :to="{name:'component1', query:{ name: item.name}}">
                 {{ item.name }}
          </router-link>
    </template>
    <template v-slot:item.home="{ item }" > 
	      <a :href=" item.home" target="cmpx">
                 {{ item.home }}
          </a>
    </template>
   </qd-table>
 </v-container>
 </template>
 <script>{
  data:  function(){
    return {
      headers: [
        { text: 'name', value: 'name'},
        { text: 'type', value: 'type' },
        { text: 'home', value: 'home' },
        { text: 'description', value: 'description' }
      ] 
      }
  }
}
</script>