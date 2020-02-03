<!DOCTYPE html>
<!-- 
 manage parameters for query
 including  submit form function 
 -->
<template id="vp-paramform">
  <v-card >
     <v-toolbar  color="blue lighten-3"  dense>
       <v-card-title >{{ description }}</v-card-title>
       <v-spacer></v-spacer>
          <router-link :to="{name:'edit', query:{url: url}}">
            <v-icon :title="url">history</v-icon>{{ name }}
          </router-link>
    </v-toolbar>
    <v-card-text>
       <v-form ref="form"  lazy-validation>

              <v-layout row>
              
	              <v-layout column xs8> 
	              <v-flex v-for="field in fields" :key="field.model" >
	              
	              <v-text-field  v-if="field.type === 'xs:anyURI'" 
	                v-model="params[field.model]" :label="field.label" 
	                clearable  :rules="fieldrules(field)" filled
	                append-outer-icon="send" @click:append-outer="source(field)"
	              ></v-text-field>
	              
	              <v-switch  v-else-if="field.type === 'xs:boolean'"  
	                :label="field.label"  v-model="params[field.model]">
	              </v-switch>
	              
	              <v-text-field  v-else filled
	                v-model="params[field.model]" :label="field.label" 
	                clearable    ></v-text-field>
	                
	              </v-flex>
	             
	              </v-layout>
               <v-layout column >TODO
               </v-layout> 
              </v-layout>
            </v-form>
           
       </v-card-text>
           <v-card-actions>
              <v-btn  @click="clear()" id="btn-clear"
				 >Clear</v-btn>
		     <v-btn  @click="reset()"
		         >Reset</v-btn>
           </v-card-actions>
           <v-btn  @click="zlog()"
		         >console</v-btn>
           </v-card-actions>
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
       return HTTP.post(this.endpoint, Qs.stringify(this.params));
     },
     valid(){
       return this.$refs.form.validate()
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
