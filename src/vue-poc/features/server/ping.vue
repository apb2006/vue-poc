<!DOCTYPE html>
<template id="ping">
 <v-container fluid>
 <v-card>
 <v-toolbar >
 <v-toolbar-title>Simple response counter</v-toolbar-title>
 <v-spacer></v-spacer>
 <v-btn @click="reset()">Reset</v-btn>
 </v-toolbar>
 <v-card-text>
  <p>Read or increment a database value. This measures round trip times browser-database-browser.</p>
  <h3>Value: <v-chip color="amber" text-color="white">{{counter}}</v-chip></h3>
  <table class="v-table">
      <thead> 
        <tr>
         <th class="col-md-1">Action</th>
          <th class="col-md-1">Repeat</th>
          <th class="col-md-1 text-right">Last</th>
          <th class="col-md-1 text-right">Count</th>
          <th class="col-md-1 text-right">Avg</th>
          <th class="col-md-1 text-right">min</th>
          <th class="col-md-1 text-right">max</th>
          <th class="col-md-1 text-right">Median</th>
        </tr>
      </thead>
      <tbody>

      
          <tr>
              <td>
               <v-btn @click="get()"  >
                   Read Db<v-icon right>compare_arrows</v-icon> 
                </v-btn>
             
               </td>
               <td>
                <v-switch v-on:change="gchange" v-model="repeat.get"></v-switch>

             </td>    
              <td>
                  <p  class="text-right">{{getValues.last}}</p>
              </td>
              <td>
                  <p  class="text-right" >{{getValues.count}}</p>
              </td>   
            
              <td>
                  <p  class="text-right" >{{getValues.avg | round(2)}}</p>
              </td>
            
              <td>
                  <p  class="text-right" >{{getValues.min}}</p>
              </td>
              <td>
                  <p  class="text-right" >{{getValues.max}}</p>
              </td>
                <td>
                  <p  class="text-right" >{{getValues.median}}</p>
              </td>
          </tr>
          
            <tr>
          <td>
           <v-btn @click="update()"  >
                 Write Db<v-icon right>compare_arrows</v-icon>
            </v-btn>
          </td>
          
          <td>
           <v-switch  v-on:change="pchange"  v-model="repeat.post"></v-switch>
          </td>
           <td  class="text-right">
                <span >{{postValues.last}}</span>
           </td>
          <td  class="text-right">
            <span >{{postValues.count}}</span>
          </td >
                 
          <td  class="text-right">
            <span >{{postValues.avg | round(2)}}</span>
          </td>
          
          <td  class="text-right">
            <span >{{postValues.min}}</span>
          </td>
          <td  class="text-right">
              <span >{{postValues.max}}</span>
          </td>
            <td  class="text-right">
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
      nothingValues: new perfStat(),
      staticValues: new perfStat(),
      getValues: new perfStat(),
      postValues: new perfStat(),
      repeat: {get: false, post: false, staticx: false, nothing: false},
      counter: "(unread)"
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
    nothing () {
      var _start = performance.now();
     HTTP.post("nothing",axios_json)
     .then(r=>{
       var elapsed=Math.floor(performance.now() - _start);
       this.counter=r.data
       Object.assign(this.nothingValues,this.nothingValues.log(elapsed))
       if(this.repeat.nothing){
         this.nothing(); //does this leak??
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
