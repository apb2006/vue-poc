<!DOCTYPE html>
<template id="showsettings">
 <v-container fluid>
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
<v-switch label="Dark theme" v-model="$vuetify.theme.dark" ></v-switch>
<v-switch label="Use service worker" v-model="serviceworker" @change="worker"></v-switch>
	 <v-card>
	   <v-card-title class="lime darken-1">Available settings</v-card-title>
	  
	 <v-card-text>
	   <v-list dense>
		   <v-list-item>
		      <router-link to="settings/ace">Editor</router-link>
		   </v-list-item>
		    <v-list-item>
		      <router-link to="settings/keys">Keys</router-link>
		   </v-list-item>
	   </v-list>
   </v-card-text>
   </v-card>
   
 </v-container>
</template>

<script>{
  data(){return {
    keys: ["?"],
    showDev: false,
    serviceworker: true
  }
  },
  methods:{
    worker(){
      Settings.setItem('features/serviceworker',this.serviceworker)
      .then(v=>{
        console.log("worker",this.serviceworker)
      })
    }
  },
  
  created(){
    console.log("settings")
    Settings.keys()
    .then( v =>{
     this.keys=v
    })
   },
   
   beforeRouteEnter (to, from, next) {
     Promise.all([
      Settings.getItem('features/serviceworker'),
      Settings.getItem('settings/dark')
      ])
      .then( v =>{
        next(vm => {
                   console.log("got ",v)
                   vm.serviceworker = v[0];
                   vm.dark = v[1];
        })
          })
          
   }
}
</script>
