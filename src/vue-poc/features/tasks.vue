<!DOCTYPE html>
<template id="task">
 <v-container fluid>
  <h1>Tasks</h1>
  <router-link to="tasks/model">model</router-link>
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
