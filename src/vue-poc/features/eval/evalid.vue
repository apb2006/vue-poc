<!DOCTYPE html>
<template id="evalid">
 <v-container fluid>
 todo {{id}}
 </v-container>
</template>

<script>{
  props:["id"],
  data:  function(){
    return {
      xq: '(: type your XQuery :)\n'
     
      }
  }
 
}
</script>
