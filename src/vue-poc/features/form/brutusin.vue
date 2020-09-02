<!DOCTYPE html>
<template id="brutusin">
 <v-container fluid>
     <v-card>
     <v-card-title>
	     <v-toolbar-title>Form </v-toolbar-title>
	
	        <v-chip v-if="formValid" color="success">valid</v-chip>
	        <v-chip v-else color="danger">invalid</v-chip>
	        <v-btn color="primary" @click="$refs.myForm.validate()">validate</v-btn>
	      <v-spacer></v-spacer>
	      <qd-link href="https://github.com/koumoul-dev/vuetify-jsonschema-form/">vuetify-jsonschema-form@v1.10.0</qd-link>
     </v-card-title>
     <v-card-actions>
     <v-layout row wrap>
       <v-flex xs2>
      <v-select :items="schemas" v-model="schemaUri"  label="Choose an Schema" @change="applyExample" />
      </v-flex>
        <v-flex>
      <v-btn @click="showschema()">show</v-btn>
      </v-flex>
      </v-layout>
      </v-card-actions>
     <v-card-text>
      <v-container grid-list-md >
    <v-layout row wrap>
      <v-flex xs8>
      <v-form ref="myForm" v-model="formValid">
        <v-btn @click="submit" :disabled="!formValid">submit</v-btn>
          <v-jsf v-if="schema" :schema="schema" v-model="model" :options="options" @error="e => window.alert(e)" />
       </v-form>
       </v-flex>
       
       <v-flex xs4 class="grey lighten-2">
        <h2 class="title my-4">Data:</h2>
        <pre style="text-align:left">{{ model | pretty }}</pre>
       </v-flex>
       </v-layout>
       </v-container>
       </v-card-text>
    </v-card>
 </v-container>
</template>

<script>{
  components: {
    "v-jsf": VJsf.default
   },
   data() {
     return {
       model: {},
       schema: null,
       schemaUri: "person.json",
       schemas: [
         "person.json",
         "select.json",
         "arrays.json"
       ],
       formValid: false,
       options: {
         debug: true,
         disableAll: false,
         autoFoldObjects: true,
         httpLib: HTTP
       }
     };
   },
   
  methods:{
    onResize(){
      var el=this.$refs["page"]
      console.log("top",el.offsetTop)
      var h=Math.max(1,window.innerHeight - el.offsetTop)-60
       console.log("h",h)
      el.style.height=h +"px"
    },
    applyExample(uri){
      console.log(uri);
      this.model={}
      this.schema=null
      HTTP.get("form/schema",{params: {uri: uri}})
      .then(r=>{
        this.schema=r.data;
      })
    },
    submit(){
      alert("todo")
    },
    showschema(){
      alert("as")
    }
  },
  
  filters: {
    pretty: function(value) {
      return JSON.stringify(value, null, 2);
    }
  },
  created:function(){
    console.log("form")
    HTTP.get("form/schema",{})
    .then(r=>{
      this.schema=r.data;
    })
  }
}
</script>
