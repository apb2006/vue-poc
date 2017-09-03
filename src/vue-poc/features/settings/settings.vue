<!DOCTYPE html>
<template id="settings">
 <v-container fluid>
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
	 <v-card>
	   <v-card-title class="lime darken-1">Available settings</v-card-title>
	 <v-card-text>
	   <router-link to="/acesettings">Editor</router-link>
   </v-card-text>
   </v-card>
   <div>.</div>
   <v-card >
   <v-card-title class="lime darken-1">System information</v-card-title>
   <v-card-text>keys?</v-card-text>
   <v-card-actions>
   <v-spacer></v-spacer>
   <v-btn @click="wipe" error>Wipe</v-btn></v-card-actions>
   </v-card>
 </v-container>
</template>

<script>{
  data:function(){return {
    keys: [],
    showDev: false
  }
  },
  methods:{
    wipe(){
      alert("wipe")
    }
  },
  created:function(){
    console.log("settings")
    settings.length()
    .then(k=>{
      console.log("length:",k)
      this.keys=k;
      })
  }
}
</script>
