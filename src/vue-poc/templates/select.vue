<!DOCTYPE html>
<template id="select">
 <v-container fluid>
<v-card>
  <v-card-row class="green darken-1">
    <v-card-title>
      <span class="white--text">Selection</span>
      
    </v-card-title>
  </v-card-row>
  <v-card-text>
    <v-card-row> 
    <v-col xs6>
    <p>some text</p>
    <multiselect v-model="value" :options="options" @search-change="asyncFind" :loading="isLoading" 
    placeholder="select one"></multiselect>
    <pre>{{$data.value }}</pre>
    </v-col>

    <v-col xs6 >
    <p>multi select</p>
    <multiselect v-model="value2" :options="options" multiple 
    placeholder="Select many"></multiselect>
    <pre>{{$data.value2 }}</pre>
    </v-col>
   </v-card-row>
</v-card-text>
<v-card>
 </v-container>
</template>

<script>{
  template: '#select',
  components: { multiselect: VueMultiselect.Multiselect}, 
  data: function(){
      return {
          value: null,
          value2: null,
          options: [],
          isLoading: false
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
