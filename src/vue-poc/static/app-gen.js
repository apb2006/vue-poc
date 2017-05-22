const Edit=Vue.extend({
  template: `
<v-container fluid="">
 <v-layout row="" wrap="">
<v-flex xs12="">
<v-toolbar class="green">
  <v-toolbar-title>
    <v-btn @click.native="showfiles()" small="" icon=""><v-icon>folder</v-icon></v-btn>
<span>{{ name }}</span> <v-chip small="" class="primary white--text">{{ mode }}</v-chip>
 
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
      <v-icon>cloud_upload</v-icon>
    </v-btn>
    <v-btn dark="" icon="" @click.native="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn dark="" icon="" @click.native="d2 = true">
      <v-icon>delete</v-icon>
    </v-btn>
    <v-menu bottom="" origin="top right" transition="v-scale-transition">
      <v-btn dark="" icon="" slot="activator">
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
                <v-list-tile-title @click="fetch('vue-poc/data/vue-poc/ch4d1.xml')">load xml</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title @click="fetch('vue-poc/static/app.js')">load js</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
          <v-list-item>
              <v-list-tile>
                <v-list-tile-title @click="fetch('vue-poc/static/app.html')">load html</v-list-tile-title>
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
      <v-btn class="green--text darken-1" flat="flat" @click.native="clearDialog = false">Cancel</v-btn>
      <v-btn class="green--text darken-1" flat="flat" @click.native="reset()">Ok</v-btn>
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

);
const Files=Vue.extend({
  template: `
 <v-container fluid="">

<v-card>
  <v-toolbar class="green">
<v-menu offset-y="">
  <v-btn primary="" icon="" dark="" slot="activator"><v-icon>folder</v-icon></v-btn>
  <v-list>
    <v-list-item v-for="item in items" :key="item">
      <v-list-tile>
        <v-list-tile-title @click="root()">{{ item }}</v-list-tile-title>
      </v-list-tile>
    </v-list-item>
  </v-list>
</v-menu>
    <v-toolbar-title>URL: <v-chip class="primary white--text" @click="root()">{{ url }}</v-chip></v-toolbar-title>
    <v-spacer></v-spacer>
    <v-icon class="mr-4">search</v-icon>
    <v-icon>view_module</v-icon>
  </v-toolbar>
  <v-list two-line="" subheader="">
    <v-subheader inset="">Folders</v-subheader>
    <v-list-item v-for="item in folders" v-bind:key="item.name">
      <v-list-tile avatar="">
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title @dblclick="folder(item.name)">{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>{{ item.subtitle }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon="" ripple="">
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
          <v-list-tile-title @dblclick="click(item.name)">{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>{{ item.subtitle }}</v-list-tile-sub-title>
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
    return {url: ".",
            folders:[],
            files:[],
            items:["root"]
    }
  },
  methods:{
    click (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/" +val }})
    },
    folder (val) {
      this.url+="/"+ val
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    },
    load(url){
      HTTP.get("file?url="+url,axios_json)
      .then(r=>{
        console.log(r)
        this.folders=r.data.folders
        this.files=r.data.files
        })
        .catch(error=> {
          console.log(error);
          alert("Get query error"+url)
        });
      
    },
    root(){
      this.url="."
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:".";
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
    <v-card-row> 
    <v-col xs6="">
    <p>some text</p>
    <multiselect v-model="value" :options="options" @search-change="asyncFind" :loading="isLoading" placeholder="select one"></multiselect>
    <pre>{{$data.value }}</pre>
    </v-col>

    <v-col xs6="">
    <p>multi select</p>
    <multiselect v-model="value2" :options="options" multiple="" placeholder="Select many"></multiselect>
    <pre>{{$data.value2 }}</pre>
    </v-col>
   </v-card-row>
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
// base -----------------------
const HTTP = axios.create({
  baseURL: "/vue-poc/api/",
  headers: {
    'X-Custom-Header': 'vue-poc',
    accept: 'application/json'
  }
});
const axios_json={ headers: {accept: 'application/json'}};


function acetype(mime){
  const mimemap={
      "text/xml":"xml",
      "application/xml":"xml",
      "application/xquery":"xquery",
      "text/ecmascript":"javascript",
      "text/html":"html"
  };
  var r=mimemap[mime]
  return r?r:"text"
};

Vue.component('my-component', {
  template: '<div>A custom component!</div>',
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
    drawer:true,
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
  href: 'stepper',
  router: true,
  title: 'stepper',
  icon: 'picture_in_picture'
}]
  }},
  methods: {
      
      search(){
        this.$router.push({path: 'search',query: { q: this.q }})
      }
  }
  }).$mount('#app');
