<!DOCTYPE html>
<template id="testhtml">
  <v-container fluid>
  <v-card >
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
     <v-chip >todo</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  
    </v-toolbar>
     <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
    <v-card-text v-if="!busy" v-html="report" @click.capture="onClick($event)"></v-card-text>
 </v-card>
 </v-container>
</template>

<script>{
  data: ()=>({
    busy: false,
    report: null,
    elapsed: null
  }),
  methods:{
    get(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("test/html")
      .then(r=>{
        this.busy=false
        this.report=r.data
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    },
    onClick(event){
      console.log("event",event);
      var isA= "a"== event.originalTarget.localName
     
      if(isA) {
       // alert("stop this"+ event.originalTarget.hash);
        console.log("tar",event.originalTarget.hash,document.querySelector(event.originalTarget.hash));
        event.preventDefault();
          this.$router.push({"hash":event.originalTarget.hash});
        //  this.$vuetify.goTo(event.originalTarget.hash, { duration: 600,   offset: -200, easing: 'easeInOutCubic'});

      }
    }
  },
  created:function(){
    console.log("reports")
    this.get()
  }
    }
</script>

