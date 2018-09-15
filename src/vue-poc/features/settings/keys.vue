<!DOCTYPE html>
<template id="keys">
 <v-container fluid>
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
	 <v-card>
	  <v-toolbar dense>
	   <v-toolbar-title >keys</v-toolbar-title>
	   <v-spacer></v-spacer>
   <v-btn @click="wipe" color="error">Delete ALL</v-btn>
	   </v-toolbar>

   <v-card-text>
    <v-expansion-panel>
    <v-expansion-panel-content popout
     v-for="key in keys"
      :key="key"
    >
     <div slot="header">{{key}}</div>
  <v-card>
        <v-card-text>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor 
        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
        ullamco laboris nisi ut aliquip ex ea commodo consequat.</v-card-text>
      </v-card>
     </v-expansion-panel-content>
     </v-expansion-panel> 
   </v-card-text>
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
