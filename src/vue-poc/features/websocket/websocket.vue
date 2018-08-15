<!DOCTYPE html>
<template id="websocket">
 <v-container fluid>
 <v-card>
 <v-toolbar >
 <v-toolbar-title>Web socket <a href="https://github.com/nathantsoi/vue-native-websocket">Git</a></v-toolbar-title>
 <v-spacer></v-spacer>
 <v-btn @click="send">Sent</v-btn>
 </v-toolbar>
 <v-card-text>
     <p>web socket</p>
  </v-card-text>
    </v-card>
    
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      reply: null
      }
  },
  methods:{
   
    
    send(){
      this.$socket.send('some data');
    }
  },
  mounted: function(){
   //this.$connect();
   this.$options.sockets.onmessage = (data) => this.reply=data;
   }
  
}</script>
