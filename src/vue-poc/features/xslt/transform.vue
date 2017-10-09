<!DOCTYPE html>
<template id="transform">
 <v-container fluid>
<v-card>
     <v-toolbar >
          <v-btn  @click="transform"   :loading="loading"
      :disabled="loading"
          ><v-icon>play_circle_outline</v-icon>Run</v-btn>
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
             <v-btn icon><v-icon>settings</v-icon></v-btn>
          </v-toolbar>
    <v-card-text >
     <v-card-text v-if="showOptions.includes('result')">
       <v-layout style="height:200px"  fill-height >
      <v-flex >
        <vue-ace :content="result" mode="xml" wrap="true" :settings="aceSettings"></vue-ace>
      </v-flex>
       </v-layout>
      </v-card-text>
      <v-layout style="height:200px"  fill-height >
      <v-flex v-if="showOptions.includes('xml')" class="pa-1">
	      <vue-ace  :content="xml" mode="xml" wrap="true" 
	      v-on:change-content="v => this.xml=v" v-on:annotation="a => this.xmlValid=a.error===0 && a.warning===0"
	     :settings="aceSettings"></vue-ace>
     </v-flex>
       <v-flex v-if="showOptions.includes('xslt')" class="pa-1">
	       <vue-ace  :content="xslt" mode="xml" wrap="true" 
	       v-on:change-content="v => this.xslt=v"  v-on:annotation="a => this.xslValid=a.error===0 && a.warning===0"
	      :settings="aceSettings"></vue-ace>
      </v-flex>
     
      </v-layout>
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
      loading: false
      }
  },
  methods:{
  
    transform(){
      localforage.setItem('transform/xml', this.xml)
      localforage.setItem('transform/xslt', this.xslt)
      if(!this.showOptions.includes("result"))this.showOptions.push("result")
      this.loading=true
      this.resultValid=true
      HTTPNE.post("xslt",Qs.stringify({xml:this.xml,xslt:this.xslt}))
      .then(r=>{
       console.log(r)
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
        this.result=r.response.data.info
        this.loading=false
      });
    }
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
