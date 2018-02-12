<!DOCTYPE html>
<template id="task">
 <v-container fluid>
  <h3>Available Tasks</h3>
  <v-progress-linear v-if="loading" v-bind:indeterminate="true" height="2"></v-progress-linear>
  <ul>
  <li  v-for="task in tasks" :key="task.to">
  <router-link :to="task.to" v-text="task.text"></router-link>
  </li>
  </ul>
 </v-container>
</template>

<script>{
  data(){
    return {
      tasks: [],
      loading: false
      }
  },
  methods:{
    getTasks(){
        this.loading= true;
        HTTP.get("tasks")
        .then(r=>{
		   this.tasks=r.data;
		   this.loading= false;
       })
    }
   },
  created(){
    this.getTasks()
   }
}
</script>
