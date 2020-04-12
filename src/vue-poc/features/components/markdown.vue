<!DOCTYPE html>
<!-- 
https://github.com/miaolz123/vue-markdown
 -->
<template id="markdown">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
	 <v-card-title >Markdown</v-card-title>
	<v-btn-toggle v-model="toc">
          <v-btn>
            TOC
          </v-btn>
      </v-btn-toggle>
	   <v-checkbox  v-model="toc" label="toc" ></v-checkbox>
	 <v-spacer></v-spacer>
	    <qd-link href="https://github.com/miaolz123/vue-markdown">vue-markdown@2.2.4</qd-link>
	      <v-menu :close-on-content-click="false" offset-y left>
               <template v-slot:activator="{ on }">
                  <v-btn icon v-on="on"><v-icon>settings</v-icon></v-btn>
               </template>
              <v-card >
                    <v-toolbar class="lime darken-1">
				          <v-card-title >Markdown Settings</v-card-title>
				          </v-toolbar>
				        <v-card-text>
				        <ul>
					 <li><v-checkbox  v-model="html" label="html" ></v-checkbox></li>
					 <li><v-checkbox  v-model="breaks" label="breaks" ></v-checkbox></li>
					  <li><v-checkbox  v-model="linkify" label="linkify" ></v-checkbox></li>
					  <li><v-checkbox  v-model="emoji" label="emoji" ></v-checkbox></li>
					  <li> <v-checkbox  v-model="typographer" label="typographer" ></v-checkbox></li>
					   </ul>
				        </v-card-text>
	        </v-card>
	      </v-menu>
	 </v-toolbar>
	 <v-card-text>
	  <v-row no-gutters style="flex-wrap: nowrap;">
      <v-col v-if="toc" cols="3" class="flex-grow-0 flex-shrink-0" >
        <v-card
          class="pa-2"
          outlined
          tile
        >
          <div v-html="tochtml"></div>
        </v-card>
      </v-col>
       <v-col cols="1" style="min-width: 100px; max-width: 100%;" 
       class="flex-grow-1 flex-shrink-0" color="orange lighten-2">
       <vue-markdown :watches="['show','html','breaks','linkify','emoji','typographer','toc']"
          :source="source" :show="show" :html="html" :breaks="breaks" :linkify="linkify"
          :emoji="emoji" :typographer="typographer" :toc="toc" v-on:rendered="allRight"
          v-on:toc-rendered="tocAllRight" toc-id="toc"> 
 </vue-markdown>
       </v-col>
      </v-row>
           

	 </v-card-text>
 </v-card>
  
 </v-container>
</template>

<script>{
	data(){
	    return { 
	        source: "",
	        show: true,
	        html: false,
	        breaks: true,
	        linkify: false,
	        emoji: true,
	        typographer: true,
	        toc: false,
	        tochtml: null
	      }
	    },
	      methods: {
	          allRight: function (htmlStr) {
	            console.log("markdown is parsed !");
	          },
	          tocAllRight: function (tocHtmlStr) {
	        	  this.tochtml=tocHtmlStr
	            console.log("toc is parsed :");
	          }
	        },    
	created:function(){	

		    HTTP.get("components/markdown")
		    .then(r=>{      
		          //console.log("data::::",r.data);
		          this.source=r.data;
		          })
		    .catch(err=> {
		            console.log(err);
		            alert("Get query error")
		          });
		    
		    console.log("loaded markdown:");
		    } 
}</script>
