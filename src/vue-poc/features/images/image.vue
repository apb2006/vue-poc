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
		 </v-flex>
		 
		 <v-flex xs7 >
		 <iframe :src="path" style="border:0;width:100%;height:100%;min-height:400px;">image</iframe>
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
    return this.loaded?'/vue-poc/api/images/list/'+ this.id+ '/image':null
    }
},
  created:function(){
   var id=this._props.id
   HTTP.get("images/list/"+id)
   .then(r=>{
     this.image=r.data
     this.loaded=true
     })
  }
    }
</script>
