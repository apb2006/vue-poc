<!DOCTYPE html>
<template id="jobs">
  <v-card >
   <v-toolbar >
     <v-text-field
        prepend-icon="filter_list"
        label="Filter jobs"
        single-line
        hide-details
        clearable
        v-model="search"
      ></v-text-field> 
      <v-spacer></v-spacer>
     <v-btn  
      @click="stop()"
      :disabled="noSelection"
    >Stop</v-btn>
   
      <v-btn icon ><v-icon>add</v-icon></v-btn>   
      <v-spacer></v-spacer>
      
       <v-btn
       icon
      :loading="loading"
      @click="getJobs()"
      @dblclick="autorefresh = !autorefresh"
      :disabled="loading"
    >
    <v-icon>{{ autorefresh?'refresh':'arrow_downward' }}</v-icon>
    </v-btn>
    </v-toolbar>
  <v-data-table
      :headers="headers"
      :items="items"
      :search="search"
       v-model="selected"
       show-select
      class="elevation-1"
      no-data-text="No Jobs currently running"
    >
    <template slot="items" slot-scope="props">
    <td class="vtop">
        <v-checkbox
          primary
          hide-details
          v-model="props.selected"
        ></v-checkbox>
      </td>
      <td class="vtop">  <router-link :to="{name: 'jobShow', params: {job: props.item.id }}">{{props.item.id}}</router-link></td>
      <td class="vtop "><div>{{ props.item.state }}</div><div>{{ props.item.type }}</div> </td>
      <td class="vtop " :title="props.item.registered">{{ props.item.registered | fromNow}}</td>
      <td class="vtop " :title="props.item.start">{{ props.item.start | fromNow}}</td>
       <td class="vtop text-xs-right">{{ props.item.duration }}</td>    
       <td class="vtop text-xs-right">{{ props.item.writes }}</td>
        <td class="vtop text-xs-right">{{ props.item.reads }}</td>
      <td class="vtop text-xs-right">{{ props.item.user }}</td>
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
        { text: 'Registered', value: 'registered' },
        { text: 'Start', value: 'start' },
        { text: 'Duration', value: 'duration' },
        { text: 'WriteL', value: 'writes' },
        { text: 'ReadL', value: 'reads' },
        { text: 'User', value: 'user' }
      ],
      items:[        
      ],
      selected: [],
      search: "",
      loading: false,
      autorefresh: true,
      timer:null
      }
  },
  methods:{
    getJobs(){
      this.loading=true;
	    HTTP.get("job")
	    .then(r=>{
	       this.loading=false
	       this.items=r.data
	       if(this.autorefresh) this.timer=setTimeout(()=>{ this.getJobs() }, 10000);
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
    },
  },
  created(){
    this.getJobs()
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
  }
}
</script>
