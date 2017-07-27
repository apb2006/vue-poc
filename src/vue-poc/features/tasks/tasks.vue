<!DOCTYPE html>
<template id="task">
 <v-container fluid>
  <h3>Tasks</h3>
  <ul>
  <li>
  <router-link to="tasks/model">model</router-link>
  </li>
  <li>
  <router-link to="tasks/xqdoc">xqdoc</router-link>
  </li>
  </ul>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      q:this.$route.query.q
      }
  }
}
</script>
