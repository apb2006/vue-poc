<!DOCTYPE html>
<template id="timeline">
 <v-container fluid>
 <v-card>
	 <v-card-title class="lime darken-1">Line 1</v-card-title>
	 <v-card-text>
	   <vis-time-line :items="vueState.data1"></vis-time-line>
	 </v-card-text>
 </v-card>
 
 <v-card>
   <v-card-title class="deep-orange">Line 2</v-card-title>
   <v-card-text>
<vis-time-line :items="vueState.data2"></vis-time-line>
</v-card-text>
</v-card>
 </v-container>
</template>

<script>{
  data(){
    return {
      vueState: {

      data1: [
        { id: 1, content: 'item 1', start: '2013-04-20' },
	      { id: 2, content: 'item 2', start: '2013-04-14' },
	      { id: 3, content: 'item 3', start: '2013-04-18' },
	      { id: 4, content: 'item 4', start: '2013-04-16', end: '2013-04-19' },
	      { id: 5, content: 'item 5', start: '2013-04-25' },
	      { id: 6, content: 'item 6', start: '2013-04-27' }],

      data2: [
        { id: 1, content: 'item 11', start: '2017-04-20' },
	      { id: 2, content: 'item 12', start: '2017-04-14' },
	      { id: 3, content: 'item 13', start: '2017-04-18' },
	      { id: 4, content: 'item 14', start: '2017-04-16', end: '2017-04-19' },
	      { id: 5, content: 'item 15', start: '2017-04-25' },
	      { id: 6, content: 'item 16', start: '2017-04-27' }]
    }
}
}
}</script>
