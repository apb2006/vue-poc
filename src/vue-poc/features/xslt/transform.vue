<!DOCTYPE html>
<template id="transform">
 <v-container fluid >
<v-card>
     <v-toolbar class="orange">
          <v-btn  @click="transform"   :loading="loading"
      :disabled="loading"
          ><v-icon>play_circle_outline</v-icon>Run</v-btn>
          <span v-text="elapsed"></span>ms. Height: 
          <span v-text="height"></span>
            <v-spacer></v-spacer>
           <v-btn-toggle v-model="showOptions" multiple>
           <v-icon>visibility</v-icon>
              <v-btn flat value="result" >
                <span :class="resultValid?'':'red'">Result</span>
              </v-btn>
              <v-btn flat value="xml">
               <span :class="xmlValid?'':'red'">XML</span>
              </v-btn>
              <v-btn flat value="xslt">
                 <span :class="xslValid?'':'red'">XSLT</span>
              </v-btn>
            </v-btn-toggle>
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
          
    <v-card-text  class="amber" >
       <qd-autoheight>

      <v-flex  v-if="showOptions.includes('result')" fill-height xs12 >
        <vue-ace :content="result" mode="xml" wrap="true" :settings="aceSettings"></vue-ace>
      </v-flex>
 
      <v-flex v-if="showOptions.includes('xml')"    fill-height >
	      <vue-ace  :content="xml" mode="xml" wrap="true" 
	      v-on:change-content="v => this.xml=v" v-on:annotation="a => this.xmlValid=a.error===0 && a.warning===0"
	     :settings="aceSettings"></vue-ace>
     </v-flex>
     
       <v-flex v-if="showOptions.includes('xslt')"   fill-height >
	       <vue-ace  :content="xslt" mode="xml" wrap="true" 
	       v-on:change-content="v => this.xslt=v"  v-on:annotation="a => this.xslValid=a.error===0 && a.warning===0"
	      :settings="aceSettings"></vue-ace>
      </v-flex>
      
     </qd-autoheight>
      </v-card-text>
      </v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      xml:"<foo />",
      xmlValid: true,
      xslt:'<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">\n</xsl:stylesheet>',
      xslValid: true,
      aceSettings: {},
      result: "(result here)",
      resultValid: true,
      showOptions: ["xml","xslt"],
      loading: false,
      start: null,
      elapsed: "?",
      height: "?"
      }
  },
  methods:{
  
    transform(){
      localforage.setItem('transform/xml', this.xml)
      localforage.setItem('transform/xslt', this.xslt)
      if(!this.showOptions.includes("result"))this.showOptions.push("result")
      this.loading=true
      this.resultValid=true
      this.start = performance.now();
      HTTPNE.post("xslt",Qs.stringify({xml:this.xml,xslt:this.xslt}))
      .then(r=>{
       console.log(r)
       this.elapsed=Math.floor(performance.now() - this.start);
       this.loading=false
       if(r.data.rc==0){
         this.result=r.data.result
       }else{
         this.result=r.data.info
         this.resultValid=false
       }
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.message + ": "+ r.config.url + "\n"+ r.response.data
        this.loading=false
      });
    },
  }, 
  beforeRouteEnter (to, from, next) {
    settings.getItem('settings/ace')
    .then( v =>{
      
      next(vm => {
        console.log('eval settings: ',v);
        vm.aceSettings = v;
        })})
     },
  created:function(){
    console.log("transform")
    localforage.getItem('transform/xml').then((value) => { this.xml=value || this.xml});
    localforage.getItem('transform/xslt').then((value) => { this.xslt=value || this.xslt});
  }
}
</script>
