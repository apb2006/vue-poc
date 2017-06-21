<!DOCTYPE html>
<template id="people">
 <v-container fluid>
  <v-layout >Look at all the people who work here!
  <v-btn light default v-on:click.native="reverseMessage">Reverse Message</v-btn>
  <p>{{ message }}</p>
 
  </v-layout>
  <v-layout>
  <v-flex xs5>
   <v-card-row img="resources/music.jpg" height="300px"></v-card-row>
  </v-flex>
  <v-flex xs1>
  <v-card-row img="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" height="60px"></v-card-row>
  </v-flex>
  </v-layout>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      img:"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
      }
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
}

</script>
