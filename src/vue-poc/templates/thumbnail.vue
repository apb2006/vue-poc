<!DOCTYPE html>
<template id="thumbnail">
 <v-container fluid>
 <v-stepper v-model="step" non-linear>
  <v-stepper-header>
      <v-stepper-step step="1" :complete="step > 1">Select image location</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="2" :complete="step > 2">Set thumbnail details</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="3">Result</v-stepper-step>
    </v-stepper-header>
  
  <v-stepper-content step="1" non-linear>
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px" >
    <v-text-field
              name="url"
              label="Image Url"
              hint="http:...??"
              v-model="image"
              required
             ></v-text-field>
    </v-card>
        <v-btn primary @click.native="step = 2">Next</v-btn>
  </v-stepper-content>
  
  <v-stepper-content step="2" non-linear>
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px" >
    <vue-ace editor-id="editorA" :content="taskxml" mode="xml" wrap="true"
		v-on:change-content="onChange" 
		></vue-ace>
		</v-card>
   
    <v-btn flat @click.native="step -= 1">Back</v-btn>
    <v-btn primary @click.native="validate()">Validate</v-btn>
     <v-btn primary @click.native="step = 3">Next</v-btn>  
  </v-stepper-content>

  <v-stepper-content step="3" non-linear>
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px" >
    output todo
    </v-card>

     <v-btn flat @click.native="step -= 1">Back</v-btn>
     <v-btn primary @click.native="go()">go</v-btn>
  </v-stepper-content>
</v-stepper>
 </v-container>
</template>

<script>{
  data(){
    return {
      image:"http://images.metmuseum.org/CRDImages/ep/original/DT46.jpg",
      step: 0,
      taskxml:"<task></task>"
      }
  },
  methods:{
    onChange (val) {
      if (this.taskxml !== val) this.taskxml = val;
      },
    validate(){
        alert
      },
    go(){
        alert("post")
        HTTP.post("thumbnail",Qs.stringify({task: this.taskxml,url:this.image}))
        .then(function(r){
          console.log(r)
       alert("not yet:"+r);
     })
      }
  }

}
</script>
