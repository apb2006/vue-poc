<!DOCTYPE html>
<template id="vuecompile">
 <v-container fluid>
    <v-card >
    <v-toolbar class="orange darken-1">
     <v-btn icon to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
      <span class="white--text">compile</span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn primary @click.native="submit()"   :loading="waiting"
      :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid>
        <v-layout row wrap>   
          <v-flex xs6>
            <v-text-field    v-model="params.proj"
              label="vue project to compile"
            ></v-text-field>
          </v-flex>
        </v-layout>
         <v-layout row wrap>
           <v-flex xs12>
            <code>{{code}}</code>
          </v-flex>
        </v-layout>
  
      </v-container>
    </v-card-text>
   
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
			      proj:"C:/Users/andy/git/vue-poc/src/vue-poc/"
			 },
			waiting:false,
			snackbar:{show:false,msg:"",context:"success"},
    }
  },
  methods:{
    submit(){
      this.waiting=true
      HTTP.post("tasks/vue-compile",Qs.stringify(this.params))
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
    code(){return 'code here'}
  }
}
</script>
