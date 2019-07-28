<!DOCTYPE html>
<!-- 
 Show tab editor for tab list. 
   props
    'edittabs' object
     'current' integer current index 0  based
 -->
<template id="qd-tablist">
  <v-menu left bottom  :close-on-content-click="false" >
  <template v-slot:activator="{ on }">
    <v-chip  v-on="on"> 
    {{ edittabs.length }}
      <v-icon right>arrow_drop_down</v-icon>
    </v-chip>
   </template>
      
   <v-card>
    <v-toolbar   >
      <v-text-field
            prepend-icon="filter_list" 
            label="type filter text"
            single-line
            hide-details
            v-model="q"
            clearable
          ></v-text-field>  

  </v-toolbar>
	<v-card-text>
	  <v-list  style="height: 300px; overflow-y: auto;"> 
	        <v-list-item
	          v-for="index in edittabs.sorted(q)" :key="index"
	          avatar dense ripple
	          @click="setItem(index)" :inactive="index == current"
	        >
	          <v-list-item-avatar :title="edittabs.items[index].contentType">
	            <v-icon v-if="index == current">check_circle</v-icon>
	            <v-icon v-else>insert_drive_file</v-icon>
	          </v-list-item-avatar>
	
	          <v-list-item-content  :title="edittabs.items[index].url">
	            <v-list-item-title>{{ edittabs.items[index].name }}</v-list-item-title>
	          </v-list-item-content>
	
	          <v-list-item-action  >
	            {{ edittabs.items[index].id }} [{{ index }}]
	          </v-list-item-action>
	        </v-list-item>
	  </v-list>
  </v-card-text>
  <v-card-actions>
  current : {{ current }}
  </v-card-actions>
</v-card>
</v-menu>
</template>

<script>{
  props: ['edittabs',
          'current'
    ],
    
  data () {
    return {
      q:null
    }
  },
  
  methods: {
    setItem(index){     
       this.$emit('selected', index)
    }, 
  } 
}</script>
