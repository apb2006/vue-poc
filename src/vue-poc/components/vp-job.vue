<!DOCTYPE html>
<!-- 
 A toolbar that displays information about a job run
 job:{id:
      job:{id:,job:},
      jobState: {reads: writes:}
 -->
<template id="vp-job">
  <v-toolbar dense>
       <v-chip class="primary white--text">{{job.id}}</v-chip>
           <v-chip class="primary white--text">{{job.job}}</v-chip>
      
           <v-chip label class="grey white--text"> 
           <v-avatar class="red">W</v-avatar><v-icon>lock</v-icon>
           {{ jobState.writes }}</v-chip>
           
            <v-chip label class="grey white--text"> 
	            <v-avatar class="amber">R</v-avatar><v-icon>lock</v-icon>
	            {{ jobState.reads }}</v-chip>
 
        <v-spacer></v-spacer>
          <v-progress-circular v-if="waiting" indeterminate class="primary--text"></v-progress-circular>
          <v-chip>{{ jobState.state }}</v-chip>
         <v-chip class="primary white--text">
          <v-avatar >  <v-icon>timer</v-icon></v-avatar>
         {{elapsed}}ms</v-chip>
   </v-toolbar>
</template>

<script>{
  props: ['job',
          'jobState',
          'elapsed',
          'waiting' 
          ],
  created:function(){
      console.log("vp-job: ", this.job);
    }
}
</script>
