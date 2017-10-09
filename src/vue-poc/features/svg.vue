<!DOCTYPE html>
<template id="svg">
 <v-container fluid>
svg
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
