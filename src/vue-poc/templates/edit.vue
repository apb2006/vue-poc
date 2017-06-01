<!DOCTYPE html>
<template id="edit">
<v-container fluid>
 <v-layout row wrap>
<v-flex xs12>
<v-toolbar class="green">
  <v-toolbar-title>
    <v-btn @click.native="showfiles()" small icon><v-icon>folder</v-icon></v-btn>
<span >{{ name }}</span> <v-chip small class="primary white--text">{{ mode }}</v-chip>
   {{dirty}}
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
      <v-icon>file_upload</v-icon>
    </v-btn>
    <v-btn dark icon @click.native="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn dark icon @click.native="clearDialog = true">
      <v-icon>delete</v-icon>
    </v-btn>
    <v-menu bottom origin="top right" transition="v-scale-transition">
      <v-btn dark icon slot="activator">
        <v-icon>more_vert</v-icon>
      </v-btn>
     
          <v-list>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title @click="fetch('/vue-poc/vue-poc.xqm')">load xquery</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title  @click="fetch('/vue-poc/data/vue-poc/ch4d1.xml')">load xml</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title  @click="fetch('/vue-poc/static/app.js')">load js</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
          <v-list-item>
              <v-list-tile>
                <v-list-tile-title  @click="fetch('/vue-poc/static/app.html')">load html</v-list-tile-title>
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
      <v-btn class="green--text darken-1" flat="flat" @click.native="reset(false)">Cancel</v-btn>
      <v-btn class="green--text darken-1" flat="flat" @click.native="reset(true)">Ok</v-btn>
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
      contentA: 'declare function local:query($q as xs:string)\n { \n <json   type="object" > }',
      mode:'xquery',
      url:'',
      name:'',
      path:[],
      wrap:false,
      busy:false,
      clearDialog:false,
      annotations:null,
      dirty:false,
      mimemap:{
          "text/xml":"xml",
          "application/xml":"xml",
          "application/xquery":"xquery",
          "text/ecmascript":"javascript",
          "text/html":"html"
      }
    }
  },
  methods: {
    reset (ok) {
        if(ok){
          this.contentA = 'reset content for Editor A'
          this.dirty=false
        }
        this.clearDialog=false
    },
    changeContentA (val) {
        if (this.contentA !== val) {
        this.contentA = val
        this.dirty=true
      }
    },
    // load from url
    fetch(url){
      this.busy=true
      HTTP.get("raw?url="+url,axios_json)
      .then(r=>{
        //console.log(r)
        this.mode=this.acetype(r.data.mimetype)
        this.contentA=r.data.data
        var a=url.split("/")
        this.url=url
        this.name=a.pop()
        this.path=a
        this.busy=false
        this.dirty=false
        //alert(mode)
        })
        .catch(error=> {
          console.log(error);
          this.busy=false
          alert("Get query error:\n"+url)
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
    },
    acetype(mime){
      var r=this.mimemap[mime]
      return r?r:"text"
    },
    leaving(event) {
      event.returnValue = "event seems to need to be set";
      //debugger;
      console.log("Leaving...");
      if(this.dirty)event.preventDefault();
  }
  },
  created(){
    //https://forum.vuejs.org/t/detect-browser-close/5001/3 @fixme
    document.addEventListener('beforeunload', this.leaving);
    var url=this.$route.query.url
    console.log("Edit: ",url)
    if(url) this.fetch(url)
  },
  beforeRouteLeave (to, from, next) {
    // called when the route that renders this component is about to
    // be navigated away from.
    // has access to `this` component instance.
    if(this.dirty && confirm("unsaved changes will be lost"))this.dirty=false;
    next(!this.dirty);
  }
}
</script>
