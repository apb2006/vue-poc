<!DOCTYPE html>
<!-- 
 job component
 job:{id:
      job:
 -->
<template id="vp-job">
 <v-card  >

     <v-toolbar  dense>
     <v-card-title>Details:</v-card-title>
       <v-chip class="primary white--text">{{job.id}}</v-chip>
         <v-spacer></v-spacer>
           <v-chip class="primary white--text">{{job.job}}</v-chip>
      
           <v-chip label class="grey white--text"> 
           <v-avatar class="red">  <v-icon>lock</v-icon>W</v-avatar>
           {{ jobState.writes }}</v-chip>
           
            <v-chip label class="grey white--text"> 
              <v-avatar class="amber"> <v-icon>lock</v-icon>R</v-avatar>
              {{ jobState.reads }}</v-chip>
 
      
          <v-chip>{{ jobState.state }}</v-chip>
         <v-chip class="primary white--text">
          <v-avatar >  <v-icon>timer</v-icon></v-avatar>
         {{elapsed}}ms</v-chip>
    </v-toolbar>
    <v-card-text   >
  <v-flex xs12 style="height:60px;"  fill-height>
  <vue-ace  :content="query" mode="xquery" wrap="true" :read-only="true"
     
    ></vue-ace>
    </v-flex>
   </v-card-text>
   <!-- result -->
    <v-card-text  >
  <v-flex  xs12  style="height:60px;" fill-height>
  <vue-ace  :content="result" mode="xquery" min-lines="1" wrap="true" read-only="true" ></vue-ace>
    </v-flex>
   </v-card-text>
   </v-card>
   
</template>

<script>{
  props: ['job',
          'result',
          'jobState',
          'elapsed',
          'query' 
          ],
  data:function(){
    return {
      error:    null,
      res1: "??"
    }
  },
  watch:{
    result:function(a){
      if(this.res1 === "???"){ this.res1=a};
      console.log("vp-result:",a);
    }
  },
  computed:{
    aresult:function(){return this.res1 || "none"}
  },
  created:function(){
      console.log("vp-job: ", this.job,this.result);
    }
}
</script>
