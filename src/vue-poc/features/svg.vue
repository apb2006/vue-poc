<!DOCTYPE html>
<template id="svg">
 <v-container fluid>
<div id="canvasqPWKOg" class="canvas"></div>
<button id="resetButtonqPWKOg">Reset</button>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'bad route!'
      }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}
</script>
