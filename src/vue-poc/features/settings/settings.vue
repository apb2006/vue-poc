<!DOCTYPE html>
<template id="settings">
 <v-container fluid>
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
<v-switch label="Dark theme" v-model="dark" @change="theme"></v-switch>
<v-switch label="Use service worker" v-model="serviceworker" ></v-switch>
	 <v-card>
	   <v-card-title class="lime darken-1">Available settings</v-card-title>
	  
	 <v-card-text>
	   <v-list dense>
		   <v-list-tile>
		      <router-link to="settings/ace">Editor</router-link>
		   </v-list-tile>
		    <v-list-tile>
		      <router-link to="settings/keys">Keys</router-link>
		   </v-list-tile>
	   </v-list>
   </v-card-text>
   </v-card>
   
 </v-container>
</template>

<script>{
  data(){return {
    keys: ["?"],
    showDev: false,
    dark:false,
    serviceworker:true
  }
  },
  methods:{
   
    theme(){
     this.$root.$emit("theme",this.dark)
    }
  },
  created(){
    console.log("settings")
    settings.keys()
    .then( v =>{
     this.keys=v
    })
     
  }
}
</script>
