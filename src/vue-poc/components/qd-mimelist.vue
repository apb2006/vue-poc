<!DOCTYPE html>
<!-- 
 mimetype UI 
 An item can be selected emits selected event with  {name:.., mode: ...}
 -->
<template id="qd-mimelist">
  <v-menu v-model="show" left bottom  :close-on-content-click="false" >
    <v-chip  slot="activator">
    
    {{ mimetype }}
    <v-avatar>
      <v-icon right>arrow_drop_down</v-icon>
      </v-avatar>
    </v-chip>
   <v-card>
    <v-toolbar   >
      <v-text-field
            prepend-icon="filter_list" 
            label="type filter for mimetypes"
            single-line
            hide-details
            v-model="q"
            clearable
          ></v-text-field>  

  </v-toolbar>
	<v-card-text>
	  <v-list  style="height: 300px; overflow-y: auto;"> 
	  
	        <v-list-tile
	          v-for="(mime,index) in items" :key="index"
	            avatar dense ripple
            @click="setItem(mime,index)" 
	         
	        >
	          <v-list-tile-avatar>
	            <v-icon v-if="false">check_circle</v-icon>
	            <v-icon v-else>insert_drive_file</v-icon>
	          </v-list-tile-avatar>
	
	          <v-list-tile-content>
	            <v-list-tile-title>{{ mime.name }}</v-list-tile-title>
	          </v-list-tile-content>
	
	          <v-list-tile-action  >
	           {{ mime.mode }}
	          </v-list-tile-action>
	        </v-list-tile>
	     
	  </v-list>
  </v-card-text>
  <v-card-actions>
 
  </v-card-actions>
</v-card>
</v-menu>
</template>

<script>{
  props: {
    mimetype:{
       type:String, default:"(default)"
    }
  },
    
  data () {
    return {
      q: null,
      show: false
    }
  },
  
  methods:{
    setItem(mime,index){
      console.log("selected ",mime)
      this.$emit('selected', mime)
      this.show=false
    }
  },
  
  computed:{
  items(){
    return this.$MimeTypes.list().filter(item=>{return (!this.q) || item.name.toLowerCase().includes(this.q.toLowerCase())})
  }
  }, 
  
  created:function(){
    console.log("qd-mimelist",this.$MimeTypes.list())
  }
}</script>
