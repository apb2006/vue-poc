<!DOCTYPE html>
<template id="edit">
<v-container fluid>
      <v-snackbar top color="error"  v-model="snackbar">
      {{ message }}
      <v-btn flat  @click="snackbar = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-snackbar>
    
<v-card>
<v-toolbar dense>
<v-tooltip top >
<v-menu slot="activator">

  <v-btn color="primary" icon  slot="activator"><v-icon >{{icon}}</v-icon></v-btn>
  <v-list>
      <v-list-tile  v-for="item in path" :key="item">
        <v-list-tile-content @click="showfiles()">
        <v-list-tile-title >{{ item }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
  </v-list>
</v-menu>
<span>{{ path.join('/') }}</span>
</v-tooltip>
  
   <v-badge right v-model="dirty" >
     <span slot="badge" >*</span>
     <v-toolbar-title >{{ name }}</v-toolbar-title>
     </v-badge>
     <v-btn v-if="dirty" icon @click="save()">
      <v-icon>file_upload</v-icon>
    </v-btn>
    <v-spacer></v-spacer>

  <v-menu left  transition="v-fade-transition" >
      <v-chip label small slot="activator" >{{ mode }}</v-chip>
          <v-list dense>
              <v-list-tile v-for="(mode, mimetype) in mimeTypes"  :key="mimetype">
                <v-list-tile-title v-text="mimetype" @click="setMode(mimetype)"></v-list-tile-title>
              </v-list-tile>           
          </v-list>         
   </v-menu>
   
  <v-tooltip top>
     <v-chip   @click="acecmd('goToNextError')" slot="activator" >
          <v-avatar  class="green ">{{annotations && annotations.info}}</v-avatar>
          <v-avatar  class="yellow ">{{annotations && annotations.warning}}</v-avatar>        
          <v-avatar   class="red " small>{{annotations && annotations.error}}</v-avatar>    
           <v-avatar>
              <v-icon black >navigate_next</v-icon>
           </v-avatar>
      </v-chip>
      <span>Annotations: Errors,Warning and Info</span>
   </v-tooltip>
<v-spacer></v-spacer>
   <v-btn  icon @click="acecmd('outline')" title="outline -todo">
      <v-icon>label_outline</v-icon>
    </v-btn>

  
   <v-btn  icon @click="togglefold" title="fold toggle">
      <v-icon>vertical_align_center</v-icon>
    </v-btn>
    
    <v-btn  icon @click="wrap=!wrap">
      <v-icon>wrap_text</v-icon>
    </v-btn>
    
   
    
    <v-btn  icon @click="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn  icon @click="clearDialog = true">
      <v-icon>delete</v-icon>
    </v-btn>
      
    <v-menu left  transition="v-fade-transition">
      <v-btn  icon slot="activator">
        <v-icon>more_vert</v-icon>
      </v-btn>
     
          <v-list dense>
               <v-list-tile @click="acecmd('showSettingsMenu')" avatar >
               <v-list-tile-avatar>
              <v-icon >settings</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title @click="acecmd('showSettingsMenu')" >Show ACE settings</v-list-tile-title>
            </v-list-tile>
                      
            <v-list-tile @click="acecmd('showKeyboardShortcuts')" avatar>
              <v-list-tile-avatar>
              <v-icon >keyboard</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title  @click="acecmd('showKeyboardShortcuts')" >Show ACE keyboard shortcuts</v-list-tile-title>
            </v-list-tile>          
          </v-list>
          
      </v-menu>
    
     
 </v-toolbar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>

<v-card-text v-if="!busy">
<v-flex xs12 style="height:70vh"  fill-height>
  
    <vue-ace  :content="contentA" :mode="mode" :wrap="wrap"  :settings="aceSettings"
    :events="events" v-resize="onResize"
v-on:change-content="changeContentA" 
v-on:annotation="annotation"></vue-ace>
 </v-flex> 
</v-card-text>
</v-card>
 <qd-confirm v-model="clearDialog" @confirm="reset">Delete all edit text?</qd-confirm>
 </v-container>
</template>

<script>{
  data () {
    return {
      contentA: `declare function local:query($q as xs:string)
{ <json type="object"/> 
};`,
      mode: 'xquery',
      url: '',
      protocol: 'webfile',
      name: '',
      path: [],
      mimetype: "",
      wrap: false,
      busy: false,
      clearDialog: false,
      annotations: null,
      dirty: false,
      snackbar: false,
      message: "Cant do that",
      events:  new Vue({}),
      folded: false, // toggle fold/unfold action
      aceSettings: { },
      mimeTypes:MimeTypes
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
      var a=url.split("/")
      this.url=url
      this.name=a.pop()
      this.path=a
      HTTP.get("edit",{params: {url:url,protocol:this.protocol}})
      .then(r=>{
        //console.log(r)
        this.setMode(r.data.mimetype)
        this.contentA=r.data.data
       
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
    togglefold(){
      this.folded=!this.folded
      this.acecmd(this.folded?"foldall":"unfoldall")
    },
    acecmd(cmd){
      //alert("acecmd: "+cmd)
      this.events.$emit('eventFired',cmd);
    },
    fold(){
      this.events.$emit('eventFired',"foldall");
    },
    save(){
      alert("TODO save: "+this.url);
      var data= {
            protocol:this.protocol,
            url: this.url, //gave the values directly for testing
            data: this.contentA
            }
      HTTP.post("edit", Qs.stringify(data),{
  headers: { "Content-Type": "application/x-www-form-urlencoded"}
      }).then(r=>{
        alert("AAA")
      })
    },
    showfiles(){
          var target=this.protocol="xmldb"?"database":"files";
           router.push({ path: target, query: { url: this.path.join("/"),protocol:this.protocol }})
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
      //console.log("annotations: ",counts)
    },
    setMode(mimetype){
      this.mimetype=mimetype
      var r=MimeTypes[mimetype]
      this.mode=r?r:"text"
    },
    onResize(){
      var h=window.innerHeight
      console.log("height:",h)
    },
    leaving(event) {
      event.returnValue = "event seems to need to be set";
      //debugger;
      console.log("Leaving...");
      if(this.dirty)event.preventDefault();
  }
  },
  computed:{
    icon(){
      return (this.protocol=="xmldb")?"account_balance":"folder"
    }
  },
  created(){
    //https://forum.vuejs.org/t/detect-browser-close/5001/3 @fixme
    document.addEventListener('beforeunload', this.leaving);
  this.protocol=this.$route.query.protocol?this.$route.query.protocol:this.protocol
    var url=this.$route.query.url
    if(url) this.fetch(url)
  },
  beforeRouteEnter (to, from, next) {
    settings.getItem('settings/ace')
    .then( v =>{
      next(vm => {vm.aceSettings = v;})
        })
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
