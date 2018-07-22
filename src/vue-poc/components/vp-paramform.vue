<!DOCTYPE html>
<!-- 
 manage parameters for query
 -->
<template id="vp-paramform">
       <v-form ref="form"  lazy-validation> 
              <v-flex v-for="field in fields" :key="field.model">
              
              <v-text-field  v-if="field.type === 'xs:anyURI'" xs10 
                v-model="params[field.model]" :label="field.label" 
                clearable  :rules="fieldrules(field)" box
                append-outer-icon="send" @click:append-outer="source(field)"
              ></v-text-field>
              
              <v-switch  v-else-if="field.type === 'xs:boolean'" xs10 :label="field.label"  v-model="params[field.model]">
              </v-switch>
              
              
              <v-text-field  v-else xs10 amber
                v-model="params[field.model]" :label="field.type" 
                clearable   box
               
              ></v-text-field>
              </v-flex>
             <div>{{ description }}</div>
            </v-form>
</template>

<script>{
  props: ['endpoint'],
  data: function(){
    return {
      fields: [],      
      params: null,
      description: null,
      rules: {
        required: value => !!value || 'Required.'
      }
    } 
  },
  methods:{
      reset(){
        HTTP.get(this.endpoint)
        .then(r=>{
          this.fields=r.data.fields;
          this.description=r.data.description;
          this.params = Object.assign({}, this.params, r.data.values);
        })
     },
     source(field){
       router.push({ path: 'tabs', query: { url:this.params[field.model]}})
     },
     clear () {
       this.$refs.form.reset()
     },
     fieldrules(field){
       return [this.rules.required];
     },
     submit(){
       return this.params;
     },
     valid(){
       return this.$refs.form.validate()
     }
  },
  created:function(){
    this.reset();
  }
}</script>
