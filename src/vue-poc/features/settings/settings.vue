<!DOCTYPE html>
<template id="settings">
 <v-container fluid>
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
<v-switch label="Dark theme" v-model="dark" @change="theme"></v-switch>
	 <v-card>
	   <v-card-title class="lime darken-1">Available settings</v-card-title>
	  


	 <v-card-text>
	   <router-link to="/acesettings">Editor</router-link>
   </v-card-text>
   </v-card>
    <v-switch label="Show advanced options" v-model="showDev"></v-switch>
   <v-card  v-if="showDev">
   <v-card-title class="amber darken-1">System information</v-card-title>
   <v-card-text>keys
   <ul >
  <li v-for="key in keys">
    {{ key }}
  </li>
</ul>
   </v-card-text>
   <v-card-actions>
   <v-spacer></v-spacer>
   <v-btn @click="wipe" error>Wipe</v-btn></v-card-actions>
   </v-card>
 </v-container>
</template>

<script>{
  data(){return {
    keys: ["?"],
    showDev: false,
    dark:false
  }
  },
  methods:{
    wipe(){
      if(confirm("wipe localstorage? "+this.keys.length)) settings.clear();
    },
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
