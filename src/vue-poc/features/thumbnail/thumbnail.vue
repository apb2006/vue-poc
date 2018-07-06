<!DOCTYPE html>
<template id="thumbnail">
 <v-container fluid>
 <v-stepper v-model="step" non-linear  >
  <v-stepper-header>
      <v-stepper-step step="1" :complete="step > 1" editable>Select image location</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="2" :complete="step > 2" editable>Set thumbnail details</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="3" editable>Result</v-stepper-step>
    </v-stepper-header>
  <v-stepper-items>
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
        <v-btn  color="primary"  @click="step = 2">Next</v-btn>
  </v-stepper-content>
  
  <v-stepper-content step="2" non-linear>
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px" >
    <vue-ace editor-id="editorA" :content="taskxml" mode="xml" wrap="true"
		v-on:change-content="onChange" 
		></vue-ace>
		</v-card>
   
    <v-btn flat @click="step -= 1">Back</v-btn>
    <v-btn  color="primary"  @click="validate()">Validate</v-btn>
     <v-btn  color="primary"  @click="step = 3">Next</v-btn>  
  </v-stepper-content>

  <v-stepper-content step="3" non-linear>
    <v-card class="grey lighten-1 z-depth-1 mb-5" >
     <v-card-actions>
    <v-btn flat @click="step -= 1">Back</v-btn>
     <v-btn  color="primary"  @click="go()">go</v-btn>
     </v-card-actions>
    <v-card-text>
    <v-layout  style="height:200px" fill-height>
    <v-flex xs6>
    <img :src="image" class="contain" style="width:100%; height:100%;"/>
    </v-flex>
    <v-flex xs6>
    <img :src="image" class="contain" style="width:50%; height:50%;object-position: 50% 50%;"/>
    </v-flex>
    </v-layout>
    </v-card-text>
   
    </v-card>
    
     
  </v-stepper-content>
  </v-stepper-items>
</v-stepper>
 </v-container>
</template>

<script>{
  data(){
    return {
      image:"https://cdn.pixabay.com/photo/2017/10/31/07/49/horses-2904536_960_720.jpg",
      step: 0,
      taskxml:"<task></task>",
      items:[
        {
          src: 'https://cdn.pixabay.com/photo/2017/10/31/07/49/horses-2904536_960_720.jpg'
        }]
      }
  },
  methods:{
    onChange (val) {
      if (this.taskxml !== val) this.taskxml = val;
      },
    validate(){
        alert("validate")
        HTTP.post("thumbnail/validate",Qs.stringify({task: this.taskxml}))
        .then(r=>{alert("gg")})
      },
    go(){
        alert("post")
        HTTP.post("thumbnail",Qs.stringify({task: this.taskxml,url:this.image}))
        .then(function(r){
          console.log(r)
       alert("not yet:"+r);
     })
      }
  },
  beforeRouteEnter (to, from, next) {
    Promise.all([settings.getItem('images/thumbtask')
                 ])
    .then(function(values) {
      next(vm => {
          vm.taskxml = values[0];
          })
          })
    },
     
  beforeRouteLeave (to, from, next) {
    // called when the route that renders this component is about to
    // be navigated away from.
    // has access to `this` component instance.
    settings.setItem('images/thumbtask',this.taskxml);
    next(true);
  },

}
</script>
