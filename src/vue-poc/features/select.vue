<!DOCTYPE html>
<template id="select">
 <v-container fluid>
<v-card>
    <v-toolbar class="green darken-1">
    <v-card-title >
      <span class="white--text">Selection</span>     
    </v-card-title>
    <v-spacer></v-spacer>    
       <v-btn  flat icon @click="showInfo = !showInfo"><v-icon>info</v-icon></v-btn>
  </v-toolbar>
  <qd-panel :show="showInfo">
  

    <v-layout  slot="body">
     
    <v-flex xs6>
    <p>some text</p>
   
  
     <v-autocomplete
              label="Select"
              v-bind:items="options"
              v-model="value"
               item-text="name"
              item-value="name"
              chips
              max-height="auto"
              clearable
              deletable-chips
            >      
           
       </v-autocomplete>
         <pre>{{$data.value }}</pre>
    </v-flex>

    <v-flex xs6 >
    <p>multi select</p>
    
      <v-select
              label="Select"
              v-bind:items="options"
              v-model="value2"
              item-text="name"
              item-value="name"
              multiple
              chips
              deletable-chips
              max-height="auto"
              autocomplete
            >v-select</v-select>
            <pre>{{$data.value2 }}</pre>
    </v-flex>
   </v-layout>
   
   <v-card slot="aside" flat> 
       <v-card-actions >
      <v-toolbar-title >test</v-toolbar-title>
      <v-spacer></v-spacer>    
       <v-btn flat icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-card-actions>
    <v-card-text> blah blah protocol:  </v-card-text> 
    </v-card>
  </qd-panel>
  
</v-card-text>
<v-card>
 </v-container>
</template>

<script>{
  data: function(){
      return {
          value: null,
          value2: null,
          options: [],
          isLoading: false,
          showInfo:true
      }
    },
    created:function(){
      this.asyncFind("")
    },
    methods: {
      asyncFind: function(query){
        this.isLoading = true
        that=this;
        HTTP.get("test-select?q="+query,axios_json)
        .then(function(r){
          that.isLoading = false
          console.log("data::::",r.data);
          that.options=r.data.items;
          })
          .catch(function (error) {
            console.log(error);
            this.isLoading = false
            alert("Get query error")
          });
        }
      }
}

</script>
