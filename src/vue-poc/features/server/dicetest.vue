<!DOCTYPE html>
<template id="dicetest">
 <v-container fluid>
 <v-card>
 <v-toolbar >
 <v-toolbar-title>Dice entity list</v-toolbar-title>
 
 <v-spacer></v-spacer>
 <v-btn @click="reset()">Reset</v-btn>
 </v-toolbar>
 <v-card-text>
  <p>Read json data for 1st page for entity.</p>
   <v-flex xs12 sm6>
     <v-combobox
          v-model="url"
          :items="urls"
          label="Select target"
        ></v-combobox>
      
    </v-flex>
 
  <table class="v-table">
      <thead> 
        <tr>
         <th xs1>Action</th>
          <th xs1>Repeat</th>
          <th xs1>Last</th>
          <th xs1>Count</th>
          <th xs1>Avg</th>
          <th xs1>min</th>
          <th xs1>max</th>
          <th xs1>Median</th>
        </tr>
      </thead>
      <tbody>

      
          <tr>
              <td>
               <v-btn @click="get()"  >
                   Read <v-icon right>compare_arrows</v-icon> 
                </v-btn>
             
               </td>
               <td>
                <v-switch v-on:change="gchange" v-model="repeat.get"></v-switch>

             </td>    
              <td>
                  <span >{{getValues.last}}</span>
              </td>
              <td>
                  <span >{{getValues.count}}</span>
              </td>   
            
              <td>
                  <span >{{getValues.avg | round(2)}}</span>
              </td>
            
              <td>
                  <span >{{getValues.min}}</span>
              </td>
              <td>
                  <span >{{getValues.max}}</span>
              </td>
                <td>
                  <span >{{getValues.median}}</span>
              </td>
          </tr>
          
          
      </tbody>
    </table>
     <h3>Value: <v-chip color="amber" text-color="white">{{counter}}</v-chip></h3>
     <pre>{{ result | pretty}}</pre>
    </v-card-text>
    </v-card>
    
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      getValues: new perfStat(),
      repeat: {get:false},
      url: "data/entity",
      urls: ["data/entity","data/taskhistory"],
      counter: 0,
      result: null
      }
  },
  methods:{

    get(){
     var _start = performance.now();
     HTTP.get(this.url,axios_json)
     .then(r=>{
       var elapsed=Math.floor(performance.now() - _start);
       this.counter++;
       this.result=r.data;
       Object.assign(this.getValues,this.getValues.log(elapsed))
       this.$forceUpdate()
        if(this.repeat.get){
          this.get(); //does this leak??
        }
     })
    },
    gchange(v){
      if(v)this.get() 
    },
    
    reset(){
      Object.assign(this.getValues,this.getValues.clear());
      this.$forceUpdate()
    }
  },
  beforeRouteLeave(to, from, next){
    var on=this.repeat.get 

    if (on) {
      alert("running!") //<--undefined
      return next(false)
    } else {
      return next()
    }
  }
}
</script>
