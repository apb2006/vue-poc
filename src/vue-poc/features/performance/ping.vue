<!DOCTYPE html>
<template id="ping">
 <v-container fluid>
 <v-card>
 <v-toolbar >
 <v-toolbar-title>Simple response counter</v-toolbar-title>
 <v-spacer></v-spacer>
 
 </v-toolbar>
 <v-card-text>
  <p>Read or increment a database value. This measures round trip times browser-database-browser.</p>
  <h3>Value: <v-chip color="amber" text-color="white">{{counter}}</v-chip></h3>
  <qd-perfstats :initial="initial">
  
  <div slot="actions" slot-scope="{ add , repeats, reset }">
    <v-btn  @click="repeats(false)">Repeat off</v-btn>
    <v-btn @click="reset()">Reset</v-btn>
  </div>
  
   <v-data-table slot="table"  slot-scope="{ headers, items, run }" :hide-default-footer="true"
      :headers="headers"  :items="items"    >
    <template v-slot:item.id="{ item }" > 
	      <v-btn @click="run(item.index)">{{ item.id }}</v-btn>
    </template>
    <template v-slot:item.repeat="{ item }" > 
	      <v-switch v-model="item.repeat"></v-switch>
    </template>
  </v-data-table>
  
  </qd-perfstats>
    </v-card-text>
    </v-card>
    
 </v-container>
</template>

<script>
export default {
	data:  function(){
	    return {
	    	initial:[
	    		     { id: 'WRITE DB', method: 'POST', url: 'performance/ping'},
			         { id: 'READ DB', method: 'GET', url: 'performance/ping'},
			         { id: 'NO DB', method: 'GET', url: 'performance/nodb'} 
			         ],
	    	counter: 0}
	},
  beforeRouteLeave(to, from, next){
    var on=false // @TODO this.repeat.get || this.repeat.post

    if (on) {
      alert("running!") //<--undefined
      return next(false)
    } else {
      return next()
    }
  }
}
</script>
