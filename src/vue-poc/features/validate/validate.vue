<!DOCTYPE html>
<template id="validate">
  <v-container fluid >
    <v-card>
     <v-toolbar class="orange">
        
          
           <v-btn  @click="submit"   :loading="loading"  :disabled="false"
             ><v-icon>play_circle_outline</v-icon>validate</v-btn>
             <span v-text="elapsed">?</span>ms.
            <v-spacer></v-spacer>
               <v-btn  @click="$refs.params.clear()" :loading="loading"
      :disabled="loading"
          >Clear</v-btn>
             <v-btn  @click="$refs.params.reset()" :loading="loading"
      :disabled="loading"
          >Reset</v-btn>
          
         
             <v-btn   :loading="loading"
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
          <v-flex >
          <vp-paramform ref="params" endpoint="validate"></vp-paramform>
          </v-flex>
         
          <v-flex  green fill-height >
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
      result: null
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
      if (this.$refs.params.valid()) {
        // Native form submission is not yet supported
        this.validate()
      }
    },
    clear () {
      this.$refs.params.clear();
    },
    validate(){    
      this.loading=true
      this.start = performance.now();
      var params=this.$refs.params.submit();
      HTTP.post("validate",Qs.stringify(params))
      .then(r=>{
       console.log(r);
       this.loading=false
       if(r.data.rc==0){
         this.result=r.data
       }else{
         this.result=r.data
       }
      })
      .catch(r=> {
        console.log("error",r.response.data)
       
        this.result=r.message + ": "+ r.config.url + "\n"+ r.response.data
        this.loading=false
      });
    }
  }
}
</script>
