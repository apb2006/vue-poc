<!DOCTYPE html>
<template id="edit">
<v-container fluid>
 <v-layout row wrap>
<v-flex xs12>
<v-toolbar class="green">
  <v-toolbar-title>
    <v-btn @click.native="showfiles()" small icon><v-icon>folder</v-icon></v-btn>
<span >{{ name }}</span> <v-chip small class="primary white--text">{{ mode }}</v-chip>
 
  </v-toolbar-title>
  <v-toolbar-items>
   <v-btn dark icon @click.native="acecmd('outline')">
      <v-icon>star</v-icon>
    </v-btn>
  <v-btn dark icon @click.native="acecmd('goToPreviousError')" >
      <v-icon>navigate_before</v-icon>
    </v-btn>
<v-btn dark icon @click.native="acecmd('goToNextError')">
      <v-icon>navigate_next</v-icon>
    </v-btn>
   <v-btn dark icon @click.native="acecmd('foldall')">
      <v-icon>vertical_align_center</v-icon>
    </v-btn>
 <v-btn dark icon @click.native="acecmd('showSettingsMenu')">
      <v-icon>settings</v-icon>
    </v-btn>
<v-btn dark icon @click.native="wrap=!wrap">
      <v-icon>wrap_text</v-icon>
    </v-btn>
<v-btn dark icon @click.native="acecmd('showKeyboardShortcuts')">
      <v-icon>keyboard</v-icon>
    </v-btn>
   <v-btn dark icon @click.native="save()">
      <v-icon>cloud_upload</v-icon>
    </v-btn>
    <v-btn dark icon @click.native="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn dark icon @click.native="d2 = true">
      <v-icon>delete</v-icon>
    </v-btn>
    <v-menu bottom origin="top right" transition="v-scale-transition">
      <v-btn dark icon slot="activator">
        <v-icon>more_vert</v-icon>
      </v-btn>
     
          <v-list>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title @click="fetch('vue-poc/vue-poc.xqm')">load xquery</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title  @click="fetch('vue-poc/data/vue-poc/ch4d1.xml')">load xml</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title  @click="fetch('vue-poc/static/app.js')">load js</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
          <v-list-item>
              <v-list-tile>
                <v-list-tile-title  @click="fetch('vue-poc/static/app.html')">load html</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
          </v-list>
      </v-menu>
    </v-toolbar-items>
        </v-toolbar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
   <v-dialog v-model="clearDialog" >
  <v-card>
    <v-card-row>
      <v-card-title>Clear?</v-card-title>
    </v-card-row>
    <v-card-row>
      <v-card-text>clear text.</v-card-text>
    </v-card-row>
    <v-card-row actions>
      <v-btn class="green--text darken-1" flat="flat" @click.native="clearDialog = false">Cancel</v-btn>
      <v-btn class="green--text darken-1" flat="flat" @click.native="reset()">Ok</v-btn>
    </v-card-row>
  </v-card>
</v-dialog>
</v-flex>
<v-flex xs12 style="height:70vh" v-if="!busy" fill-height>
  
    <vue-ace editor-id="editorA" :content="contentA" :mode="mode" :wrap="wrap"
v-on:change-content="changeContentA" 
v-on:annotation="annotation"></vue-ace>
  
  </v-flex>
</v-layout>

 </v-container>
</template>

<script>{
  template: '#edit',
  data () {
    return {
      contentA: 'declare function local:query($q as xs:string)\n{\n<json   type="object" >}',
      mode:'xquery',
      url:'',
      name:'',
      path:[],
      wrap:false,
      busy:false,
      clearDialog:false,
      annotations:null
    }
  },
  methods: {
    reset () {
        this.contentA = 'reset content for Editor A'
    },
    changeContentA (val) {
        if (this.contentA !== val) {
        this.contentA = val
      }
    },
    // load from url
    fetch(url){
      this.busy=true
      HTTP.get("raw?url="+url,axios_json)
      .then(r=>{
        //console.log(r)
        var a=acetype(r.data.mimetype)
        this.mode=a
        this.contentA=r.data.data
        var a=url.split("/")
        this.url=url
        this.name=a.pop()
        this.path=a
        this.busy=false
        //alert(mode)
        })
        .catch(error=> {
          console.log(error);
          this.busy=false
          alert("Get query error"+url)
        });
      
    },
    acecmd(cmd){
      Events.$emit('eventFired',cmd);
    },
    fold(){
      Events.$emit('eventFired',"foldall");
    },
    save(){
      alert("TODO save: "+this.path.join("/"));
    },
    showfiles(){
           router.push({ path: 'files', query: { url: this.path.join("/") }})
    },
    beautify(){
      this.busy=true
      var a=this.contentA
      switch(this.mode) {
      case "html":
      case "xml":  
          a=html_beautify(a, { indent_size: 3 ,indent_inner_html:true})
          break;
      case "javascript":
           a=js_beautify(a, { indent_size: 2 })
          break;
      case "css":
         a=css_beautify(a, { indent_size: 2 })
         break;     
      default:
        alert("beaut: " + this.mode)
     } 
      this.contentA=a
      this.busy=false
    },
    annotation(counts){
      this.annotations=counts
    }
  },
  created:function(){
    var url=this.$route.query.url
    console.log("Edit: ",url)
    if(url) this.fetch(url)
  }
}
</script>
