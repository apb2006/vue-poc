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
     <v-card v-if="show">
      <v-card-row height="200px">
        <vue-ace  :content="result" mode="text" wrap="true" read-only="true"
        ></vue-ace> 
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
      showError:false
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
      HTTP.post("eval/execute",Qs.stringify(data))
      .then(r=>{
        this.result=r.data.result
        this.show=true
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
    },
    submit(){
      alert("submit")
    }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}
</script>
