<!DOCTYPE html>
<template id="runtask">
 <v-container fluid>
    <v-card >
    <v-toolbar class="orange darken-1">
     <v-btn icon to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
      <span class="white--text">Task: {{ task }}</span>      
    </v-card-title>
    <v-spacer></v-spacer>
     <v-btn  @click="$refs.params.clear()" :loading="loading"
      :disabled="loading"
          >Clear</v-btn>
     <v-btn  @click="$refs.params.reset()" :loading="loading"
      :disabled="loading"
          >Reset</v-btn>
      <v-spacer></v-spacer>
     <v-btn  color="primary"  @click="submit()"   :loading="waiting"
      :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid>
        <v-layout row wrap>   
          <v-flex xs12>
                 <vp-paramform ref="params" :endpoint="'tasks/'+task"></vp-paramform>
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
      <v-btn dark flat @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-card>
 </v-container>
</template>

<script>{
  props:["task"],
  data:  function(){
    return {
			waiting:false,
			snackbar:{show:false,msg:"",context:"success"},
			valid: false
		  
    }
  },
  methods:{
    submit(){
      this.waiting=true;
      var params=this.$refs.params.submit();
      HTTP.post("tasks/" + this.task, Qs.stringify(params))
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
