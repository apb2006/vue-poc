<!DOCTYPE html>
<!-- form to submit a run
 -->
<template id="runtask">
 <v-container fluid>
    <v-card >
    <v-toolbar>
    <v-toolbar-title>
       <v-breadcrumbs :items="crumbs">
		      <template slot="item" slot-scope="props">
		            <v-breadcrumbs-item  :to="props.item.to" :disabled="props.item.disabled" :exact="true">
		            {{ props.item.text }}
		            </v-breadcrumbs-item>
		      </template>
      </v-breadcrumbs>
 
      </v-toolbar-title>  
    <v-spacer></v-spacer>
       <router-link :to="{name:'taskhistory', query:{task: task}}"><v-icon>history</v-icon></router-link>
   
     <v-btn  color="primary"  @click="submit()"   :loading="loading"
      :disabled="loading">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
     </v-toolbar>
     
     <v-card-text v-if="id">
       {{ id }}
     </v-card-text>
     
    <v-card-text>
      <v-container fluid>
          <vp-paramform  v-if="!loading" ref="params" :endpoint="endpoint"></vp-paramform>
      </v-container>
    </v-card-text>
      <v-snackbar    v-model="snackbar.show"
      :timeout="6000"
      :success="snackbar.context === 'success'"
      :error="snackbar.context === 'error'"
    >
      {{ snackbar.msg }}
      <v-btn dark text @click="snackbar.show = false">Close</v-btn>
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
			valid: false,
			id: null,
			crumbs: [{to:"/tasks", text:"Tasks"},
				     {to:"/tasks/"+this.task, text: this.task},
				     {text:"run", disabled: true}]
		  
    }
  },
  methods:{
    submit(){   
      var p=this.$refs.params.submit()     
      if(!p)return
      this.loading=true;
      p.then(r=>{
        this.loading= false
        this.id=r.data.id;
        this.snackbar= {show:true,
                        msg: r.result, 
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
  },
  computed:{
	  endpoint(){
		  return 'tasks/'+this.task + (this.id? "?id=" + this.id:'')
	  }
  },
  watch:{
    id(v){
      this.$router.push({  query: { id: this.id }})
      }   
  },
  
  created:function(){
    if(this.$route.query.id) this.id=this.$route.query.id
  }
}
</script>
