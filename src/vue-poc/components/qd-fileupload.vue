<!DOCTYPE html>
<!-- 
 simple file upload component
 https://stackoverflow.com/questions/52645358/vuetify-file-uploads
 -->
<template id="qd-fileupload">
	<div>
	  <v-btn  @click="openFileDialog">
	      Select
	   </v-btn>
	   
	   <v-btn  @click="uploadFile"  icon>
      <v-icon>cloud_upload</v-icon>
     </v-btn>
     
      <input type="file" name="files" ref="file-upload" multiple="multiple" style="display:none" @change="onFileChange"/>
   </div>
</template>
<script>{
		props: ['url'
		  ],
		data() {
		  return {
		    formData: new FormData()
		  }
		},
		methods: {
		  openFileDialog() {
		    this.$refs['file-upload'].click();
		  },
		  onFileChange(e) {
		      var self = this;
		      var files = e.target.files || e.dataTransfer.files;       
		      if(files.length > 0){
		          for(var i = 0; i< files.length; i++){
		              self.formData.append("files", files[i], files[i].name);
		          }
		          
		      }   
		  },
		  uploadFile() {
		      var self = this; 
		      HTTP.post( this.url, self.formData).then(function (response) {
		          console.log(response);
		          self.$emit("complete",response)
		      }).catch(function (error) {
		          console.log(error);
		      });
		  }
		}
}</script>