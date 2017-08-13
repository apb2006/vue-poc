<!DOCTYPE html>
<!-- 
 image  ui
 
 -->
<template id="image">
 <v-container fluid>
 Image: {{ id }}
 doc <pre>{{ image && image.doc }}</pre>
 </v-container>
</template>

<script>{  
  props:["id"],
  data: ()=>( {
    image:null
  }),
  created:function(){
   var id=this._props.id
   HTTP.get("images/list/"+id)
   .then(r=>{
     console.log(r.data)
     this.image=r.data
     })
  }
    }
</script>
