<!DOCTYPE html>
<template id="job">
  <v-card >
   <v-toolbar light>
      <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
    
    
     <v-btn  
      @click="stop()"
      :disabled="noSelection"
    >Stop</v-btn>
    
      <v-spacer></v-spacer>
      <v-btn light icon  :loading="loading"   @click="getJob()"  :disabled="loading">
         <v-icon>refresh</v-icon>
    </v-btn>
     
    </v-toolbar>
  <v-card-text>Job: {{ job }}
  </v-card-text>
 </v-card>
</template>

<script>{
  props: ['job'],
  data:  function(){
    return {
      jobstate:null,
      selected:[],
      search:"",
      loading:false
      }
  },
  methods:{
    getJob(){
      this.loading=true;
	    HTTP.get("job/" + this.job )
	    .then(r=>{
	       this.loading=false
	       this.jobstate=r.data
	       setTimeout(()=>{ this.getJob() }, 10000);
	    })
	   
    },
    stop(){
      var s=this.selected.map((j)=>{return j.id}).join(",")
      console.log("AAA",this.selected)
      alert(s)
    }
  },
  computed: {
    // a computed getter
    noSelection: function () {
      // `this` points to the vm instance
      return this.selected.length==0
    }
  },
  created(){
   //this.getJob()
  }
}
</script>
