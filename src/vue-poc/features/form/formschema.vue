<!DOCTYPE html>
<template id="formsjson">
 <v-container fluid>
     <v-card>
        <v-card-title>vue-json-schema@1.1.0 https://github.com/formschema/native</v-card-title>
       <form-schema  ref="formSchema" :schema="schema" v-model="model" >
              <v-btn color="success" @click.stop="submit">Subscribe</v-btn>
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
      "title": "Newsletter Subscription",
      "properties": {
          "name": {
              "type": "string", 
              "minLength": 8, 
              "maxLength": 80, 
              "attrs": {
                "placeholder": "Full Name",
                "title": "Please enter your full name"
              }
          },
          "email": {
              "type": "string", 
              "maxLength": 120, 
              "attrs": {
                  "type": "email",
                  "placeholder": "Email"
              }
          },
          "lists": {
              "type": "string",
              "enum": ["Daily New", "Promotion"]
          },
          "arrayInput": {
            "type": "array",
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
