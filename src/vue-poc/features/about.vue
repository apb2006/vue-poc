<!DOCTYPE html>
<template id="about">

  <v-jumbotron color="grey lighten-2">
      
    <v-container fill-height>
      <v-layout align-center>
        <v-flex>
          <h3 class="display-3">Vue-poc<v-spacer></v-spacer>
             <v-speed-dial  v-model="fab"  hover right direction="bottom" 
             transition="slide-y-reverse-transition">
      <v-btn  slot="activator" class="blue darken-2"  dark  fab  hover  v-model="fab">
        <v-icon>account_circle</v-icon>
        <v-icon>close</v-icon>
      </v-btn>
      <v-btn   fab  dark  small    class="green"    >
        <v-icon>edit</v-icon>
      </v-btn>
      <v-btn fab dark small class="indigo" >
        <v-icon>add</v-icon>
      </v-btn>
      <v-btn fab dark small class="red" >
        <v-icon>delete</v-icon>
      </v-btn>
    </v-speed-dial>
          </h3>
          <span class="subheading">A development environment for managing XML sources and processes.</span>
      
          <v-divider class="my-3"></v-divider>
       
          <div class="title mb-3">Links</div>
           <v-layout row wrap>
          <v-flex xs6>
	        <ul>
	         <li><a href="https://vuejs.org/"
              target="new">vue.js</a></li>
					  <li><a href="https://vuetifyjs.com/vuetify/quick-start"
					    target="new">vuetifyjs</a></li>
					
					  <li><a href="https://github.com/beautify-web/js-beautify"
					    target="new">js-beautify</a></li>
					    <li><a href="https://developers.google.com/web/tools/workbox/"
              target="new">workbox</a></li> 
					 </ul>
					 </v-flex>
					 <v-flex xs6>
					 <ul>
					  <li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
					  <li><a href="/dba" target="new">DBA app</a></li>
					   <li> <router-link to="database?url=%2Fvue-poc%2F">DB</router-link></li>
					</ul>
					</v-flex>
					</v-layout>
        </v-flex>
      </v-layout>
 
    </v-container>
    </v-jumbotron>
      
	</template>
<script>{
  data:  function(){
    return { 
      fab: false
  }
  }
}</script>
