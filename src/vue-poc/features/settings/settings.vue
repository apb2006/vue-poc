<!DOCTYPE html>
<template id="settings">
 <v-container fluid>
	 <v-card>
	 <v-card-text>
	   <router-link to="/acesettings">Editor settings</router-link>
   </v-card-text>
   </v-card>
   <v-card>
   <v-card-title>System information</v-card-title>
   <v-card-text></v-card-text>
   <v-card-actions>
   <v-spacer></v-spacer>
   <v-btn @click="wipe" error>Wipe</v-btn></v-card-actions>
   </v-card>
 </v-container>
</template>

<script>{
  data:function(){return {
    keys:[]
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
