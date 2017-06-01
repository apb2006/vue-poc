// generated 2017-06-01T12:41:01.376+01:00
const Edit=Vue.extend({
  template: `
<v-container fluid="">
 <v-layout row="" wrap="">
<v-flex xs12="">
<v-toolbar class="green">
  <v-toolbar-title>
    <v-btn @click.native="showfiles()" small="" icon=""><v-icon>folder</v-icon></v-btn>
<span>{{ name }}</span> <v-chip small="" class="primary white--text">{{ mode }}</v-chip>
   {{dirty}}
  </v-toolbar-title>
  <v-toolbar-items>
   <v-btn dark="" icon="" @click.native="acecmd('outline')">
      <v-icon>star</v-icon>
    </v-btn>
  <v-btn dark="" icon="" @click.native="acecmd('goToPreviousError')">
      <v-icon>navigate_before</v-icon>
    </v-btn>
<v-btn dark="" icon="" @click.native="acecmd('goToNextError')">
      <v-icon>navigate_next</v-icon>
    </v-btn>
   <v-btn dark="" icon="" @click.native="acecmd('foldall')">
      <v-icon>vertical_align_center</v-icon>
    </v-btn>
 <v-btn dark="" icon="" @click.native="acecmd('showSettingsMenu')">
      <v-icon>settings</v-icon>
    </v-btn>
<v-btn dark="" icon="" @click.native="wrap=!wrap">
      <v-icon>wrap_text</v-icon>
    </v-btn>
<v-btn dark="" icon="" @click.native="acecmd('showKeyboardShortcuts')">
      <v-icon>keyboard</v-icon>
    </v-btn>
   <v-btn dark="" icon="" @click.native="save()">
      <v-icon>file_upload</v-icon>
    </v-btn>
    <v-btn dark="" icon="" @click.native="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn dark="" icon="" @click.native="clearDialog = true">
      <v-icon>delete</v-icon>
    </v-btn>
    <v-menu bottom="" origin="top right" transition="v-scale-transition">
      <v-btn dark="" icon="" slot="activator">
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
                <v-list-tile-title @click="fetch('/vue-poc/data/vue-poc/ch4d1.xml')">load xml</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title @click="fetch('/vue-poc/static/app.js')">load js</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
          <v-list-item>
              <v-list-tile>
                <v-list-tile-title @click="fetch('/vue-poc/static/app.html')">load html</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
          </v-list>
      </v-menu>
    </v-toolbar-items>
        </v-toolbar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
   <v-dialog v-model="clearDialog">
  <v-card>
    <v-card-row>
      <v-card-title>Clear?</v-card-title>
    </v-card-row>
    <v-card-row>
      <v-card-text>clear text.</v-card-text>
    </v-card-row>
    <v-card-row actions="">
      <v-btn class="green--text darken-1" flat="flat" @click.native="reset(false)">Cancel</v-btn>
      <v-btn class="green--text darken-1" flat="flat" @click.native="reset(true)">Ok</v-btn>
    </v-card-row>
  </v-card>
</v-dialog>
</v-flex>
<v-flex xs12="" style="height:70vh" v-if="!busy" fill-height="">
  
    <vue-ace editor-id="editorA" :content="contentA" :mode="mode" :wrap="wrap" v-on:change-content="changeContentA" v-on:annotation="annotation"></vue-ace>
  
  </v-flex>
</v-layout>

 </v-container>
`,
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

);
const Files=Vue.extend({
  template: `
 <v-container fluid="">

<v-card>
  <v-toolbar class="green">
<v-menu offset-y="">
  <v-btn primary="" icon="" dark="" slot="activator"><v-icon>folder</v-icon></v-btn>
  <v-list>
    <v-list-item v-for="item in crumbs" :key="item">
      <v-list-tile>
        <v-list-tile-title @click="root()">{{ item }}</v-list-tile-title>
      </v-list-tile>
    </v-list-item>
  </v-list>
</v-menu>
    <v-toolbar-title>{{ url }}</v-toolbar-title>
    <v-spacer></v-spacer>
      <v-text-field prepend-icon="search" label="Filter..." v-model="q" type="search" hide-details="" single-line="" dark="" @keyup.native.enter="filter"></v-text-field>
    <v-icon>view_module</v-icon>
  </v-toolbar>
  <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
  <v-list v-if="!busy" two-line="" subheader="">
    <v-subheader inset="">Folders</v-subheader>
    <v-list-item v-for="item in folders" v-bind:key="item.name">
      <v-list-tile avatar="">
        <v-list-tile-avatar @click="folder(item.name)">
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content @click="folder(item.name)">
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>modified: {{ item.modified }} size: {{ item.size }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon="" ripple="" @click.native="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </v-list-item>
    <v-divider inset=""></v-divider>
    <v-subheader inset="">Files</v-subheader>
    <v-list-item v-for="item in files" v-bind:key="item.name">
      <v-list-tile>
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title @click="file(item.name)">{{ item.name }}</v-list-tile-title>
           <v-list-tile-sub-title>modified: {{ item.modified }} size: {{ item.size }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon="" ripple="">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </v-list-item>
  </v-list>
</v-card>
 </v-container>
`,
  data:  function(){
    return { 
            crumbs:[],
            folders:[],
            files:[],
            items:["root"],
            q:"",
            busy:false
    }
  },
  methods:{
    file (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/"+val  }})
    },
    folder (val) {
      this.crumbs.push(val )
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    },
    load(url){
      this.busy=true
      HTTP.get("file?url="+url,axios_json)
      .then(r=>{
        console.log(r)
        this.folders=r.data.folders
        this.files=r.data.files
        this.busy=false
        })
        .catch(error=> {
          console.log(error);
          this.busy=false
          alert("Get query error"+url)
        });
      
    },
    root(){
      this.crumbs=[]
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    },
    filter(){
      console.log("TODO")
    },
    info(){
      alert("info")
    }
  },
  computed: {
    url:  {
      get: function () {
      return  '/'+ this.crumbs.join("/") ;  
    },
    set: function(newValue){
     // alert("set"+newValue)
     this.crumbs=newValue.split("/").filter((a)=>a.length>0)
    }
      }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:"/";
    console.log("files: ",this.$route.query.url)
    this.load(this.url)
  }
}

);
const Home=Vue.extend({
  template: `
<v-layout class="ma-5">
<v-flex xs4="">
<v-card hover="" raised="">
  <v-card-row height="200px" class="pa-5 green lighten-1">
    <div class="display-1 white--text text-xs-center">VUE-POC</div>
    v0.0.1
  </v-card-row>
</v-card>
</v-flex>
<v-flex xs4="">
  <p>This is a experiment in using <code>vue.js</code>.</p>
  <ul>
  <li><a href="https://vuetifyjs.com/" target="new">vuetifyjs</a></li>
  <li><a href="https://github.com/monterail/vue-multiselect">vue-multiselect</a></li>
<li><a href="https://github.com/sagalbot/vue-select"><s>vue-select</s></a></li>
<li><a href="https://github.com/beautify-web/js-beautify">js-beautify</a></li>

  </ul>
</v-flex>
<v-btn floating="floating">
  <v-icon>add</v-icon>
</v-btn>
 <my-component>REPLACED</my-component>
</v-layout>
`}

);
const Login=Vue.extend({
  template: `
<v-card class="grey lighten-4 elevation-0">
    <v-card-row class="green darken-1">
      <v-card-title>
        <span class="white--text">Login</span>
      </v-card-title>
    </v-card-row>
   
     <v-card-row>
      <v-text-field name="input-name" label="Enter your name" hint="name??" v-model="name" required=""></v-text-field>
     </v-card-row>
  
    <v-card-row>    
         <v-text-field name="input-password" label="Enter your password" hint="Enter your password" v-model="password" :append-icon="e1 ? 'visibility' : 'visibility_off'" :append-icon-cb="() => (e1 = !e1)" :type="e1 ? 'password' : 'text'" required=""></v-text-field>      
    </v-card-row>
        
    <v-divider></v-divider>
    <v-card-row actions="" class="blue-grey darken-1 mt-0">
       <v-btn primary="" @click.native="go()">Continue</v-btn>
       <v-spacer></v-spacer>
    </v-card-row>
</v-card>
`,
    data () {
      return {
        e1: true,
        name:'',
        password: ''
      }
    },
    methods:{
      go () {
        alert("not yet")
      }
    }
  }

);
const Options=Vue.extend({  
  template: `
<v-layout>
<v-flex xs2="">
<v-card class="blue darken-4 white--text">
  <v-card-row height="200px">
    <v-card-title>
      Featured Event: <br>
      May 24, 2016 <br>
      7-11pm
    </v-card-title>
  </v-card-row>
 <v-card-row actions="">
    <v-btn flat="" class="white--text" @click.native="snackbar = true">Add to <br>Calendar</v-btn>
    <v-spacer></v-spacer>
    <v-btn icon="" dark="" @click.native="snackbar = true">
      <v-icon>event</v-icon>
    </v-btn>
  </v-card-row>
</v-card>
</v-flex>

<v-flex xs6="">
       <v-text-field name="url" label="Image location" :required="true" :full-width="false"></v-text-field>
</v-flex>

<v-flex xs4="">
   <v-card-row img="music.jpg" height="300px"></v-card-row>
  <v-btn block="" primary="" @click.native="snackbar = true" dark="">Show Snackbar</v-btn>
 <v-btn class="white--text" @click.native="snackbar = true">Snackbar?</v-btn>
</v-flex>
<v-snackbar v-model="snackbar">
    Hello, I'm a snackbar
    <v-btn flat="" class="pink--text" @click.native="snackbar = false">
         <v-icon>highlight_off</v-icon>
    </v-btn>
  </v-snackbar>
  </v-layout>
`,
  data: function(){
    return {
        snackbar:false
    }
  }
    }

);
const People=Vue.extend({
  template: `
 <v-container fluid="">
  <v-layout>Look at all the people who work here!
  <v-btn light="" default="" v-on:click.native="reverseMessage">Reverse Message</v-btn>
  <p>{{ message }}</p>
 
  </v-layout>
  <v-layout>
  <v-flex xs5="">
   <v-card-row img="music.jpg" height="300px"></v-card-row>
  </v-flex>
  <v-flex xs5="">
  <v-card-row img="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" height="300px"></v-card-row>
  </v-flex>
  </v-layout>
 </v-container>
`,
  data:  function(){
    return {message: 'Hello Vue.js!'}
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
}


);
const Search=Vue.extend({
  template: `
 <v-container fluid="">
 <v-text-field label="Search..." v-model="q"></v-text-field>
 </v-container>
`,
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      q:this.$route.query.q
      }
  },
  created:function(){
    console.log("Serch",this.$route.query.q)
  }
}

);
const Select=Vue.extend({
  template: `
 <v-container fluid="">
<v-card>
  <v-card-row class="green darken-1">
    <v-card-title>
      <span class="white--text">Selection</span>
      
    </v-card-title>
  </v-card-row>
  <v-card-text>
    <v-layout>
     
    <v-flex xs6="">
    <p>some text</p>
    <multiselect v-model="value" :options="options" @search-change="asyncFind" :loading="isLoading" placeholder="select one"></multiselect>
    <pre>{{$data.value }}</pre>
    </v-flex>

    <v-flex xs6="">
    <p>multi select</p>
    <multiselect v-model="value2" :options="options" multiple="" placeholder="Select many"></multiselect>
    <pre>{{$data.value2 }}</pre>
    </v-flex>
   </v-layout>
</v-card-text>
<v-card>
 </v-card></v-card></v-container>
`,
  components: { multiselect: VueMultiselect.Multiselect}, 
  data: function(){
      return {
          value: null,
          value2: null,
          options: [],
          isLoading: false
      }
    },
    created:function(){
      this.asyncFind("")
    },
    methods: {
      asyncFind: function(query){
        this.isLoading = true
        that=this;
        HTTP.get("test-select?q="+query,axios_json)
        .then(function(r){
          that.isLoading = false
          that.options=r.data.items;
          })
          .catch(function (error) {
            console.log(error);
            this.isLoading = false
            alert("Get query error")
          });
        }
      }
}


);
const Stepper=Vue.extend({
  template: `
 <v-container fluid="">
 <v-stepper v-model="e6" vertical="">
  <v-stepper-step step="1" v-bind:complete="e6 > 1">
    Select an image location
    <small>http or server file</small>
  </v-stepper-step>
  <v-stepper-content step="1">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    url
    </v-card>
    <v-btn primary="" @click.native="e6 = 2">Continue</v-btn>
    <v-btn flat="">Cancel</v-btn>
  </v-stepper-content>
  <v-stepper-step step="2" v-bind:complete="e6 > 2">Configure analytics for this app</v-stepper-step>
  <v-stepper-content step="2">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    <v-btn primary="" @click.native="e6 = 3">Continue</v-btn>
    <v-btn flat="" @click.native="e6 -= 1">Back</v-btn>
  </v-card></v-stepper-content>
  <v-stepper-step step="3">Select an ad format and name ad unit</v-stepper-step>
  <v-stepper-content step="3">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    <v-btn primary="" @click.native="e6 = 4">Continue</v-btn>
     <v-btn flat="" @click.native="e6 -= 1">Back</v-btn>
  </v-card></v-stepper-content>
  <v-stepper-step step="4">View setup instructions</v-stepper-step>
  <v-stepper-content step="4">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    <v-btn primary="" @click.native="e6 = 1">Continue</v-btn>
     <v-btn flat="" @click.native="e6 -= 1">Back</v-btn>
  </v-card></v-stepper-content>
</v-stepper>
 </v-container>
`,
  data:  function(){
    return {e6: 0}
  }
}

);
const Tabs=Vue.extend({
  template: `
  <v-tabs id="mobile-tabs-6" scroll-bars="" light="">
    <v-card class="primary white--text">
      <v-card-text>
        <v-card-row>
          <v-btn icon="" light="">
            <v-icon>menu</v-icon>
          </v-btn>
          <v-card-title>Page Title</v-card-title>
          <v-btn icon="" light="">
            <v-icon>search</v-icon>
          </v-btn>
          <v-btn icon="" light="">
            <v-icon>more_vert</v-icon>
          </v-btn>
        </v-card-row>
      </v-card-text>
    </v-card>
    <v-tabs-bar slot="activators">
      <v-tabs-slider></v-tabs-slider>
      <v-tabs-item v-for="i in 13" :key="i" :href="'#mobile-tabs-6-' + i">
       Item {{ i }}
        <v-btn icon="" class="pink--text">
              <v-icon>favorite</v-icon>
            </v-btn>
      </v-tabs-item>
    </v-tabs-bar>
    <v-tabs-content v-for="i in 13" :key="i" :id="'mobile-tabs-6-' + i">
      <v-card flat="">
        <v-card-text>{{ text }}</v-card-text>
      </v-card>
    </v-tabs-content>
</v-tabs>
`,
    data () {
      return {
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
      }
    }
  }

);
// base -----------------------
const HTTP = axios.create({
  baseURL: "/vue-poc/api/",
  headers: {
    'X-Custom-Header': 'vue-poc',
    accept: 'application/json'
  }
});
const axios_json={ headers: {accept: 'application/json'}};

Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
  console.error(err, vm, info);
  alert("vue error");
};
Vue.component('my-component', {
  template: '<div>A custom <v-chip>component!</v-chip></div>',
    created:function(){
      console.log("my-component");
    },  
});

