<!DOCTYPE html>
<template id="validate">
 <v-container fluid>
validate
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
