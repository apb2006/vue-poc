<!DOCTYPE html>
<template id="task">
 <v-container fluid>
 <v-progress-linear v-if="loading" v-bind:indeterminate="true" ></v-progress-linear>
 <v-card>
  <v-toolbar>
  <v-toolbar-title>
     <v-breadcrumbs >
            <v-breadcrumbs-item  to="/tasks" :exact="true">
            Tasks
            </v-breadcrumbs-item>
        </v-breadcrumbs>
       </v-toolbar-title>  
     <v-spacer></v-spacer>
   
   <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   clearable></v-text-field>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="namespace"></vp-entitylink>    
   </v-toolbar>

    <v-card-text>
     <ul>
			  <li  v-for="task in tasks" :key="task.to">
			  <router-link :to="'tasks/' + task.to" v-text="task.title"></router-link>
			  <div v-html="task.description"></div>
			  </li>
  </ul>
    </v-card-text>
    
    </v-card>
  
 </v-container>
</template>

<script>{
  data(){
    return {
      tasks: [],
      loading: false,
      q: null
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
