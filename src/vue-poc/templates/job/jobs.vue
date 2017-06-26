<!DOCTYPE html>
<template id="job">
 <v-container fluid>
 <h1>JOBS</h1>

 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      jobs:[]
      
      }
  },
  methods:{
    getJobs(){
    alert("get jobs")
    }
  },
  created(){
    this.getJobs()
  }
}
</script>
