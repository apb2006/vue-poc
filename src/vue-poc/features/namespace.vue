<!DOCTYPE html>
<template id="namespace">
 <v-container fluid>
namespaces
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
