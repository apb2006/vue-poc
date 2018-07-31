<!DOCTYPE html>
<template id="ping">
 <v-container fluid>
 <v-card>
 <v-toolbar >
 <v-toolbar-title>Simple performance measure</v-toolbar-title>
 <v-spacer></v-spacer>
 <v-btn @click="reset()">Reset</v-btn>
 </v-toolbar>
 <v-card-text>
  <p>Read or increment a database value. This measures round trip times browser-database-browser.</p>
  <h3>Counter: <v-chip color="amber" text-color="white">{{counter}}</v-chip></h3>
  <table >
      <thead> 
        <tr>
         <th xs1>Action</th>
          <th xs1>Once</th>
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
              <td>Get</td>
              <td>
               <v-btn @click="get()" icon >
                   <v-icon>radio_button_checked</v-icon>
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
          
            <tr>
             <td>Update</td>
          <td>
           <v-btn @click="update()" icon >
                   <v-icon>radio_button_checked</v-icon>
            </v-btn>
          </td>
          
          <td>
           <v-switch  v-on:change="pchange"  v-model="repeat.post"></v-switch>
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
    gchange(v){
      if(v)this.get() 
    },
    pchange(v){
      if(v)this.update() 
    },
    reset(){
      Object.assign(this.getValues,this.getValues.clear());
      Object.assign(this.postValues,this.postValues.clear());
      this.$forceUpdate()
    }
  },
  beforeRouteLeave(to, from, next){
    var on=this.repeat.get || this.repeat.post

    if (on) {
      alert("running!") //<--undefined
      return next(false)
    } else {
      return next()
    }
  }
}
</script>
