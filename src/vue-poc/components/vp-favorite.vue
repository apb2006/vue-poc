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
      <v-btn slot="activator" @click.stop="set(!frmfav)" icon flat title="Bookmark this page">
       <v-icon>star_border</v-icon>
       </v-btn>
       <v-card style="width:400px;">
            <v-toolbar class="green"> 
        <v-card-title>
            Bookmark this page
          </v-card-title>
          </v-toolbar>
          
         <v-card-text>
            <h6>{{$route.meta.title}}</h6>
            <v-combobox multiple
              v-model="tags"
              label="tags"
              chips
              tags
              :items="taglist"
            ></v-combobox>
         </v-card-text>
         
         <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" flat @click.stop="set(false)">Cancel</v-btn>
            <v-btn color="primary" flat @click.stop="favorite(); set(false)">Save</v-btn>
          </v-card-actions>
        </v-card>
   </v-menu></template>
<script>{ 
  props: { 
    frmfav: Boolean
  },
  data(){
    return {
      tags: [],
      taglist: [
        'todo',
        'find',
        'some',
        'good',
        'tags'
      ],
    }
  },
  methods:{
    set(v){
      this.$emit('update:frmfav', v)
    },
    
    favorite(){
      alert("save");
    }
  }
}</script>
