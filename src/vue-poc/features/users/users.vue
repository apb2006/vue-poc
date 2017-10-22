<!DOCTYPE html>
<template id="users">
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/users">
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
    console.log("qd-table")
  }
}
</script>
