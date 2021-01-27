<!DOCTYPE html>
<!-- 
 A form to manage parameters for query
  <vp-paramform  v-if="!loading" ref="params" :endpoint="endpoint"></vp-paramform>
 @param endpoint
 to  submit form function via POST  
 this.$refs.params.submit() 
 -->
<template id="vp-paramform">
  <v-card >
     <v-toolbar  color="blue lighten-3"  dense>
       <v-card-title >{{ description }}</v-card-title>
       <v-spacer></v-spacer>
       <v-menu offset-y>
      <template v-slot:activator="{ on, attrs }">
        <v-btn v-bind="attrs"  v-on="on" icon>
              <v-icon>more_vert</v-icon>
        </v-btn>
      </template>
      <v-list>     
         <v-list-item @click="reset()">
          <v-list-item-title>Set default values</v-list-item-title>
        </v-list-item>
         <v-list-item @click="clear()">
          <v-list-item-title>Clear all</v-list-item-title>
        </v-list-item>
        <v-divider ></v-divider>
         <v-list-item @click="zlog()">
          <v-list-item-title>Console test</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>     
    </v-toolbar>
    <v-card-text>
       <v-form ref="form" v-model="valid" lazy-validation>

              <v-layout row>
              
	              <v-layout column xs8> 
	              <v-flex v-for="field in fields" :key="field.model" >
	              
	              <v-text-field  v-if="field.type === 'xs:anyURI'" 
	                v-model="params[field.model]" :label="field.label && field.model" 
	                clearable  :rules="fieldrules(field)" filled
	                append-outer-icon="send" @click:append-outer="source(field)"
	              ></v-text-field>
	              
	               <v-text-field  v-else-if="field.type === 'xs:integer'"
	                 type="number" 
	                v-model.number="params[field.model]" :label="field.label && field.model" 
	                clearable  :rules="fieldrules(field)" filled           
	              ></v-text-field>
	              
	              <v-switch  v-else-if="field.type === 'xs:boolean'"  
	                :label="field.label"  v-model="params[field.model]">
	              </v-switch>
	              
	              <v-text-field  v-else filled
	                v-model="params[field.model]" :label="field.label" 
	                clearable    ></v-text-field>
	                
	              </v-flex>
	             
	              </v-layout>
               <v-layout column >TODO <span>{{valid}}</span>
               </v-layout> 
              </v-layout>
            </v-form>
           
       </v-card-text>
       
    </v-card>
</template>

<script>{
  props: ['endpoint'],
  data: function(){
    return {
      fields: [],      
      params: null,
      description: null,
      updating: false,
      valid: true,
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
     zlog(){
    	 console.log(JSON.stringify(this.params)) 
     },
     clear () {
       this.$refs.form.reset()
     },
     fieldrules(field){
       return [this.rules.required];
     },
     submit(){
       if(this.$refs.form.validate()){
    	   return HTTP.post(this.endpoint, Qs.stringify(this.params));
       }
     }
  },
  computed: {
	  name(){
	   return this.url && this.url.substring(this.url.lastIndexOf('/') + 1)
	  }
  },
  watch:{
	 params(vold,vnew) {
		 console.log("params: ",vnew)
	 }
  },
  created:function(){
    this.reset();
  }
}</script>
