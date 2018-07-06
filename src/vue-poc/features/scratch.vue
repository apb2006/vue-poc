<!DOCTYPE html>
<template id="scratch">
 <v-container fluid>
 <qd-fileupload title="Up it" selected-callback="upit">up load</qd-fileupload>
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
  methods:{
    upit:function(s){
      alert("up")
    }
  },
 mounted:function(){
    console.log("scratch",this.$route.path)
  }
}
</script>
