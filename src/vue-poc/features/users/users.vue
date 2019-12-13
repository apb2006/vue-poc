<!DOCTYPE html>
<template id="users">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/basex.user" entity="user" no-data-msg="Nothing found">
    <template slot="items" slot-scope="props">
      <td >
        <v-checkbox
          primary
          hide-details
          v-model="props.selected"
        ></v-checkbox>
      </td>
      <td >{{ props.item.name}}</td>
      <td >{{ props.item.permission }}</td>
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
        { text: 'Permission', value: 'permission' }
      ] 
      }
  },
 
created:function(){
  console.log("users")
}
}
</script>
