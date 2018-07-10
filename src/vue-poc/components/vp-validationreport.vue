<!DOCTYPE html>
<!-- 
 show a validition report
 -->
<template id="vp-validationreport">
       <v-card  v-if="report" >
       
       <v-toolbar class="orange darken-1">
          <v-card-title>Validation</v-card-title>
          <span  v-for="(value, key) in report.msgcounts">{{ key }}:{{ value }}</span>
          </v-toolbar>
          
          <v-card-text>
            <pre >*** {{ report }}</pre>
          </v-card-text>
       
        </v-card>
</template>

<script>{
  props: ['report']
}
</script>
