<!DOCTYPE html>
<template id="ping">
 <v-container fluid>
 <v-card>
 <v-toolbar light>
 <v-toolbar-title>Simple performance measure</v-toolbar-title>
 <v-spacer></v-spacer>
 <v-btn @click="reset()">Reset</v-btn>
 </v-toolbar>
 <v-card-text>
  <p>Read or increment a database value.</p>
  <p>Counter:{{counter}}</p>
  <table class="table">
      <thead> 
        <tr>
          <th>Option</th>
          <th >Repeat</th>
          <th >Last</th>
          <th >Count</th>
          <th >Avg</th>
          <th >min</th>
          <th >max</th>
          <th>Median</th>
        </tr>
      </thead>
      <tbody>

      
          <tr>
              <td>
                   <v-btn     @click="get()" >Get count</v-btn>
               </td>
               <td>
                <v-switch  v-model="repeat.get"></v-switch>

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
          
            <tr>
          <td>
             <v-btn    @click="update()" >Update count</v-btn>
          </td>
          
          <td>
           <v-switch  v-model="repeat.post"></v-switch>
          </td>
           <td class="col-md-1">
                        <span >{{postValues.last}}</span>
                    </td>
          <td class="col-md-1">
            <span >{{postValues.count}}</span>
          </td >
        
           
          <td class="col-md-1">
            <span >{{postValues.avg | round(2)}}</span>
          </td>
          
         
          <td class="col-md-1">
                        <span >{{postValues.min}}</span>
          </td>
          <td class="col-md-1">
              <span >{{postValues.max}}</span>
          </td>
            <td class="col-md-1">
                        <span >{{postValues.median}}</span>
           </td>
        </tr>
      </tbody>
    </table>
    </v-card-text>
    </v-card>
    
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      getValues: new perfStat(),
      postValues: new perfStat(),
      repeat:{get:false,post:false},
      counter:null
      }
  },
  methods:{
    update () {
       var _start = performance.now();
      HTTP.post("ping",axios_json)
      .then(r=>{
        var elapsed=Math.floor(performance.now() - _start);
        this.counter=r.data
        Object.assign(this.postValues,this.postValues.log(elapsed))
        if(this.repeat.post){
          this.update(); //does this leak??
        }
      })
    },
    
    get(){
     var _start = performance.now();
     HTTP.get("ping",axios_json)
     .then(r=>{
       var elapsed=Math.floor(performance.now() - _start);
       this.counter=r.data
       Object.assign(this.getValues,this.getValues.log(elapsed))
       this.$forceUpdate()
        if(this.repeat.get){
          this.get(); //does this leak??
        }
     })
    },
    reset(){
      Object.assign(this.getValues,this.getValues.clear());
      Object.assign(this.postValues,this.postValues.clear());
      this.$forceUpdate()
    }
  },
  computed: {
   
  }
}
</script>
