<!DOCTYPE html>
<template id="thumbnail">
 <v-container fluid>
 <v-stepper v-model="step" non-linear  >
  <v-stepper-header>
      <v-stepper-step step="1" :complete="step > 1" editable>Image source</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="2" :complete="step > 2" editable>Thumbnail parameters</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="3" editable>Thumbnail</v-stepper-step>
    </v-stepper-header>
  <v-stepper-items>
  <v-stepper-content step="1" non-linear>
    <v-card class="lime lighten-1 z-depth-1 mb-5" height="200px" >
    <v-card-text>
	    <v-text-field
	              name="url"
	              label="Image Url"
	              hint="http:...??"
	              v-model="image"
	              required
	             ></v-text-field>
     </v-card-text>
    <v-card-actions>
    <v-spacer></v-spacer>
        <v-btn  color="primary"  @click="step = 2">Next</v-btn>
        </v-card-actions>
          </v-card>
  </v-stepper-content>
  
  <v-stepper-content step="2" non-linear>
  
    <v-card class="lime lighten-1 z-depth-1 mb-5"  >
    <v-toolbar dense>
		<v-btn text @click="step -= 1">Back</v-btn>
		<v-spacer></v-spacer>
	    <v-btn  color="primary"  @click="validate()">Validate</v-btn>
	    <v-spacer></v-spacer>
	     <v-btn  color="primary"  @click="step = 3">Next</v-btn>  
		</v-toolbar>
		<v-flex xs12 style="height:400px"  fill-height>
	    <vue-ace editor-id="editorA" :content="taskxml" mode="xml" wrap="true"
			v-on:change-content="onChange" min-lines="7"
			></vue-ace>
        </v-flex>
		</v-card>
  
    
  </v-stepper-content>

  <v-stepper-content step="3" non-linear>
    <v-card :loading="loading" class="lime lighten-1 z-depth-1 mb-5" >
     <v-card-actions>
    <v-btn text @click="step -= 1">Back</v-btn>
    <v-spacer></v-spacer>
     <v-btn  color="primary"  @click="go()">refresh</v-btn>
     <div v-if="elapsed"> (took {{ elapsed }}ms.)</div>
     <v-spacer></v-spacer>
     </v-card-actions>
    <v-card-text>
    <v-layout  style="height:300px" fill-height>
    <v-flex xs6>
    <div>Source</div>
    <img :src="image" class="contain" style="width:100%; height:100%;"/>
    </v-flex>
    <v-flex xs6>
    <div>Thumbnail</div>
    <img ref="imgResult"  class="contain" style="width:100%; height:100%;object-position: 50% 50%;"/>
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
      image:"https://picsum.photos/id/123/500/700",
      step: 1,
      elapsed: null,
      taskxml:"<task></task>",
      items:[
        { src: 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Lycidae-Kadavoor-2017-05-22-001.jpg'},
        { src: 'https://picsum.photos/id/123/500/700' }
        ],
        loading: false
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
    	  var target= this.$refs.imgResult;
    	  var _start = performance.now();
    	  this.loading = true
    	  fetch("/vue-poc/api/thumbnail",
        		  {
    		      method: 'POST',
    		      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    		      body:  Qs.stringify({task: this.taskxml,url:this.image})
        		  }
        		  ).then(function(response) {
    		  return response.blob();
    		}).then(myBlob=> { 			
    		      target.src = URL.createObjectURL(myBlob);
    		      this.elapsed=Math.floor(performance.now() - _start);
    		      this.loading = false
    		});	  
      }
  },
  
  beforeRouteEnter (to, from, next) {
    Promise.all([Settings.getItem('images/thumbtask')
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
    Settings.setItem('images/thumbtask',this.taskxml);
    next(true);
  },

}
</script>
