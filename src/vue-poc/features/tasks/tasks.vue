<!DOCTYPE html>
<template id="task">
 <v-container fluid>
  <h3>Available Tasks</h3>
  <v-snackbar
      :bottom="true"
      v-model="snackbar"
    >
     got tasks, currently ignoring
      <v-btn flat class="pink--text" @click.native="snackbar = false">Close</v-btn>
    </v-snackbar>
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
      snackbar: false
      }
  },
  methods:{
    getTasks(){
        HTTP.get("tasks/list")
        .then(r=>{
		   this.snackbar=true
		   this.tasks=r.data
       })
    }
   },
  created(){
    this.getTasks()
   }
}
</script>
