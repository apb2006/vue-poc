<!DOCTYPE html>
<template id="eval">
 <v-container fluid>
  <v-card  @keyup.ctrl.enter="submit">
     <v-toolbar dense> 
     <v-menu offset-x> 
     <template v-slot:activator="{ on }"> 
	<v-btn v-on="on" text icon
	color="pink"> 
	<v-icon>label_outline</v-icon> 
	</v-btn> 
	</template> 
  <v-card>
<v-card-title>Outline here</v-card-title> </v-card> </v-menu>
    
      <v-menu offset-x>
       <template v-slot:activator="{ on }">
           <v-btn  v-on="on" text icon color="pink">
              <v-icon>add_circle</v-icon>
            </v-btn>
        </template>    
        <v-card>
	       <v-btn @click="imports">
	    <v-icon>library_books</v-icon>
	    Imports</v-btn>
	     <v-btn @click="namespaces">
	    <v-icon>label</v-icon>
	    Namespaces</v-btn>
	    </v-card>
    </v-menu>
      <v-spacer></v-spacer>
    <v-btn  @click="submit" >
      <v-icon>play_circle_outline</v-icon>jobs:run
      </v-btn>
    <v-menu offset-y left>
      <template v-slot:activator="{ on }">
           <v-btn  v-on="on" text icon >
              <v-icon>more_vert</v-icon>
            </v-btn>
      </template>    
    
      <v-list  dense>
         <v-subheader>More actions...</v-subheader>
        <v-divider></v-divider>
        
        <v-list-item  @click="run">
          <v-list-item-title>xquery:eval</v-list-item-title>
        </v-list-item>
        
         <v-list-item  @click="plan">
          <v-list-item-title>Show query plan</v-list-item-title>
        </v-list-item>
        
        <v-list-item @click="hitme">
         <v-list-item-title>Test large result.</v-list-item-title>
         </v-list-item>
     </v-list>
    </v-menu>
   
   
    
   </v-toolbar>
   <v-card-text>
    <v-flex xs12 style="height:200px"  fill-height>
		  <vue-ace  :content="xq" mode="xquery" wrap="true"
		     :settings="aceSettings" v-on:change-content="onChange" 
		     :completer="[$aceExtras.basexCompleter, $aceExtras.rhymeCompleter]" 
		     placeholder="Type XQuery here then click run.."
		    ></vue-ace>
    </v-flex>
    <vp-job  v-if="showJob" :job="job" :waiting="waiting" :job-state="jobState" :elapsed="elapsed"></vp-job>
     </v-card-text>
    <v-card-text v-if="showError">
     <v-alert color="error" v-model="showError">Error </v-alert>
    </v-card-text>
    
     <v-card-text v-if="showResult">
		     <v-flex xs12 style="height:200px"  fill-height>
		        <vue-ace  :content="result" mode="text" wrap="false" read-only="true" 
		        :settings="aceSettings" 
		        ></vue-ace>
        </v-flex> 
     </v-card-text>
       
      
       
    </v-card>

 </v-container>
</template>

<script>{

  data:  function(){
    return {
      xq: null,
      result: '',
      done: false,
      elapsed: null,
      showJob: false,
      showError: false, 
      showResult: false, //
      job: {}, // {id:"12",job:"job13", dateTime:""}
      waiting: false,
      destroyed: false,
      start: null,
      jobState: {},
      aceSettings:{}
      }
  },
  methods:{
    onChange(val){
      if (this.xq !== val) {
        this.xq = val
      }
    },
    // execute imediatly
    run(){
    	  console.log("run:",this.xq);
      this.showResult= true;
      this.start = performance.now();
      HTTPNE.post("eval/execute",Qs.stringify({xq:this.xq}))
      .then(r=>{
        console.log("exec:",r);
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=r.data.job
        this.jobId=null
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
      localforage.setItem('eval/xq', this.xq)
    },
    // request run
    submit(){
      this.showError=this.showResult=this.showJob=false
      this.start = performance.now();
      console.log("*****",Qs.stringify({xq:this.xq}));
      HTTP.post("eval/submit",Qs.stringify({xq:this.xq}))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.job=r.data
        this.showJob=true
        this.pollState()
        
      });
      
    },
    // 
    pollState(){
      if(this.destroyed)return;
      this.waiting=true;
      HTTP.get("job/"+this.job.job)
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
       HTTPNE.post("eval/result/"+this.job.job)
       .then(r=>{
         this.result=r.data.result+" "
         this.done= true;
         console.log("$$$$$",this.result);
       }).catch(r=> {
        // alert("catch")
         console.log("error",r)
         this.result=r.response.data
         this.showError=true;
         this.done= true;
       });
    },
    hitme(){
      this.showResult=true
      setTimeout(()=>{this.result="123\n".repeat(20000); },10);

    },
    imports(){
      alert("@TODO imports")
    },
    namespaces(){
      alert("@TODO namespaces")
    },
    plan(){
      this.awaitResult(true)
      HTTPNE.post("eval/plan",Qs.stringify({xq:this.xq}))
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

      this.showError= false
      this.show= show
      this.result= "(Please wait..)"
      this.showResult= true
    }
  },
  computed: { 
  },
  
  beforeRouteEnter (to, from, next) {
    Settings.getItem('settings/ace')
    .then( v =>{
      
      next(vm => {
        console.log('eval settings: ',v);
        vm.aceSettings = v;
        })})
     },
     
     beforeRouteLeave (to, from, next) {
    	 localforage.setItem('eval/xq',this.xq);
    	 next()
     },
    	  
  created:function(){
      console.log("eval: creatd");
      localforage.getItem('eval/xq').then((value) => { this.xq= value || this.xq});
  },
  beforeDestroy:function(){
    this.destroyed=true;
    console.log("eval: before destroy");
}
}
</script>
