<!DOCTYPE html>
<template id="about">

  <v-jumbotron color="grey lighten-2">
      
    <v-container fill-height>
      <v-layout align-center>
        <v-flex>
          <h3 class="display-3">Vue-poc</h3>
          <span class="subheading">A development environment for managing XML sources and processes.</span>
      
          <v-divider class="my-3"></v-divider>
       
          <div class="title mb-3">Links</div>
           <v-layout row wrap>
          <v-flex xs6>
	        <ul>
	         <li><a href="https://vuejs.org/" target="new">vue.js</a></li>
              
					  <li><a href="https://vuetifyjs.com/vuetify/quick-start"
					    target="new">vuetifyjs</a></li>
					    
					<li><a href="https://github.com/axios/axios" target="new">axios</a></li>
					
					  <li><a href="https://github.com/beautify-web/js-beautify"
					    target="new">js-beautify</a></li>
					    
					    <li><a href="https://developers.google.com/web/tools/workbox/"
              target="new">workbox</a></li>
              
              <li><a href="https://material.io/tools/icons/?style=baseline"
              target="new">icons (material)</a></li>    
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
