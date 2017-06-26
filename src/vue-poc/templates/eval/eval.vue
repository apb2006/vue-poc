<!DOCTYPE html>
<template id="eval">
 <v-container fluid>
  <v-card class="grey lighten-1 z-depth-1 mb-5">
  
  <v-card-row>
  <v-btn @click.native="run()">Run</v-btn>
    <v-btn @click.native="submit()">Submit</v-btn>
  </v-card-row>
  
  <v-card-row  height="200px" >
  <vue-ace  :content="xq" mode="xquery" wrap="true"
    v-on:change-content="onChange" 
    ></vue-ace>
   </v-card-row>
   
    </v-card>
    
   <v-alert error v-bind:value="showError">
      {{result}}
    </v-alert>
    
     <v-card v-if="show" class="grey lighten-1 z-depth-1 mb-5">
      
      <v-card-row height="200px">
        <vue-ace  :content="result" mode="text" wrap="true" read-only="true"
        ></vue-ace> 
       </v-card-row>
        <v-card-row actions>
        
         <v-chip class="green white--text">
        <v-avatar class="green darken-4">{{elapsed}}</v-avatar>
         Elapsed:
      </v-chip>
      
      <v-chip class="green white--text">  
        <v-avatar class="green darken-4">{{jobId}}</v-avatar>
         JobId:
      </v-chip>
      
        <v-spacer></v-spacer>
      <v-btn flat class="green--text darken-1">@TODO</v-btn>
    </v-card-row>
           
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
      jobId:null
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
      var _start = performance.now();
      HTTP.post("eval/execute",Qs.stringify(data))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - _start);
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
      var _start = performance.now();
      HTTP.post("eval/submit",Qs.stringify(data))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - _start);
        this.result=this.jobId=r.data.job
        this.show=true
      })
      .catch(r=> {
        console.log("error",r)
        this.jobId=r.response.job
        this.showError=true;

      });
    }
  },
  
  created:function(){
      localforage.getItem('eval/xq').then((value) => { this.xq=value || this.xq});
  }
}
</script>
