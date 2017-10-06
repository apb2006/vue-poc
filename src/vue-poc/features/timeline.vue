<!DOCTYPE html>
<template id="timeline">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
	 <v-card-title >Line 1</v-card-title>
	 <v-spacer></v-spacer>
	 <v-btn @click="fit">fit</v-btn>
	 </v-toolbar>
	 <v-card-text>
	   <vis-time-line :items="vueState.data1" :events="Events" 
	                  :options="{editable: true, clickToUse: false" @select="select"></vis-time-line>
	 </v-card-text>
 </v-card>
 
 <v-card>
 <v-card-text>
 {{msg}}
 </v-card-text>
</v-card>
 </v-container>
</template>

<script>{
  data(){
    return {
      vueState: {
      data1: [
        { id: 1, content: 'item 1', start: '2013-04-20 23:06:15.304' },
	      { id: 2, content: 'iso date time', start: '2013-04-14T11:11:15.304' },
	      { id: 3, content: '[GET] http://localhost:8984/vue-poc/ui/icon.png', start: '2013-04-18', end: '2013-04-19' },
	      { id: 4, content: 'item 4', start: '2013-04-16', end: '2013-04-19', className: 'green' },
	      { id: 5, content: '[GET] http://localhost:8984/vue-poc/ui/app.css', start: '2013-04-25' },
	      { id: 6, content: 'item 6', start: '2013-04-27' }]
    },
    Events: new Vue({}),
    msg:"Item detail"
    }
},
methods:{
  fit(){
    this.Events.$emit('fit');
  },
  select(items){
    this.msg='Selected items: ' + items
  }
},
created(){
  console.log("timeline")
}
}</script>
