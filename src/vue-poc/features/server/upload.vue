<!DOCTYPE html>
<template id="upload">
 <v-container fluid>
 <v-snackbar v-model="snack" color="success">File upload complete</v-snackbar>
 <v-card>
 <v-card-title>File transfers</v-card-title>
 <v-card-text>
 <qd-fileupload   url="upload" @complete="upit">up load</qd-fileupload>
 </v-card-text>
</v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      snack: false
      }
  },
  methods:{
    upit:function(s){
      this.snack=true;
    },
    
  }
}
</script>
