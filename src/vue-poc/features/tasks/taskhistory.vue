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
    <template slot="items" slot-scope="props">
      <td >AA: <router-link :to="'tasks/' + props.item.to" v-text="props.item.title"></router-link></td>
      <td >{{ props.item.description }}</td>
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
      loading: false,
      q: null,
      headers: [   
        { text: 'Task', value: 'title' },
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
