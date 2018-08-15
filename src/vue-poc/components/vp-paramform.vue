<!DOCTYPE html>
<!-- 
 manage parameters for query
 including funtion to submit form
 -->
<template id="vp-paramform">
       <v-form ref="form"  lazy-validation>
              <div class="title">{{ description }}</div>
              <div :title="url">{{ updating }}</div>
              <v-layout row>
              
              <v-layout column xs10> 
              <v-flex v-for="field in fields" :key="field.model" >
              
              <v-text-field  v-if="field.type === 'xs:anyURI'" :full-width="true" 
                v-model="params[field.model]" :label="field.label" 
                clearable  :rules="fieldrules(field)" box
                append-outer-icon="send" @click:append-outer="source(field)"
              ></v-text-field>
              
              <v-switch  v-else-if="field.type === 'xs:boolean'" :full-width="true" 
                :label="field.label"  v-model="params[field.model]">
              </v-switch>
              
              
              <v-text-field  v-else :full-width="true" amber
                v-model="params[field.model]" :label="field.type" 
                clearable   box ></v-text-field>
                
              </v-flex>
              <v-flex>
             
              </v-flex>
              </v-layout>
              
              <v-layout align-center justify-center column fill-height xs2 amber lighten-5>
               <v-btn  @click="clear()" 
					          >Clear</v-btn>
					     <v-btn  @click="reset()"
					          >Reset</v-btn>
              </v-layout>
              </v-layout>
            </v-form>
</template>

<script>{
  props: ['endpoint'],
  data: function(){
    return {
      fields: [],      
      params: null,
      description: null,
      updating: false,
      url: null,
      rules: {
        required: value => !!value || 'Required.'
      }
    } 
  },
  methods:{
      reset(){
        HTTP.get(this.endpoint)
        .then(r=>{
          this.fields= r.data.fields;
          this.description= r.data.description;
          this.updating= r.data.updating;
          this.url= r.data.url;
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
       return HTTP.post(this.endpoint, Qs.stringify(this.params));
     },
     valid(){
       return this.$refs.form.validate()
     }
  },
  created:function(){
    this.reset();
  }
}</script>
