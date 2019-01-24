<!DOCTYPE html>
<!-- 
 Show tab editor for tab list. 
 -->
<template id="qd-tablist">
  <v-menu left bottom  :close-on-content-click="false" >
    <v-chip  slot="activator">
    
    {{ edittabs.length }}
    <v-avatar>
      <v-icon right>arrow_drop_down</v-icon>
      </v-avatar>
    </v-chip>
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
	        <v-list-tile
	          v-for="index in edittabs.sorted(q)" :key="index"
	          avatar dense ripple
	          @click="setItem(index)" :inactive="index == current"
	        >
	          <v-list-tile-avatar>
	            <v-icon v-if="index == current">check_circle</v-icon>
	            <v-icon v-else>insert_drive_file</v-icon>
	          </v-list-tile-avatar>
	
	          <v-list-tile-content>
	            <v-list-tile-title>{{ edittabs.items[index].name }}</v-list-tile-title>
	          </v-list-tile-content>
	
	          <v-list-tile-action  >
	            {{ edittabs.items[index].id }} [{{ index }}]
	          </v-list-tile-action>
	        </v-list-tile>
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
