<!DOCTYPE html>
<template id="users">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/basex.user" entity="basex.user" item-key="name" no-data-msg="No users found">
   </qd-table>
 </v-container>

</template>

<script>{
  data:  function(){
    return {
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
