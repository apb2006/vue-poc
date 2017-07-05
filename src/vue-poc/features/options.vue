<!DOCTYPE html>
<template id="options">
<v-layout >
<v-flex xs2>
<v-card class="blue darken-4 white--text">
    <v-card-title height="200px">
      Featured Event: <br>
      May 24, 2016 <br>
      7-11pm
    </v-card-title>
 <v-card-actions>
    <v-btn flat class="white--text" @click.native="snackbar = true" >Add to <br>Calendar</v-btn>
    <v-spacer></v-spacer>
    <v-btn icon dark @click.native="snackbar = true" >
      <v-icon>event</v-icon>
    </v-btn>
  </v-card-actions>
</v-card>
</v-flex>

<v-flex xs6>
       <v-text-field
            name="url"
            label="Image location" :required=true :full-width=false
       ></v-text-field>
</v-flex>

<v-flex xs4>
   <v-card-media img="music.jpg" height="300px"></v-card-media>
  <v-btn block primary @click.native="snackbar = true" dark>Show Snackbar</v-btn>
 <v-btn class="white--text"  @click.native="snackbar = true">Snackbar?</v-btn>
</v-flex>
<v-snackbar   v-model="snackbar">
    Hello, I'm a snackbar
    <v-btn flat class="pink--text" @click.native="snackbar = false">
         <v-icon>highlight_off</v-icon>
    </v-btn>
  </v-snackbar>
  </v-layout>
</template>

<script>{  
  data: function(){
    return {
        snackbar:false
    }
  }
    }
</script>
