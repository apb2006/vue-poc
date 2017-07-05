<!DOCTYPE html>
<template id="edit">
<v-container fluid>
      <v-snackbar top error  v-model="snackbar">
      {{ message }}
      <v-btn flat  @click.native="snackbar = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-snackbar>
<v-card>

<v-toolbar class="grey lighten-2 black--text">
<v-menu >
  <v-btn primary icon dark slot="activator" v-tooltip:top="{ html: path.join('/') }"><v-icon >folder</v-icon></v-btn>
  <v-list>
      <v-list-tile  v-for="item in path" :key="item" @click="showfiles()">
        <v-list-tile-title >{{ item }}</v-list-tile-title>
      </v-list-tile>
  </v-list>
</v-menu>

  <v-toolbar-title >
      <span >{{ name }}</span>
  </v-toolbar-title>
  <v-toolbar-items>
  <span v-tooltip:top="{ html: 'Changed?' }">
  <v-chip v-if="dirty" label small class="red white--text">*</v-chip>
<v-chip  v-if="!dirty" label small class="green white--text">.</v-chip>
</span>
 <v-chip small  v-tooltip:top="{ html: mimetype }">{{ mode }}</v-chip>
     <v-chip   @click.native="acecmd('goToNextError')"
          v-tooltip:top="{ html: 'Annotations: Errors,Warning and Info' }"
           >
          <v-avatar  class="green ">{{annotations && annotations.info}}</v-avatar>
          <v-avatar  class="yellow ">{{annotations && annotations.warning}}</v-avatar>        
          <v-avatar   class="red " small>{{annotations && annotations.error}}</v-avatar>    
           <v-avatar>
              <v-icon black >navigate_next</v-icon>
           </v-avatar>
          </v-chip>
   <v-btn dark icon @click.native="acecmd('outline')">
      <v-icon>star</v-icon>
    </v-btn>

  
   <v-btn dark icon @click.native="acecmd('foldall')">
      <v-icon>vertical_align_center</v-icon>
    </v-btn>
    
    <v-btn dark icon @click.native="wrap=!wrap">
      <v-icon>wrap_text</v-icon>
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
        <v-menu left  transition="v-fade-transition">
        <v-btn dark icon slot="activator">
          <v-icon>help</v-icon>
        </v-btn>     
        <v-list>
            <v-list-tile @click="acecmd('showSettingsMenu')" avatar >
               <v-list-tile-avatar>
              <v-icon >settings</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title >Show settings</v-list-tile-title>
            </v-list-tile>
                      
            <v-list-tile @click="acecmd('showKeyboardShortcuts')" avatar>
              <v-list-tile-avatar>
              <v-icon >keyboard</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title  >Show keyboard commands</v-list-tile-title>
            </v-list-tile>
          </v-list>
       </v-menu>
    <v-menu left  transition="v-fade-transition">
      <v-btn dark icon slot="activator">
        <v-icon>more_vert</v-icon>
      </v-btn>
     
          <v-list>
              <v-list-tile>
                <v-list-tile-title >unused</v-list-tile-title>
              </v-list-tile>           
          </v-list>
          
      </v-menu>
    </v-toolbar-items>
     <v-dialog v-model="clearDialog" >
       <v-card>
		      <v-card-title>Clear?</v-card-title>
		      <v-card-text>clear text.</v-card-text>
		    <v-card-actions>
		      <v-btn class="green--text darken-1" flat="flat" @click.native="reset(false)">Cancel</v-btn>
		      <v-btn class="green--text darken-1" flat="flat" @click.native="reset(true)">Ok</v-btn>
		    </v-card-actions>
		    </v-card>
		</v-dialog>
 </v-toolbar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>

<v-card-text v-if="!busy">
<v-flex xs12 style="height:70vh"  fill-height>
  
    <vue-ace  :content="contentA" :mode="mode" :wrap="wrap"
v-on:change-content="changeContentA" 
v-on:annotation="annotation"></vue-ace>
 </v-flex> 
</v-card-text>
</v-card>
  
 </v-container>
</template>

<script>{
  data () {
    return {
      contentA: `declare function local:query($q as xs:string)
{ <json type="object"/> 
};`,
      mode:'xquery',
      url:'',
      name:'',
      path:[],
      mimetype:"",
      wrap:false,
      busy:false,
      clearDialog:false,
      annotations:null,
      dirty:false,
      snackbar:false,
      message:"Cant do that",
      mimemap:{
          "text/xml":"xml",
          "application/xml":"xml",
          "application/xquery":"xquery",
          "text/ecmascript":"javascript",
          "application/sparql-query":"sparql",
          "text/html":"html",
          "text/turtle":"turtle",
          "text/css":"css",
          "image/svg+xml":"svg"
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
      HTTP.get("edit?url="+url,axios_json)
      .then(r=>{
        //console.log(r)
        this.mimetype=r.data.mimetype
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
      alert("TODO save: "+this.url);
      var data=Qs.stringify(
          {
            url: this.url, //gave the values directly for testing
            data: this.contentA
            })
      HTTP.post("edit", data,{
  headers: { "Content-Type": "application/x-www-form-urlencoded"}
      }).then(r=>{
        alert("AAA")
      })
    },
    showfiles(){
           router.push({ path: 'files', query: { url: this.path.join("/") }})
    },
    beautify(){
      this.busy=true
      var a=this.contentA
      switch(this.mode) {
      case "html":
      case "svg":  
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
        this.message="No beautify yet for "+this.mode
        this.snackbar=true
     } 
      this.contentA=a
      this.busy=false
    },
    annotation(counts){
      this.annotations=counts
      console.log("annotations: ",counts)
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
