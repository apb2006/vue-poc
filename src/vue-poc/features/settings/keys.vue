<!DOCTYPE html>
<template id="keys">
 <v-container fluid>
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
	 <v-card>
	   <v-card-title class="lime darken-1">keys</v-card-title>

   <v-card-text>keys
   <ul >
  <li v-for="key in keys">
    {{ key }}
  </li>
</ul>
   </v-card-text>
     <v-card-actions>
   <v-spacer></v-spacer>
   <v-btn @click="wipe" color="error">Wipe</v-btn></v-card-actions>
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
