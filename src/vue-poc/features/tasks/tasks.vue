<!DOCTYPE html>
<template id="task">
 <v-container fluid>
  <h3>Available Tasks</h3>
  <v-progress-linear v-if="loading" v-bind:indeterminate="true" ></v-progress-linear>
  <ul>
  <li  v-for="task in tasks" :key="task.to">
  <router-link :to="'tasks/' + task.to" v-text="task.title"></router-link>
  <div v-html="task.description"></div>
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
