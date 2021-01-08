<!DOCTYPE html>
<template id="taskhistory">
 <v-container fluid>
 <v-progress-linear v-if="loading" v-bind:indeterminate="true" ></v-progress-linear>
 <v-card>
  <v-toolbar>
  <v-toolbar-title>
     <v-breadcrumbs >
            <v-breadcrumbs-item  to="/tasks" :exact="true">
            Tasks
            </v-breadcrumbs-item>
            <v-breadcrumbs-item  >
            History
            </v-breadcrumbs-item>
        </v-breadcrumbs>
       </v-toolbar-title>  
     <v-spacer></v-spacer>
   
   <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   clearable></v-text-field>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="quodatum.task"></vp-entitylink>    
   </v-toolbar>
   
   <v-card-text>
    <v-data-table
    :headers="headers"
    :items="items"
    hide-default-footer
     :search="q"
    class="elevation-1"
  >
  <template v-slot:item.id="{ item }" > 
	      <router-link :to="{path: '/tasks/' + item.task + '/run', query:{ id: item.id}}">
                 {{ item.id }}
          </router-link>
    </template>
    <template v-slot:item.task="{ item }" > 
	      <router-link :to="{path: '/tasks/' + item.task + '/run', query:{ id: item.id}}">
                 {{ item.task }}
          </router-link>
    </template>
    <template slot="no-data">
      <v-alert :value="true" icon="warning">
        No matching items.
      </v-alert>
    </template>
  </v-data-table>
   </v-card-text>
    
    </v-card>
  
 </v-container>
</template>

<script>{
  data(){
    return {
      items: [],
      task: null,
      loading: false,
      q: null,
      headers: [   
        { text: 'Id', value: 'id' },
        { text: 'Task', value: 'task' },
        { text: 'Created', value: 'created' },
        { text: 'Summary', value: 'summary' },
        { text: 'Params', value: 'arity' }
        ]
      }
  },
  methods:{
    getTasks(){
        this.loading= true;
        let params= this.task ?{params:{task: this.task}}:{}
        HTTP.get("data/history.task",params)
        .then(r=>{
		   this.items=r.data.items;
		   this.loading= false;
       })
    }
   },
  created(){
	this.task= this.$route.query.task
	console.log("TASK: ", this.task)
    this.getTasks()
   }
}
</script>
