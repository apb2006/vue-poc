<!DOCTYPE html>
<template id="edit">
<v-container fluid >
      <v-snackbar top color="error"  v-model="snackbar">
      {{ message }}
      <v-btn text  @click="snackbar = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-snackbar>
    
<v-card>
<v-toolbar dense>
<v-tooltip top >
 <template v-slot:activator="{ on }">
  <v-menu v-on="on">
  <template v-slot:activator="{ on }">
      <v-btn color="primary" icon  v-on="on"><v-icon >{{icon}}</v-icon></v-btn>
  </template>
  <v-list>
      <v-list-item  v-for="(item,index) in path" :key="index">
        <v-list-item-content @click="showfiles()">
        <v-list-item-title >{{ item }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
  </v-list>
  </v-menu>
  </template>
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
	   <template v-slot:activator="{ on }">
	      <v-chip label small v-on="on" >{{ mode }}</v-chip>  
	    </template>
          <v-list dense>
              <v-list-item v-for="type in $MimeTypes.list()"  :key="type.name">
                <v-list-item-title v-text="type.name" @click="setMode(type)"></v-list-item-title>
              </v-list-item>           
          </v-list>         
   </v-menu>
   
  <v-tooltip top>
   <template v-slot:activator="{ on }">
     <v-chip   @click="acecmd('goToNextError')" v-on="on" >
            <span   class="red " >{{annotations && annotations.error}}</span>
            <span  class="yellow ">{{annotations && annotations.warning}}</span>   
            <span  class="green ">{{annotations && annotations.info}}</span>
 
           <v-avatar>
              <v-icon black >navigate_next</v-icon>
           </v-avatar>
      </v-chip>
      </template>
      <span>Annotations: Errors,Warning and Info</span>
   </v-tooltip>
<v-spacer></v-spacer>
   <v-btn  icon @click="acecmd('outline')" title="outline -todo">
      <v-icon>label_outline</v-icon>
    </v-btn>

  <v-menu left  transition="v-fade-transition">
    <template v-slot:activator="{ on }">
      <v-btn  icon v-on="on" title="display settings">
        <v-icon>playlist_play</v-icon>
      </v-btn>
     </template>
      <v-list dense>
           <v-subheader>Display settings</v-subheader>
         
           <v-list-item @click="togglefold"  >
             <v-list-item-avatar>
                   <v-icon >vertical_align_center</v-icon>
              </v-list-item-avatar>
              <v-list-item-title  >Toggle folds</v-list-item-title>
           </v-list-item>
           
           <v-list-item @click="wrap=!wrap"   >
             <v-list-item-avatar>
                   <v-icon >wrap_text</v-icon>
              </v-list-item-avatar>
              <v-list-item-title  >Soft wrap</v-list-item-title>
           </v-list-item>
             <v-divider></v-divider>
              <v-subheader>Help</v-subheader>
             <v-list-item @click="acecmd('showSettingsMenu')"  >
               <v-list-item-avatar>
              <v-icon >settings</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showSettingsMenu')" >Show ACE settings</v-list-item-title>
            </v-list-item>
                      
            <v-list-item @click="acecmd('showKeyboardShortcuts')">
              <v-list-item-avatar>
              <v-icon >keyboard</v-icon>
            </v-list-item-avatar>
              <v-list-item-title  @click="acecmd('showKeyboardShortcuts')" >Show ACE keyboard shortcuts</v-list-item-title>
            </v-list-item>          
      </v-list>
    </v-menu>
    
    <v-btn  icon @click="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn  icon @click="clearDialog = true">
      <v-icon>delete</v-icon>
    </v-btn>
      
    <v-menu left  transition="v-fade-transition">
      <template v-slot:activator="{ on }">
      <v-btn  icon v-on="on">
        <v-icon>more_vert</v-icon>
      </v-btn>
     </template>
          <v-list dense>
               <v-list-item @click="acecmd('showSettingsMenu')"  >
               <v-list-item-avatar>
              <v-icon >settings</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showSettingsMenu')" >Show ACE settings</v-list-item-title>
            </v-list-item>
                      
            <v-list-item @click="acecmd('showKeyboardShortcuts')">
              <v-list-item-avatar>
              <v-icon >keyboard</v-icon>
            </v-list-item-avatar>
              <v-list-item-title  @click="acecmd('showKeyboardShortcuts')" >Show ACE keyboard shortcuts</v-list-item-title>
            </v-list-item>          
          </v-list>
          
      </v-menu>
    
     
 </v-toolbar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>

<v-card-text v-if="!busy">
	<v-flex xs12 style="height:70vh"  fill-height>
	    <vue-ace  :content="contentA" :mode="mode" :wrap="wrap"  :settings="aceSettings"
	    :events="events" v-resize="onResize"   :completer="$aceExtras.basexCompleter" :snippets="$aceExtras.snippets"
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
      aceSettings: { }
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
      HTTP.get("edit",{params: {url:url}})
      .then(r=>{
        //console.log(r)
        this.mimetype=r.data.mimetype
        this.mode= this.$MimeTypes.modeForMime(this.mimetype)
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
    setMode(type){
      this.mimetype=type.name
      var r=type.mode
      this.mode=r?r:"text"
    },
    leaving(event) {
      event.returnValue = "event seems to need to be set";
      //debugger;
      console.log("Leaving...");
      if(this.dirty)event.preventDefault();
    },
    onResize(){
        var h=window.innerHeight
        //console.log("height:",h)
      }
  },
  
  computed:{
	 protocol(){
	      return this.url.split(':').shift()
	 }, 
    icon(){
      return (this.protocol=="xmldb")?"account_balance":"folder"
    }
  },
     
  created(){
    //https://forum.vuejs.org/t/detect-browser-close/5001/3 @fixme
    document.addEventListener('beforeunload', this.leaving);
    console.log("basexlogdate1 query: ",this.$route.url)
    var url=this.$route.query.url
    if(url) this.fetch(url)
  },
  
  beforeRouteEnter (to, from, next) {
    Settings.getItem('settings/ace')
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