var Events = new Vue({});


const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  routes: [
    { path: '/', component: Home },
    { path: '/people', component: People ,meta:{title:"People"}},
    { path: '/options', component: Options,meta:{title:"Options"} },
    { path: '/select', component: Select,meta:{title:"Select"} },
    { path: '/search', component: Search,meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test"} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/stepper', component: Stepper,meta:{title:"Stepper"} },
    { path: '/files', component: Files,meta:{title:"Files"} } 
  ],
});
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

Vue.use(Vuetify);
const app = new Vue({
  router,
  data:function(){return {
    q:"",
    user:{},
    drawer:true,
    title:"my title",
    mini: false,
    items: [{
      href: '/',
      router: true,
      title: 'Home',
      icon: 'home'    
    }, {
      href: 'files',
      router: true,
      title: 'files',
      icon: 'folder' 
    }, {
      href: 'edit',
      router: true,
      title: 'edit',
      icon: 'mode_edit'    
    }, {
      href: 'search',
      router: true,
      title: 'search',
      icon: 'search'
  }, {
      href: 'people',
      router: true,
      title: 'People',
      icon: 'person'      
   }, {
      href: 'select',
      router: true,
      title: 'select',
      icon: 'extension'
  }, {
      href: 'options',
      router: true,
      title: 'options',
      icon: 'domain'
  }, {
    href: 'tabs',
    router: true,
    title: 'tabs',
    icon: 'switch_camera'
  }, {
    href: 'login',
    router: true,
    title: 'login',
    icon: 'account_balance' 
}, {
  href: 'stepper',
  router: true,
  title: 'stepper',
  icon: 'touch_app'
}]
  
  }},
  methods: {
      
      search(){
        this.$router.push({path: 'search',query: { q: this.q }})
      }
  }
  }).$mount('#app');
