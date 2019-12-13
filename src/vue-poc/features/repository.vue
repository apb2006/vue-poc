<!DOCTYPE html>
<template id="repo">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/basex.repo" entity="repo" no-data-msg="Nothing found">
    <template slot="items" slot-scope="props">
      <td >
        <v-checkbox
          primary
          hide-details
          v-model="props.selected"
        ></v-checkbox>
      </td>
      <td >{{ props.item.name}}</td>
      <td >{{ props.item.type }}</td>
        <td >{{ props.item.version }}</td>
    </template>
   </qd-table>
 </v-container>

</template>

<script>{
  data:  function(){
    return {
      loading: false,
      items: [],
      search: null,
      selected: [],
      headers: [
        { text: 'Name', value: 'name'},
        { text: 'Type', value: 'type' },
        { text: 'Version', value: 'version' }
      ] 
      }
  },
 
created:function(){
  console.log("repo")
}
}
</script>
