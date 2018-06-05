<!DOCTYPE html>
<template id="scratch">
 <v-container fluid>
 <qd-autoheight>
  <vue-ace  :content="ace" mode="xml"   ></vue-ace>
 </qd-autoheight>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'bad route!',
      ace:"<xml>here</xml>"
      }
  },
 mounted:function(){
    console.log("notfound",this.$route.path)
  }
}
</script>
