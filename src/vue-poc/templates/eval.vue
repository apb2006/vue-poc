<!DOCTYPE html>
<template id="eval">
 <v-container fluid>
  <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px" >
  <vue-ace editor-id="editorA" :content="xq" mode="xquery" wrap="true"
    v-on:change-content="onChange" 
    ></vue-ace>
    </v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      xq: '(:~ do something :)'
      }
  },
  methods:{
    onChange(){
      console.log("go")
    }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}
</script>
