<!DOCTYPE html>
<template id="components">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/quodatum.cmpx" entity="quodatum.cmpx"  item-key="name">
    <template v-slot:title >AAA</template> 
    <template v-slot:item.home="{ item }" > 
	      <a :href=" item.home" target="cmpx">
                 {{ item.home }}
          </a>
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
        { text: 'name', value: 'name'},
        { text: 'type', value: 'type' },
        { text: 'home', value: 'home' },
        { text: 'description', value: 'description' }
      ] 
      }
  }
}
</script>