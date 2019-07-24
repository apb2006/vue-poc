<!DOCTYPE html>
<!-- 
 image  report
 
 -->
<template id="report"> <v-container fluid> <v-card>
<v-toolbar class="orange darken-1"> <v-btn icon to="./">
<v-icon>arrow_back</v-icon></v-btn> <v-card-title> <v-chip>Settings</v-chip>
</v-card-title> <v-spacer></v-spacer> </v-toolbar> <v-progress-linear v-if="busy"
	v-bind:indeterminate="true"></v-progress-linear> <v-card-text>
<ul v-if="report">
	<li>DB: {{ report.imagedb }}</li>
	<li><a :href="'/vue-poc/ui/database?url=/' + report.imagedb + '/'" target="new">db</a></li>
	<li></li>
</ul>
<pre>
    {{ report | pretty }}
    </pre> </v-card-text> </v-card> </v-container> </template>

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
      HTTP.get("images/report")
      .then(r=>{
        this.busy=false
        this.report=r.data
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    }
  },
  created:function(){
    console.log("reports")
    this.get()
  }
    }
</script>
