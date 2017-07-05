<!DOCTYPE html>
<template id="people">
 <v-container fluid>
  <v-layout >Look at all the people who work here!
  <v-btn light default v-on:click.native="reverseMessage">Reverse Message</v-btn>
  <p>{{ message }}</p>
   <v-btn light default v-on:click.native="logout">logout</v-btn>
  </v-layout>
  <v-card>
  <v-layout >
  <v-flex  xs5>created:{{$auth.created}}</v-flex>
   <v-flex  xs5>session:{{$auth.session}}</v-flex>
  </v-layout>
  </v-card>
  <v-layout>
  <v-flex xs5>
   <v-card-media src="resources/music.jpg" height="300px"></v-card-media>
  </v-flex>
  <v-flex xs1>
  <v-card-media :src="img" height="60px"></v-card-media>
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
    reverseMessage() {
      this.message = this.message.split('').reverse().join('')
    },
    logout(){
      alert("TODU")
    }
  }
}

</script>
