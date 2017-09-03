<!DOCTYPE html>
<template id="repo">
 <v-container fluid>
repository todo
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
