<!DOCTYPE html>
<template id="formsschema">
 <v-container fluid>
     <v-card>
        <v-card-title><qd-link href="https://jarvelov.gitbooks.io/vue-form-json-schema/">vue-form-json-schema@1.13.4</qd-link> </v-card-title>
        
     <vue-form-json-schema
      :model="model"
      :schema="schema"
      :ui-schema="uiSchema"
      :on-change="onChange"
    >
	  </vue-form-json-schema>
	  </v-card>
  </v-container>
</template>
<script>{
  
  data: () => ({
    model: {},
    
    // A valid JSON Schema object
    schema: {
      type: 'object',
      properties: {
        firstName: {
          type: 'string',
        },
      },
    },
    
    // Array of HTML elements or Vue components
    uiSchema: [{
      component: 'input',
      model: 'firstName',
      // Same API as [Vue's render functions](https://vuejs.org/v2/guide/render-function.html#The-Data-Object-In-Depth)
      fieldOptions: {
        class: ['form-control'],
        on: ['input'],
        attrs: {
          placeholder: 'Please enter your first name',
        },
      },
    }]
  }),
  methods: {
    onChange(value) {
      this.model = value;
    }
  }
  
}</script>
