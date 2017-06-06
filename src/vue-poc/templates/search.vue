<!DOCTYPE html>
<template id="search">
 <v-container fluid>
 <v-text-field  label="Search..." v-model="q"></v-text-field>
 </v-container>
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
