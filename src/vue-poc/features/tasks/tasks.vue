<!DOCTYPE html>
<template id="task">
 <v-container fluid>
  <h3>Available Tasks</h3>
  
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
      tasks: []
      }
  },
  methods:{
    getTasks(){
        HTTP.get("tasks")
        .then(r=>{
		   this.tasks=r.data
       })
    }
   },
  created(){
    this.getTasks()
   }
}
</script>
