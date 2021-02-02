<!DOCTYPE html>
<template id="upload">
 <v-container fluid>
 <v-snackbar v-model="snack" color="success">File upload complete</v-snackbar>
 <v-card>
 <v-card-title>File transfers</v-card-title>
 <v-card-text>
 <p>Currently files are saved to <code>db:option('dbpath') || '/.vue-poc'</code></p>
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
    post(){
    	let rawData = {
                name: this.name,
                gender: this.gender,
                dob: this.dob
              }
        rawData = JSON.stringify(rawData)
        
        this.snack = false
    	let formData = new FormData()
        formData.append('file', this.file, this.file.name)
        let response = HTTP.post('upload', formData, {
              headers: {
                'Content-Type': 'multipart/form-data'
              }
         }).then(r=>{
        	 this.snack=true; 
         })
    }
  }
}
</script>
