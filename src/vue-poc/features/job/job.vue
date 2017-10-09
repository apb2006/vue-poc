<!DOCTYPE html>
<template id="job">
  <v-card >
   <v-toolbar >
      <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
      <v-toolbar-title>{{ job }}</v-toolbar-title>
    
     <v-btn v-if="!finished"   @click="stop()" :disabled="finished" >Stop</v-btn>
     <v-btn v-if="finished && !result"  @click="getResult()" :disabled="result || !finished">Result</v-btn>
    <v-chip class="orange white--text">{{  jobstate.state }}</v-chip>
  
        <v-chip label class="grey white--text"><v-icon class="red">lock</v-icon>{{  jobstate.writes }}</v-chip>
       <v-chip label class="grey white--text"><v-icon class="amber">lock</v-icon>{{  jobstate.reads }}</v-chip>
      <v-spacer></v-spacer>
       <v-chip class="primary white--text">
      <v-avatar>
        <v-icon>account_circle</v-icon>
      </v-avatar>
     {{  jobstate.user }}</v-chip>
       <v-chip class="green white--text">
        <v-avatar ><v-icon>timer</v-icon></v-avatar>
       {{  jobstate.duration }}</v-chip>
      <v-btn  icon  :loading="loading"   @click="getJob()"  :disabled="loading || finished">
         <v-icon>refresh</v-icon>
    </v-btn>     
    </v-toolbar>
    
    <v-card-text v-if="result">
     {{ result }}
  </v-card-text>
  
  <v-card-text>
     <code>{{ jobstate.text }}</code>
  </v-card-text>
  
 </v-card>
</template>

<script>{
  props: ['job'],
  data:  function(){
    return {
      jobstate:{state:"?",user:"?",duration:"?"},
      result:null,
      loading:false
      }
  },
  methods:{
    getJob(){
      this.loading=true;
	    HTTP.get("job/" + this.job )
	    .then(r=>{
	       this.loading=false
	       this.jobstate=r.data
	       if(!this.jobstate.id) this.jobstate={state:"cached", text:"Job not found"}
	       if(!this.finished)setTimeout(()=>{ this.getJob() }, 10000);
	    })
	   
    },
    getResult(){
      HTTP.post("eval/result/"+this.job)
      .then(r=>{
        this.result=r.data.result
    })
    },
    stop(){
      alert("todo stop" + this.job)
    }
  },
  computed: {
    finished(){
      return this.jobstate.state == 'cached'
      }
  },
  created(){
    this.getJob()
  }
}
</script>
