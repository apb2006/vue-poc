<!DOCTYPE html>
<template id="jobs">
  <v-card >
   <v-toolbar light>
       <v-btn
      light icon
      :loading="loading"
      @click="getJobs()"
      :disabled="loading"
    >
    <v-icon>refresh</v-icon>
    </v-btn>
    
     <v-btn  
      @click="stop()"
      :disabled="noSelection"
    >Stop</v-btn>
    
      <v-spacer></v-spacer>
      <v-text-field
        append-icon="search"
        label="Filter jobs"
        single-line
        hide-details
        v-model="search"
      ></v-text-field>
     
    </v-toolbar>
  <v-data-table
      :headers="headers"
      :items="items"
      :search="search"
       v-model="selected"
       select-all
      class="elevation-1"
      no-data-text="No Jobs currently running"
    >
    <template slot="items" scope="props">
    <td class="vtop">
        <v-checkbox
          primary
          hide-details
          v-model="props.selected"
        ></v-checkbox>
      </td>
      <td class="vtop">  <router-link :to="{name: 'jobShow', params: {job: props.item.id }}">{{props.item.id}}</router-link></td>
      <td class="vtop text-xs-right">{{ props.item.state }}</td>
      <td class="vtop text-xs-right">{{ props.item.duration }}</td>
      <td class="vtop text-xs-right">{{ props.item.type }}</td>
       <td class="vtop text-xs-right">{{ props.item.writes }}</td>
        <td class="vtop text-xs-right">{{ props.item.reads }}</td>
      <td class="vtop text-xs-right">{{ props.item.user }}</td>
       <td class="vtop"><code>{{ props.item.text }}</code></td>
    </template>
  </v-data-table>
 </v-card>
</template>

<script>{
  data:  function(){
    return {
      headers: [
        {
          text: 'Job id',
          left: true,
          value: 'id'
        },
        { text: 'State', value: 'state' },
        { text: 'Duration', value: 'duration' },
        { text: 'Type', value: 'type' },
        { text: 'WriteL', value: 'writes' },
        { text: 'ReadL', value: 'reads' },
        { text: 'User', value: 'user' },
        { text: 'Query', value: 'text' }
      ],
      items:[        
      ],
      selected:[],
      search:"",
      loading:false
      }
  },
  methods:{
    getJobs(){
      this.loading=true;
	    HTTP.get("job")
	    .then(r=>{
	       this.loading=false
	       this.items=r.data
	       setTimeout(()=>{ this.getJobs() }, 10000);
	    })
	   
    },
    stop(){
      var s=this.selected.map((j)=>{return j.id}).join(",")
      console.log("AAA",this.selected)
      alert(s)
    }
  },
  computed: {
    // a computed getter
    noSelection: function () {
      // `this` points to the vm instance
      return this.selected.length==0
    }
  },
  created(){
    this.getJobs()
  }
}
</script>
