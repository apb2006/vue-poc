<!DOCTYPE html>
<template id="search">
 <v-container fluid>
 <v-text-field  label="Search..." v-model="q"></v-text-field>
 <v-alert warning value="true">TODO</v-alert>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      q: this.$route.query.q,
      results: []
      }
  },
  created:function(){
    console.log("Serch",this.$route.query.q)
  }
}
</script>
