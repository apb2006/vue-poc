<!DOCTYPE html>
<template id="formsjson">
 <v-container fluid>
     <v-card>
        <v-card-title><qd-link href="https://github.com/formschema/native">vue-json-schema@1.1.0</qd-link> </v-card-title>
        
       <form-schema  ref="formSchema" :schema="schema" v-model="model" input-wrapping-class="fooclass">
              <v-btn color="success" @click.stop="submit">Send</v-btn>
  </form-schema>
  
    </v-card>
 </v-container>
</template>

<script>{

  components: { 
    "form-schema": window["vue-json-schema"].default
    },
 
  data: () => ({
    schema: {
      "$schema": "http://json-schema.org/draft-04/schema#",
      "type": "object",
      "title": "Sample form title",
      "properties": {
          "name": {
              "type": "string",
              "title": "Name ",
              "minLength": 8, 
              "maxLength": 80, 
              "attrs": {
                "placeholder": "Full Name",
                "title": "Please enter your full name"
              }
          },
          "email": {
              "type": "string",
              "title": "Email label ", 
              "maxLength": 120, 
              "attrs": {
                  "type": "email",
                  "placeholder": "Email"
              }
          },
          "lists": {
              "type": "string",
              "title": "List label ",
              "enum": ["Daily New", "Promotion", "Another"]
          },
          "arrayInput": {
            "type": "array",
            "title": "Array label ",
            "items": {
              "type": "string"
            }
          }
      },
      "additionalProperties": false,
      "required": ["name", "email", "lists"]
  },
    model: {}
  }),
  methods: {
    submit (e) {
      // this.model contains the valid data according your JSON Schema.
      // You can submit your model to the server here
      console.log(this.model);
      alert("hi")
    }
  }
}
</script>
