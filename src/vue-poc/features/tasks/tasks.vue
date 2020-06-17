<!DOCTYPE html>
<template id="tasks">
 <v-container fluid>
 <v-progress-linear v-if="loading" v-bind:indeterminate="true" ></v-progress-linear>
 <v-card>
  <v-toolbar>
  <v-toolbar-title>
     <v-breadcrumbs :items="crumbs">
      <template slot="item" slot-scope="props">
            <v-breadcrumbs-item  to="/tasks" :exact="true">
            Tasks
            </v-breadcrumbs-item>
        </template>
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
    <template v-slot:item.to="{ item }" > 
	      <td ><router-link :to="item.to" :append="true" v-text="item.to"></router-link></td>
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
      crumbs: [{to: "/tasks", text: "Tasks"}],
 
      items: [],
      loading: false,
      q: null,
      headers: [
    	{ text: 'Task', value: 'to' }, 
        { text: 'Title', value: 'title' },
        { text: 'Url', value: 'url' },
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
