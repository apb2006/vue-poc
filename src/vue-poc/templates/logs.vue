<!DOCTYPE html>
<template id="log">
 <v-container fluid>
  <h1>LOGS</h1>
</template>

<script>{
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      q:this.$route.query.q
      }
  },
  created:function(){
    console.log("Serch",this.$route.query.q)
  }
}
</script>
