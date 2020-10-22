<!DOCTYPE html>
<template id="dicetest">
 <v-container fluid>
 <v-card>

 <v-toolbar >
 <v-toolbar-title>Read json data for 1st page for entity</v-toolbar-title>
 
 <v-spacer></v-spacer>
 
 </v-toolbar>
 <v-card-text>
 <qd-perfstats>  
  <v-app-bar  slot="actions" slot-scope="{ add , repeats, reset, clip  }">
   <v-select v-model="selectedEntities" :items="entities"  item-text="name" 
       return-object label="Entities to test"
      multiple chips>
    <template v-slot:prepend-item>
        <v-list-item  ripple @click="toggle" class="green lighten">
          <v-list-item-action>
            <v-icon :color="selectedEntities.length > 0 ? 'indigo darken-4' : ''">{{ icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>Select All</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-divider class="mt-2"></v-divider>
      </template>
     </v-select>
   <div v-if="selectedEntities.length">
    <v-btn  @click="setSel(add)">Set</v-btn>   
    <v-btn  @click="repeats(false)">Repeat off</v-btn>
    <v-btn  @click="repeats(true)">Repeat on</v-btn>
    <v-btn @click="reset()">Reset</v-btn>
    <v-btn @click="clip()" icon title="copy to clipboard"><v-icon>content_copy</v-icon></v-btn>
    </div>
  </v-app-bar>
  
   <v-data-table slot="table"  slot-scope="{ headers, items, run }" :hide-default-footer="true" :disable-pagination="true"
      :headers="headers"  :items="items"   dense >
    <template v-slot:item.id="{ item }" > 
	      <v-btn @click="run(item.index)" :title="item.index">{{ item.id }}</v-btn>
    </template>
    <template v-slot:item.repeat="{ item }" > 
	      <v-simple-checkbox v-model="item.repeat"></v-simple-checkbox>
    </template>
  </v-data-table>
  
  <div  slot="response" slot-scope="{ data }">
     <h3>Counter: <v-chip color="amber" text-color="white">counter</v-chip></h3>
     <pre>{{ data | pretty}}</pre>
  </div>
  </qd-perfstats>
 
  
    </v-card-text>
      
    </v-card>
    
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      selectedEntities: [],
      counter: 0,
      entities: [],
      result: null
      
      }
  },
  methods:{ 
    getentities(){
      HTTP.get("data/entity",axios_json)
      .then(r=>{
        //console.log("entities: ",r.data);
        this.entities=r.data.items
      })
    },
    setSel(add){
    	console.log("setSel",this.selectedEntities)
    	this.selectedEntities.forEach(item=>add(item.name,'GET',item.datalink))
    },
    toggle () {
        this.$nextTick(() => {
          if (this.all) {
            this.selectedEntities = []
          } else {
            this.selectedEntities = this.entities.slice()
          }
        })
      }
  },
  
  computed:{
		  all () {
		      return this.selectedEntities.length === this.entities.length
		    },
		  some () {
		      return this.selectedEntities.length > 0 && !this.all
		    },
		  icon () {
		      if (this.all) return 'mdi-close-box'
		      if (this.some) return 'mdi-minus-box'
		      return 'mdi-checkbox-blank-outline'
		    }
  },
  
  created(){
    console.log("GET entities: ");
    this.getentities()
  },
  
  beforeRouteLeave(to, from, next){
    var on=this.some // @TODO this.repeat.get 

    if (on) {
      alert("running!") //<--undefined
      return next()
    } else {
      return next()
    }
  }
}
</script>
