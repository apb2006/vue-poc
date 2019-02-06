<!DOCTYPE html>
<template id="keys">
 <v-container fluid>
 
	 <v-card>
	  <v-toolbar dense>
	   <v-toolbar-title> 
         <qd-breadcrumbs 
         :crumbs="[{to: '/settings', text:'Settings'}, {text: 'Keys', disabled: true }]"
         >crumbs</qd-breadcrumbs> 
         </v-toolbar-title> 
         <v-btn @click="showKey" :disabled="openIndex === null">Show: {{ keys[openIndex] }} </v-btn>
           <v-btn @click="deleteKey" :disabled="openIndex === null">Delete</v-btn> 
	   <v-spacer></v-spacer>
   <v-btn @click="wipe" color="error">Delete ALL</v-btn>
	   </v-toolbar>

   <v-card-text>
    <v-expansion-panel v-model="openIndex">
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
   <v-snackbar :value="true" >Settings are currently only stored locally in the browser, using <code>localstorage</code></v-snackbar>
 </v-container>
</template>

<script>{
  data(){return {
    keys: ["?"],
    openIndex: null
  }
  },
  methods:{
    wipe(){
       if(confirm("wipe localstorage? ")) Settings.clear();
    },
    
    showKey(){
      var key=this.keys[this.openIndex]
      console.log("index: ",key)
      Settings.getItem(key).then(v=>{console.log("ffff",v)})
      alert("show")
    },
    
    deleteKey(){
      var key=this.keys[this.openIndex]
      console.log("index: ",key)
      Settings.removeItem(key).then(v=>{console.log("ffff",v)})
      alert("show")
    }
  },
  
  created(){
    console.log("settings")
    Settings.keys()
    .then( v =>{
      console.log("keys: ",v)
     this.keys=v
    })
     
  }
}
</script>
