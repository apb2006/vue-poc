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
    <vp-entitylink entity="basex.job"></vp-entitylink> 
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
    <template v-slot:item.id="{ item }">
         <router-link :to="{name: 'job1', params: {job: item.id }}">{{ item.id }}</router-link>     
      </template>
      
     <template v-slot:item.isService="{ item }">
        <router-link v-if="item.isService" title="Service"
                :to="{name: 'service1', params: { service: item.id }}">
            <v-avatar color="red" size="24">
		      <span class="white--text headline">S</span>
		    </v-avatar>
		</router-link>
      </template>
        
     <template v-slot:item.registered="{ item }">
         <span>{{ item.registered | formatDate}}</span>
      </template>
       
      <template v-slot:item.start="{ item }">
         <span>{{ item.start | fromNow }}</span>
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
        { text: 'Service?', value: 'isservice' }, // https://stackoverflow.com/a/58034316/3210344      
        { text: 'Start', value: 'start' },
        { text: 'Interval', value: 'interval' },
        { text: 'Registered', value: 'registered' },
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
	       this.items=r.data.items
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
