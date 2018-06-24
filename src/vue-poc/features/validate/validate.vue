<!DOCTYPE html>
<template id="validate">
  <v-container fluid v-resize="onResize">
<v-card>
     <v-toolbar class="orange">
          <v-btn  @click="validate"   :loading="loading"
      :disabled="loading"
          ><v-icon>play_circle_outline</v-icon>Validate</v-btn>
          <span v-text="elapsed"></span>ms. Height: 
          <span v-text="height"></span>
            <v-spacer></v-spacer>
         
              <v-menu offset-y left>
             <v-btn icon dark slot="activator"><v-icon>settings</v-icon></v-btn>
              <v-card >
              <v-toolbar class="green">
                  <v-card-title >Settings................</v-card-title>
                  </v-toolbar>
                <v-card-text>
                stuff
                </v-card-text>
                </v-card>
              </v-menu>
          </v-toolbar>
    <v-card-text >
       <qd-autoheight>
    <v-flex   fill-height xs12 >
      test here
      </v-flex>
    </qd-autoheight>
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
      doc: "c:/test.xml",
      schema: "c:/schema.xsd"
      }
  },
  methods:{
    onResize(){
      this.height = window.innerHeight 
    },
    validate(){
    
      this.loading=true
      this.start = performance.now();
      HTTPNE.get("validate",Qs.stringify({doc: this.doc, schema: this.schema}))
      .then(r=>{
       console.log(r)
       this.elapsed=Math.floor(performance.now() - this.start);
       this.loading=false
       if(r.data.rc==0){
         this.result=r.data.result
       }else{
         this.result=r.data.info
       }
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.message + ": "+ r.config.url + "\n"+ r.response.data
        this.loading=false
      });
    },
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}
</script>
