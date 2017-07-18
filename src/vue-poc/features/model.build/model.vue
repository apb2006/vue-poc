<!DOCTYPE html>
<template id="model">
 <v-container fluid>
    <v-card >
     <v-card-title class="blue accent-4">
      <span class="white--text">Generate <code>model.gen.xqm</code></span>      
    </v-card-title>
    <v-card-text>
      <v-container fluid>
        <v-layout row wrap>
          
          <v-flex xs6>
            <v-text-field    v-model="params.efolder"
              label="Folder containing model  definitions as xml"
            ></v-text-field>
          </v-flex>
        
          <v-flex xs6>
            <v-text-field v-model="params.target"
              label="Path to xqm file to generate"  
            ></v-text-field>
          </v-flex>
           <v-flex xs12>
            <code>{{code}}</code>
          </v-flex>
        </v-layout>
  
      </v-container>
    </v-card-text>
    <v-card-actions>
      <v-btn primary @click.native="submit()"   :loading="waiting"
      :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
     </v-card-actions>
      <v-snackbar    v-model="snackbar.show"
      :timeout="6000"
      :success="snackbar.context === 'success'"
      :error="snackbar.context === 'error'"
    >
      {{ snackbar.msg }}
      <v-btn dark flat @click.native="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      params:{
			      efolder:"C:/Users/andy/git/vue-poc/src/vue-poc/models",
			      target:"C:/Users/andy/git/vue-poc/src/vue-poc/models.gen.xqm"
			 },
			waiting:false,
			snackbar:{show:false,msg:"",context:"success"},
    }
  },
  methods:{
    submit(){
      this.waiting=true
      HTTP.post("tasks/model",Qs.stringify(this.params))
      .then(r=>{
        this.waiting=false      
        this.snackbar={show:true,msg:r.data.msg,context:"success"}
        console.log(r.data)
      })
      .catch(error=>{
        this.waiting=false
        this.snackbar={show:true,msg:"Problem",context:"error"}
        console.log(error);
      });
   }
  },
  computed:{
    code(){return 'import module namespace entity = "quodatum.models.generated" at "'+this.params.target+'";'}
  }
}
</script>
