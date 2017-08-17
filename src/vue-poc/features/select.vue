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
  
    <v-flex slot="body">
    <v-layout>
     
    <v-flex xs6>
    <p>some text</p>
    <multiselect v-model="value" :options="options" @search-change="asyncFind" :loading="isLoading" 
    placeholder="select one"></multiselect>
    <pre>{{$data.value }}</pre>
    </v-flex>

    <v-flex xs6 >
    <p>multi select</p>
    <multiselect v-model="value2" :options="options" multiple 
    placeholder="Select many"></multiselect>
    <pre>{{$data.value2 }}</pre>
    </v-flex>
   </v-layout>
   </v-flex>
   
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
  components: { multiselect: VueMultiselect.Multiselect}, 
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
