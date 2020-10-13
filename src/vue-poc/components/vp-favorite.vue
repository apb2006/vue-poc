<!DOCTYPE html>
<!-- 
display button that invokes a  save favorite form
 -->
<template id="vp-favorite">
  <v-menu :close-on-click="false"
      offset-x
      :close-on-content-click="false"
      :nudge-width="200"
      v-model="frmfav"
    >
    <template v-slot:activator="{ on }">
       <v-btn v-on="on" text @click.stop="set(!frmfav)" icon  title="Bookmark this page">
          <v-icon>{{ icon  }}</v-icon>
       </v-btn>
     </template>
       <v-card style="width:400px;">
            <v-toolbar class="green"> 
        <v-card-title>
            Add to bookmarks
          </v-card-title>
          <v-spacer></v-spacer>
          <v-btn  @click="set(false)" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          
         <v-card-text>
            <h6 :title="this.$route.fullPath">{{$route.meta.title}}  
              <v-btn v-if="canCopy" @click="setclip" icon title="Copy location"><v-icon>content_copy</v-icon></v-btn>
            </h6>
            <v-combobox multiple
              v-model="tags"
              label="tags"
              chips
              tags
              :items="taglist"
            ></v-combobox>
         </v-card-text>
         
         <v-card-actions class="text-center">
            <v-btn  color="primary" text @click.stop="favorite(); set(false)"  >Done</v-btn>
            <v-spacer></v-spacer>           
            <v-btn  text @click.stop="set(false)"  >Cancel</v-btn>         
          </v-card-actions>
        </v-card>
   </v-menu></template>
<script>{ 
  props: { 
    frmfav: Boolean
  },
  data(){
    return {
     canCopy:false,	
      tags: [],
      taglist: [  'todo',  'find',  'some',  'good',  'tags' ],
      exists: false
    }
  },
  methods:{
    set(v){
      this.$emit('update:frmfav', v)
    },
    async setclip(){
    	      await navigator.clipboard.writeText(this.$route.fullPath);
    },
    favorite(){
      this.$store.commit('increment')
      console.log(this.$store.state.count)
       this.exists= !this.exists
      alert("save");
    }
  },
  computed:{
	 icon: function(){return this.exists?"star":"star_border" } 
  },
  created() {
    this.canCopy = !!navigator.clipboard;
  },
}</script>
