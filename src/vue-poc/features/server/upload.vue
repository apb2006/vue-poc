<!DOCTYPE html>
<template id="upload">
 <v-container fluid>
 <v-snackbar v-model="snack" color="success">File upload complete</v-snackbar>
 <v-card>
 <v-card-title>File transfers</v-card-title>
 <v-card-text>
 <v-file-input v-model="file" label="File input"></v-file-input>
 <v-btn @click="post()" :disabled="!file">submit</v-btn>
 </v-card-text>
</v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      snack: false,
      file: null
      }
  },
  methods:{
    upit:function(s){
      this.snack=true;
    },
    post(){
    	let rawData = {
                name: this.name,
                gender: this.gender,
                dob: this.dob
              }
        rawData = JSON.stringify(rawData)
    	let formData = new FormData()
        formData.append('avatar', this.file, this.file.name)
        formData.append('data', rawData)
        let response = HTTP.post('upload2', formData, {
              headers: {
                'Content-Type': 'multipart/form-data'
              }
         }).then(r=>{
        	console.log("upload: ",r)	 
         })
    }
  }
}
</script>
