<!DOCTYPE html>
<template id="eval">
 <v-container fluid>
  <v-card >

     <v-toolbar>
      <v-btn @click="run()">Run</v-btn>
    <v-btn @click="submit()">
    <v-icon>play_circle_outline</v-icon>
    Submit</v-btn>
    <v-spacer></v-spacer>
     <v-btn @click="imports()">
    <v-icon>play_circle_outline</v-icon>
    Imports</v-btn>
     <v-menu offset-y>
      <v-btn icon primary dark slot="activator"> <v-icon>more_vert</v-icon></v-btn>
      <v-list>
        <v-list-tile @click="plan">Show query plan</v-list-tile>
     </v-list>
      <v-list>
        <v-list-tile @click="hitme">hit me</v-list-tile>
     </v-list>
     </v-menu>
   </v-toolbar>

  
  <v-card-text   >
  <v-flex xs12 style="height:200px"  fill-height>
  <vue-ace  :content="xq" mode="xquery" wrap="true"
    v-on:change-content="onChange" 
    ></vue-ace>
    </v-flex>
   </v-card-text>
    <v-alert error v-bind:value="showError">
      {{result}}
    </v-alert>
     <v-card-actions v-if="show" >

      <v-chip class="primary white--text">{{jobId}}</v-chip>
      
           <v-chip label class="grey white--text"> 
           <v-avatar class="red">  <v-icon>lock</v-icon>W</v-avatar>
           {{ jobState.writes }}</v-chip>
            <v-chip label class="grey white--text"> 
            <v-avatar class="amber"> <v-icon>lock</v-icon>R</v-avatar>
            {{ jobState.reads }}</v-chip>
 
        <v-spacer></v-spacer>
          <v-progress-circular v-if="waiting" indeterminate class="primary--text"></v-progress-circular>
          <v-chip>{{ jobState.state }}</v-chip>
         <v-chip class="primary white--text">
          <v-avatar >  <v-icon>timer</v-icon></v-avatar>
         {{elapsed}}ms</v-chip>
         
    </v-card-actions>
     <v-card-text v-if="showResult">
     <v-flex xs12 style="height:200px"  fill-height>
        <vue-ace  :content="result" mode="text" wrap="false" read-only="true"
        ></vue-ace>
        </v-flex> 
       </v-card-text>
    </v-card>

 </v-container>
</template>

<script>{
  data:  function(){
    return {
      xq: '(: type your XQuery :)\n',
      result:'',
      elapsed: null,
      show: false,
      showError: false, //unused
      showResult: false, //
      jobId: null,
      waiting: false,
      start: null,
      jobState: {}
      }
  },
  methods:{
    onChange(val){
      if (this.xq !== val) {
        this.xq = val
      }
    },
    
    run(){
      this.awaitResult(false)
      this.start = performance.now();
      HTTP.post("eval/execute",Qs.stringify({xq:this.xq}))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=r.data.result
        this.jobId=null
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
      localforage.setItem('eval/xq', this.xq)
    },
    submit(){
      var data={xq:this.xq}
      this.showResult=this.show=false
      this.start = performance.now();
      HTTP.post("eval/submit",Qs.stringify(data))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.jobId=r.data.job
        this.show=true
        this.pollState()
        
      })
      .catch(r=> {
        console.log("error",r)
        this.jobId=r.response.job
        this.showError=true;

      });
    },
    pollState(){
      this.waiting=true;
      HTTP.get("job/"+this.jobId)
      .then(r=>{
        this.jobState=r.data
        this.waiting=r.data.state!="cached";
        this.elapsed=Math.floor(performance.now() - this.start);
         if(this.waiting) {
           setTimeout(()=>{ this.pollState() }, 5000);
         }else{
           this.getResult()
         }
      })
    },
    getResult(){
      this.awaitResult(true)
       HTTP.post("eval/result/"+this.jobId)
       .then(r=>{
         this.result=r.data.result
       })
    },
    hitme(){
      this.showResult=true
      setTimeout(()=>{this.result="123\n".repeat(20000); },10);

    },
    imports(){
      alert("@TODO imports")
    },
    plan(){
      this.awaitResult(false)
      HTTP.post("eval/plan",Qs.stringify({xq:this.xq}))
      .then(r=>{
        this.result=r.data.result
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
    },
    awaitResult(show){
      // ace slow when setting large text while hidden
      this.show=show
      this.result="(Please wait..)"
      this.showResult=true
    }
  },
  
  created:function(){
      localforage.getItem('eval/xq').then((value) => { this.xq=value || this.xq});
  }
}
</script>
