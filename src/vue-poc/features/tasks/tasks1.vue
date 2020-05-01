<!DOCTYPE html>
<template id="tasks1">
 <v-container fluid>
 <v-progress-linear v-if="loading" v-bind:indeterminate="true" ></v-progress-linear>
 <v-card>
  <v-toolbar>
  <v-toolbar-title>
    <qd-breadcrumbs 
         :crumbs="[{to: '/tasks', text:'Tasks'}, {text: task, disabled: true} ]"
         >crumbs</qd-breadcrumbs> 
       </v-toolbar-title>  
     <v-spacer></v-spacer>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="quodatum.task"></vp-entitylink>    
   </v-toolbar>
   
   <v-card-text>
  
   <h1>{{ task }} </h1>
   <ul><li>
   <router-link :to="{path: 'run', append:true }"  > <v-icon>folder</v-icon>Run</router-link>
   </li>
   <li>
   <router-link :to="{name: 'edit',  query:{apple: task} }"  > <v-icon>folder</v-icon>Edit</router-link>
   </li>
   <li>
      <router-link :to="{name:'taskhistory', query:{task: task}}"><v-icon>history</v-icon>History</router-link>
     </li>
     </ul>
   </v-card-text>
    
    </v-card>
  
 </v-container>
</template>

<script>{
	 props:["task"],
  data(){
    return {
      crumbs: [{to: "/tasks", text: "Tasks"},
    	       { text: this.task}],
 
      items: [],
      loading: false,
      q: null,
      headers: [
    	{ text: 'Task', value: 'to' }, 
        { text: 'Title', value: 'title' },
        { text: 'Description', value: 'description' },
        ]
      }
  },
  methods:{
    getTasks(){
        this.loading= true;
        HTTP.get("tasks")
        .then(r=>{
		   this.items=r.data;
		   this.loading= false;
       })
    }
   },
  created(){
    this.getTasks()
   }
}
</script>
