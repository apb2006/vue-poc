<!DOCTYPE html>
<template id="about">
  
    <v-container >
    <v-card hover raised> 
    <v-toolbar>
<v-card-title >the VUE-POC </v-card-title>
 <span v-if="pack"> {{ pack.version }}</span>
<v-spacer></v-spacer>

 </v-toolbar>

 <v-card-text>
      <v-layout align-center>
        <v-flex color="grey lighten-2">
          <span class="subheading">A development environment for managing XML sources and processes.</span>
      
          <v-divider class="my-3"></v-divider>
       
          <div class="title mb-3">Links</div>
              
      <v-list dense  nav>     
         <v-list-item  v-for="(item, i) in links"
          :key="i" :to="item.to" link >
         <v-list-item-icon>
            <v-icon v-text="item.icon"></v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title v-text="item.text" >fill</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        
      </v-list>
      
           <v-layout row wrap>
          <v-flex xs6>
          <v-list dense >
		 	  <v-list-item> <a href="/vue-poc/api?scope=/vue-poc" target="new">WADL (xml)</a></v-list-item>
		 	  <v-list-item> <a href="/vue-poc/api?scope=/vue-poc&amp;format=html" target="new">WADL (html)</a></v-list-item>
		 	  <v-list-item> <a href="/static/Swadl/wadl.html" target="new">WADL (html static)</a></v-list-item>     
	          <v-list-item> <a href="https://vuejs.org/" target="new">vue.js</a></v-list-item>
              
			<v-list-item><a href="https://vuetifyjs.com/vuetify/quick-start"
					    target="new">vuetifyjs</a></v-list-item>
					    
			<v-list-item><a href="https://github.com/axios/axios" target="new">axios</a></v-list-item>
					
			<v-list-item><a href="https://github.com/beautify-web/js-beautify"
					    target="new">js-beautify</a></v-list-item>
					    
			<v-list-item><a href="https://developers.google.com/web/tools/workbox/"
              target="new">workbox</a></v-list-item>
              
              <v-list-item><a href="https://material.io/tools/icons/?style=baseline"
              target="new">icons (material)</a></v-list-item>
              <v-list-item><a href="../api"
              target="new">wadl</a></v-list-item>    
			 </v-list>
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
     
	<v-speed-dial :bottom="true" :right="true">
      <template v-slot:activator>
        <v-btn
          v-model="fab"
          color="blue darken-2"
          dark
          fab
        >
          <v-icon v-if="fab">mdi-close</v-icon>
          <v-icon v-else>mdi-account-circle</v-icon>
        </v-btn>
      </template>
      <v-btn
        fab
        dark
        small
        color="green"
      >
        <v-icon>mdi-pencil</v-icon>
      </v-btn>
      <v-btn
        fab
        dark
        small
        color="indigo"
      >
        <v-icon>mdi-plus</v-icon>
      </v-btn>
      <v-btn
        fab
        dark
        small
        color="red"
      >
        <v-icon>mdi-delete</v-icon>
      </v-btn>
    </v-speed-dial>
	 </v-layout>  		
 </v-card-text>
 </v-card>
    </v-container>
      
	</template>
<script>{
  data:  function(){
    return { 
      pack: null,
      fab: false,
      links:[
    	  {text:"3rd party components (package.json)",icon:"mdi-clock",to:"about/package"},
    	  {text:"components",icon:"mdi-flag",to:"about/vue-cmps"},
    	  {text:"routes",icon:"mdi-plus",to:"about/routes"},
    	  {text:"routes2",icon:"mdi-plus",to:"about/routes2"}
      ]
  }
  },
  methods:{
	  refresh(){
	      HTTP.get("package.json")
	      .then(r=>{
	        console.log("status",r)
	        this.pack=r.data
	        //this.$forceUpdate()
	      })  
	    },
  },
  created(){
	  this.refresh()
  }
}</script>
