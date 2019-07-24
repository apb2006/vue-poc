<!DOCTYPE html>
<!-- 
 image  ui
 
 -->
<template id="image">
 <v-container fluid>
  <v-card >
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
     <v-chip > {{ image.name }}</v-chip>   
    </v-card-title>
     <span > {{ image.path }}</span>   
    <v-spacer></v-spacer> 
      <span class="white--text">Image: {{ id }}</span>      
    <a :href="path" :download="id +'.jpg'"><v-icon>file_download</v-icon></a>
    </v-toolbar>
    
    <v-card-text>
 <v-layout>
		 <v-flex xs5>
		<pre style="overflow:auto;">{{ image.doc }}</pre>
		  <a :href="meta" target="_new" >full metadata</a>
		 </v-flex>
		 
		 <v-flex xs7 >
		 
      <v-img v-if="loaded" src="/vue-poc/api/images/list/17236456/image" min-height="400px" height="100%" width="100%"/>
		 </v-flex>
 </v-layout>
 </v-card-text>
 </v-card>
 </v-container>
</template>

<script>{  
  props:["id"],
  data: ()=>( {
    image:{},
    loaded:false
  }),
  computed: {
    path(){
    	var a=this.loaded?'/vue-poc/api/images/list/'+ this.id+ '/image':null
    	console.log("path",a)
    return a
    },
    meta(){
      return this.loaded?'/vue-poc/api/images/list/'+ this.id+ '/meta':null
      }
},
  created:function(){
   var id=this.id
   
   HTTP.get("images/list/"+id)
   .then(r=>{
     this.image=r.data
     this.loaded=true

     })
  }
    }
</script>
