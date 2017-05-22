<!DOCTYPE html>
<template id="people">
 <v-container fluid>
  <v-row >Look at all the people who work here!
  <v-btn light default v-on:click.native="reverseMessage">Reverse Message</v-btn>
  <p>{{ message }}</p>
 
  </v-row>
  <v-row>
  <v-col xs5>
   <v-card-row img="music.jpg" height="300px"></v-card-row>
  </v-col>
  <v-col xs5>
  <v-card-row img="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" height="300px"></v-card-row>
  </v-col>
  </v-row>
 </v-container>
</template>

<script>{
  template: '#people',
  data:  function(){
    return {message: 'Hello Vue.js!'}
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
}

</script>
