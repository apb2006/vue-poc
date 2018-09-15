<!DOCTYPE html>
<template id="formsjson">
 <v-container fluid>
     <v-card>
     <v-toolbar dense >
        <v-card-title><qd-link href="https://gitlab.com/formschema/native">vue-json-schema@1.1.1</qd-link> </v-card-title>
      </v-toolbar> 
     <v-card-text>
        <v-container grid-list-md text-xs-center>
				    <v-layout row wrap>
				      <v-flex xs8>
				     
				          <form-schema  v-if="schema2" ref="formSchema" :schema="schema2" v-model="model" @submit.stop="submit"
				          input-wrapping-class="text-xs-left">
				             <v-btn color="success" type="submit">Send</v-btn>
				          </form-schema>
				    
				       </v-flex>
				       
				       <v-flex xs4>
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
    "form-schema": window["vue-json-schema"].default
    },
 
  data: () => ({
    schema2: null,
    model: {}
  }),
  methods: {
    submit (e) {
      // this.model contains the valid data according your JSON Schema.
      // You can submit your model to the server here
      console.log(this.model);
      alert("no submit yet")
    }
  },
  created:function(){
    HTTP.get("form/schema",{})
    .then(r=>{
      this.schema2=r.data;
    })
  }
    
}
</script>
