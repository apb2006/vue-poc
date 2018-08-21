<!DOCTYPE html>
<template id="runtask">
 <v-container fluid>
    <v-card >
    <v-toolbar>
    <v-toolbar-title>
     <v-breadcrumbs >
            <v-breadcrumbs-item  to="/tasks" :exact="true">
            Tasks
            </v-breadcrumbs-item>
            
              <v-breadcrumbs-item  >
            {{ task }}
            </v-breadcrumbs-item>
        </v-breadcrumbs>
      </v-toolbar-title>  
    <v-spacer></v-spacer>
     <v-btn  color="primary"  @click="submit()"   :loading="loading"
      :disabled="loading">
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
			loading: false,
			snackbar: {show:false,msg:"",context:"success"},
			valid: false
		  
    }
  },
  methods:{
    submit(){
      this.loading=true;
      this.$refs.params.submit()
      .then(r=>{
        this.loading= false
 
        this.snackbar= {show:true,
                        msg: r.data && r.data.msg, 
                        context:"success"
                        };
        console.log(r)
      })
      .catch(error=>{
        this.loading= false
        this.snackbar= {show:true,msg:"Problem",context:"error"}
        console.log(error);
      });
   }
  }
}
</script>
