<!DOCTYPE html>
<template id="users">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/user" entity="user" no-data-msg="Nothing found">
    <template slot="items" slot-scope="props">
     
      <td >{{ props.item.id}}</td>
      <td >{{ props.item.state }}</td>
     
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
        {
          text: 'Name',
          left: true,
          value: 'id'
        },
        { text: 'Permissions', value: 'state' }
      ] 
      }
  },
 
created:function(){
  console.log("users")
}
}
</script>
