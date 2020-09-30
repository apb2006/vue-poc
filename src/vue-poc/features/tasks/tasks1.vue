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
       <v-btn-toggle
          v-model="view"
          borderless
        >
          <v-btn value="">
            <router-link :to="{path: 'run', append:true }"> <v-icon>home</v-icon>Home</router-link>       
          </v-btn>

          <v-btn value="run">
             <router-link :to="{path: 'run', append:true }"  > <v-icon>play_circle_outline</v-icon>Run</router-link>
          </v-btn>

          <v-btn value="edit" v-if="data">
            <router-link :to="{name: 'edit',  query:{url: data.url} }"  > <v-icon>edit</v-icon>Edit</router-link>
          </v-btn>

          <v-btn value="history">
            <router-link :to="{name:'taskhistory', query:{task: task}}"><v-icon>history</v-icon>History</router-link>
          </v-btn>
        </v-btn-toggle>
   <v-spacer></v-spacer>
   <vp-entitylink entity="quodatum.task"></vp-entitylink>    
   </v-toolbar>
   
   <v-card-text>
  
   <h1>{{ task }} </h1>
   <div v-if="data">
   <p >{{ data.description }}</p>
   <a :href="data.url">{{ data.url }}</a>
   </div>
   
     <pre>{{ data | pretty }}</pre>
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
 
      data: null,
      loading: false,
      view: null
      }
  },
  methods:{
    getTasks(){
        this.loading= true;
        HTTP.get("tasks/" + this.task)
        .then(r=>{
		   this.data= r.data;
		   this.loading= false;
       })
    }
   },
  mounted(){
    this.getTasks()
   }
}
</script>
