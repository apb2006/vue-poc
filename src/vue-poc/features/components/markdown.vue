<!DOCTYPE html>
<!-- 
https://github.com/miaolz123/vue-markdown
 -->
<template id="markdown">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
	 <v-card-title >Markdown</v-card-title>
	 <qd-link href="https://github.com/miaolz123/vue-markdown">vue-markdown@2.2.4</qd-link>
	 <v-spacer></v-spacer>
	   
	      <v-menu :close-on-content-click="false" offset-y left>
               <template v-slot:activator="{ on }">
                  <v-btn icon v-on="on"><v-icon>settings</v-icon></v-btn>
               </template>
              <v-card  >
                    <v-toolbar  class="lime darken-1">
				          <v-card-title >Markdown Settings</v-card-title>
				          </v-toolbar>
				        <v-card-text>
				         <v-list dense>
				           <v-list-item>
					         <v-list-item-action>					      
					           <v-checkbox v-model="show"  label="show" />
					          </v-list-item-action>				        
					      </v-list-item>
					       <v-list-item>
					         <v-list-item-action>					      
					           <v-checkbox v-model="toc"  label="toc" />
					          </v-list-item-action>				        
					      </v-list-item>
					        <v-list-item>
					         <v-list-item-action>					      
					           <v-checkbox v-model="html"  label="html" />
					          </v-list-item-action>				        
					      </v-list-item>
					      <v-list-item>
					         <v-list-item-action>					       
					           <v-checkbox v-model="breaks"  label="breaks" />
					          </v-list-item-action>					        
					      </v-list-item>
					      
					      <v-list-item>
					        <v-list-item-action>
					          <v-checkbox v-model="linkify"  label="linkify" />
					        </v-list-item-action>					        
					      </v-list-item>
					      
					      <v-list-item>
					        <v-list-item-action>
					          <v-checkbox  v-model="emoji" label="emoji" >
					        </v-list-item-action>					        
					      </v-list-item>
					      
					        <v-list-item>
					        <v-list-item-action>
					          <v-checkbox  v-model="typographer" label="typographer" ></v-checkbox>
					        </v-list-item-action>					        
					      </v-list-item>
					      
					    </v-list>
				       
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
          <div v-html="tochtml" style="position:fixed"></div>
        </v-card>
      </v-col>
       <v-col cols="1" style="min-width: 100px; max-width: 100%;" 
       class="flex-grow-1 flex-shrink-0" color="orange lighten-2">
       <vue-markdown :watches="['show','html','breaks','linkify','emoji','typographer','toc']"
          :source="markdown" :show="show" :html="html" :breaks="breaks" :linkify="linkify"
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
	    	url: "md-sample.md",
	        markdown: "",
	        show: true,
	        html: false,
	        breaks: true,
	        linkify: false,
	        emoji: true,
	        typographer: true,
	        toc: false,
	        tochtml: null,
	        opts: []
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
		          this.markdown=r.data;
		          })
		    .catch(err=> {
		            console.log(err);
		            alert("Get query error")
		          });
		    
		    console.log("loaded markdown:");
		    } 
}</script>
