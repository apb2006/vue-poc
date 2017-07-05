<!DOCTYPE html>
<template id="eval">
 <v-container fluid>
  <v-card class="grey lighten-1 z-depth-1 mb-5">
  

 
     <v-app-bar>
      <v-btn @click.native="run()">Run</v-btn>
    <v-btn @click.native="submit()">
    <v-icon>play_circle_outline</v-icon>
    Submit</v-btn>
    <v-btn-dropdown v-bind:options="dropdown_font" max-height="auto" overflow></v-btn-dropdown>
   </v-app-bar>

  
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
       
        JobId:
      <v-chip class="green white--text">{{jobId}}</v-chip>
       <v-progress-circular v-if="waiting" indeterminate class="primary--text"></v-progress-circular>
         Elapsed:
         <v-chip class="green white--text">{{elapsed}}</v-chip>
        <v-spacer></v-spacer>
      <v-btn flat class="green--text darken-1">@TODO</v-btn>
    </v-card-actions>
     <v-card-text v-if="show">
     <v-flex xs12 style="height:200px"  fill-height>
        <vue-ace  :content="result" mode="text" wrap="true" read-only="true"
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
      elapsed:null,
      show:false,
      showError:false,
      jobId:null,
      waiting:false,
      start:null,
      dropdown_font: [
        { text: 'Arial' },
        { text: 'Calibri' },
        { text: 'Courier' },
        { text: 'Verdana' }
      ]
      }
  },
  methods:{
    onChange(val){
      if (this.xq !== val) {
        this.xq = val
      }
    },
    
    run(){
      var data={xq:this.xq}
      this.showError=this.show=false
      this.start = performance.now();
      HTTP.post("eval/execute",Qs.stringify(data))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=r.data.result
        this.jobId=null
        this.show=true
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
      this.showError=this.show=false
      this.start = performance.now();
      HTTP.post("eval/submit",Qs.stringify(data))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=this.jobId=r.data.job
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
       HTTP.post("eval/result/"+this.jobId)
       .then(r=>{
         this.result=r.data.result
         this.jobId=null
         this.show=true
       })
    }
  },
  
  created:function(){
      localforage.getItem('eval/xq').then((value) => { this.xq=value || this.xq});
  }
}
</script>
