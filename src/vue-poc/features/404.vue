<!DOCTYPE html>
<template id="notfound">
 <v-container fluid>
 Not found
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'bad route!'
      }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}
</script>
