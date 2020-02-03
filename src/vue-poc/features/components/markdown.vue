<!DOCTYPE html>
<!-- 
https://github.com/miaolz123/vue-markdown
 -->
<template id="markdown">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
	 <v-card-title >Markdown</v-card-title>
	 <v-checkbox  v-model="show" label="show" ></v-checkbox>
	 <v-checkbox  v-model="html" label="html" ></v-checkbox>
	 <v-checkbox  v-model="breaks" label="breaks" ></v-checkbox>
	  <v-checkbox  v-model="linkify" label="linkify" ></v-checkbox>
	  <v-checkbox  v-model="emoji" label="emoji" ></v-checkbox>
	   <v-checkbox  v-model="typographer" label="typographer" ></v-checkbox>
	   <v-checkbox  v-model="toc" label="toc" ></v-checkbox>
	 <v-spacer></v-spacer>
	    <qd-link href="https://github.com/miaolz123/vue-markdown">vue-markdown@2.2.4</qd-link>
	 </v-toolbar>
	 <v-card-text>
	       <div id="toc"></div>
<vue-markdown :watches="['show','html','breaks','linkify','emoji','typographer','toc']"
          :source="source" :show="show" :html="html" :breaks="breaks" :linkify="linkify"
          :emoji="emoji" :typographer="typographer" :toc="toc" v-on:rendered="allRight"
          v-on:toc-rendered="tocAllRight" toc-id="toc">># h1 Heading 8-)
## level 2
### h3 Heading

## Horizontal Rules

___

---

***

## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-
</vue-markdown>
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
	        toc: false
	      }
	    },
	      methods: {
	          allRight: function (htmlStr) {
	            console.log("markdown is parsed !");
	          },
	          tocAllRight: function (tocHtmlStr) {
	            console.log("toc is parsed :", tocHtmlStr);
	          }
	        },    
	created:function(){	

		    HTTP.get("components/markdown")
		    .then(r=>{      
		          console.log("data::::",r.data);
		          this.source=r.data;
		          })
		    .catch(err=> {
		            console.log(err);
		            alert("Get query error")
		          });
		    
		    console.log("loaded markdown:");
		    } 
}</script>
