<!DOCTYPE html>
<template id="validate">
  <v-container fluid >
   <v-snackbar    v-model="snackbar.show"
      :timeout="6000"
      :success="snackbar.context === 'success'"
      :error="snackbar.context === 'error'"
    >
      {{ snackbar.msg }}
      <v-btn dark flat @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
<v-card>
     <v-toolbar class="orange">
        
          
           <v-btn  @click="submit"   :loading="loading"  :disabled="false"
             ><v-icon>play_circle_outline</v-icon>validate</v-btn>
             <span v-text="elapsed">?</span>ms.
            <v-spacer></v-spacer>
               <v-btn  @click="clear" :loading="loading"
      :disabled="loading"
          >Clear</v-btn>
             <v-btn  @click="settings" :loading="loading"
      :disabled="loading"
          >Reset</v-btn>
          
         
             <v-btn  @click="valid2" :loading="loading"
      :disabled="loading"
          >is ok?</v-btn>
              <v-menu offset-y left>
             <v-btn icon  slot="activator"><v-icon>settings</v-icon></v-btn>
              <v-card >
              <v-toolbar class="green">
                  <v-card-title >@TODO.......</v-card-title>
                  </v-toolbar>
                <v-card-text>
                stuff
                </v-card-text>
                </v-card>
              </v-menu>
          </v-toolbar>
    <v-card-text v-resize="onResize" style="height:100px" ref="auto">
      <v-container fluid>
        
          <v-layout row wrap> 
          <v-flex xs8>
          <v-form ref="form" v-model="valid" lazy-validation>  
	          <v-flex   v-for="field in fields" :key="field.model"  > 
	            <v-text-field  xs10
	              v-model="params[field.model]" :label="field.label" 
	              clearable  :rules="[rules.required]" box
	              append-outer-icon="send" @click:append-outer="source(field)"
	            ></v-text-field>
	          </v-flex>
	          </v-form>
          </v-flex>
          <v-flex xs4 green fill-height style="height:100%;overflow:scroll">
          <vp-validationreport :report="result"></vp-validationreport>
          </v-flex>
          </v-layout>
      </v-container>
    </v-card-text>

    </v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      loading: false,
      elapsed: null,
      height: null,
      result: null,
      fields:[],
      rules: {
        required: value => !!value || 'Required.'
      },
      params:null,
      snackbar:{show:false,msg:"",context:"success"}
    }
  },
  methods:{
    onResize(){
      //console.log("EL",this.$el);
      var el=this.$refs["auto"];
      var h=window.innerHeight - el.getBoundingClientRect().top -32;
      var h=Math.max(1,h) ;
      //console.log("resize h",h,el.style)
      el.style.height=h +"px"; 
    },
    submit () {
      if (this.$refs.form.validate()) {
        // Native form submission is not yet supported
        this.validate()
      }
    },
    clear () {
      this.$refs.form.reset()
    },
    rules(field){
      return [field.required?this.rules.required:[]];
    },
    source(field){
      console.log("field: ",field);
      router.push({ path: 'tabs', query: { url:this.params[field.model]}})
    },
    valid2(){
      alert("State:"+ this.$refs.form.validate());
    },
    validate(){    
      this.loading=true
      this.start = performance.now();
      HTTP.post("validate",Qs.stringify(this.params))
      .then(r=>{
       console.log(r);
       this.snackbar={show:true,msg:r.data.msg,context:"success"};
       this.elapsed=Math.floor(performance.now() - this.start);
       this.loading=false
       if(r.data.rc==0){
         this.result=r.data
       }else{
         this.result=r.data
       }
      })
      .catch(r=> {
        console.log("error",r.response.data)
          this.snackbar={show: true, msg: r.response.data, context: "error"}
        this.result=r.message + ": "+ r.config.url + "\n"+ r.response.data
        this.loading=false
      });
    },
    settings(){
      HTTP.get("validate")
      .then(r=>{
        this.fields=r.data.fields;
        this.params = Object.assign({}, this.params, r.data.values)
        console.log("settings",this.params);
      })
    },
    isvalid(){
      return this.$refs && this.$refs.form && this.$refs.form.validate()
    }
  },
  computed:{
    valid(){
      console.log("valid------------")
      return this.$refs && this.$refs.form && this.$refs.form.validate()
  }},
  created: function(){
    this.settings();
  }

}
</script>
