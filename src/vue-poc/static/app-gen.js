// generated 2017-06-21T16:59:58.292+01:00
/**
 * vue filters
 */

//Define the date time format filter
Vue.filter("formatDate", function(date) {
    return moment(date).format("MMMM D, YYYY")
});

Vue.filter('readablizeBytes', function (bytes,decimals) {
  if(bytes == 0) return '0 Bytes';
  var k = 1000,
      dm = decimals || 2,
      sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
      i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
});
Vue.filter("any", function(any) {
  return "ANY"
});
/**
 * Vue filter to round the decimal to the given place.
 * http://jsfiddle.net/bryan_k/3ova17y9/
 *
 * @param {String} value    The value string.
 * @param {Number} decimals The number of decimal places.
 */
Vue.filter('round', function(value, decimals) {
  if(!value) {
    value = 0;
  }

  if(!decimals) {
    decimals = 0;
  }

  value = Math.round(value * Math.pow(10, decimals)) / Math.pow(10, decimals);
  return value;
});const Notfound=Vue.extend({template:` 
 <v-container fluid="">
 Not found
 </v-container>
 `,

  data:  function(){
    return {
      message: 'bad route!'
      }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}

);
const Edit=Vue.extend({template:` 
<v-container fluid="">
      <v-snackbar top="" error="" v-model="snackbar">
      {{ message }}
      <v-btn flat="" @click.native="snackbar = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-snackbar>
<v-card>

 <v-app-bar>
<v-menu offset-y="">
  <v-btn primary="" icon="" dark="" slot="activator" v-tooltip:top="{ html: path.join('/') }"><v-icon>folder</v-icon></v-btn>
  <v-list>
    <v-list-item v-for="item in path" :key="item">
      <v-list-tile>
        <v-list-tile-title @click="showfiles()">{{ item }}</v-list-tile-title>
      </v-list-tile>
    </v-list-item>
  </v-list>
</v-menu>

  <v-toolbar-title>
      <span>{{ name }}</span>
  </v-toolbar-title>
  <v-toolbar-items>
  <span v-tooltip:top="{ html: 'Change' }">
  <v-chip v-if="dirty" label="" small="" class="red white--text">*</v-chip>
<v-chip v-if="!dirty" label="" small="" class="green white--text">.</v-chip>
</span>
 <v-chip small="" v-tooltip:top="{ html: mimetype }">{{ mode }}</v-chip>
     <v-chip @click.native="acecmd('goToNextError')" v-tooltip:top="{ html: 'Annotations: Errors,Warning and Info' }">
          <v-avatar class="green ">{{annotations &amp;&amp; annotations.info}}</v-avatar>
          <v-avatar class="yellow ">{{annotations &amp;&amp; annotations.warning}}</v-avatar>        
          <v-avatar class="red " small="">{{annotations &amp;&amp; annotations.error}}</v-avatar>    
           <v-avatar>
              <v-icon black="">navigate_next</v-icon>
           </v-avatar>
          </v-chip>
   <v-btn dark="" icon="" @click.native="acecmd('outline')">
      <v-icon>star</v-icon>
    </v-btn>

  
   <v-btn dark="" icon="" @click.native="acecmd('foldall')">
      <v-icon>vertical_align_center</v-icon>
    </v-btn>
    
    <v-btn dark="" icon="" @click.native="wrap=!wrap">
      <v-icon>wrap_text</v-icon>
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
        <v-menu left="" transition="v-fade-transition">
        <v-btn dark="" icon="" slot="activator">
          <v-icon>help</v-icon>
        </v-btn>     
        <v-list>
          <v-list-item @click="acecmd('showSettingsMenu')">
            <v-list-tile avatar="">
               <v-list-tile-avatar>
              <v-icon>settings</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title>Show settings</v-list-tile-title>
            </v-list-tile>
          </v-list-item>
          
          <v-list-item @click="acecmd('showKeyboardShortcuts')">            
            <v-list-tile avatar="">
              <v-list-tile-avatar>
              <v-icon>keyboard</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title>Show keyboard commands</v-list-tile-title>
            </v-list-tile>
          </v-list-item>
          </v-list>
       </v-menu>
    <v-menu left="" transition="v-fade-transition">
      <v-btn dark="" icon="" slot="activator">
        <v-icon>more_vert</v-icon>
      </v-btn>
     
          <v-list>
            <v-list-item>
              <v-list-tile>
                <v-list-tile-title>unused</v-list-tile-title>
              </v-list-tile>
            </v-list-item>
            
          </v-list>
      </v-menu>
    </v-toolbar-items>
 </v-app-bar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>


<v-flex xs12="" style="height:70vh" v-if="!busy" fill-height="">
  
    <vue-ace editor-id="editorA" :content="contentA" :mode="mode" :wrap="wrap" v-on:change-content="changeContentA" v-on:annotation="annotation"></vue-ace>
  
 <v-dialog v-model="clearDialog">
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
  </v-dialog></v-flex></v-card>


  
 </v-container>
 `,

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
          "text/css":"css"
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

);
const Eval=Vue.extend({template:` 
 <v-container fluid="">
  <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
  <vue-ace editor-id="editorA" :content="xq" mode="xquery" wrap="true" v-on:change-content="onChange"></vue-ace>
    </v-card>
 </v-container>
 `,

  data:  function(){
    return {
      xq: '(:~ do something :)'
      }
  },
  methods:{
    onChange(){
      console.log("go")
    }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}

);
const Files=Vue.extend({template:` 
 <v-container fluid="">

<v-card>
  <v-app-bar>
		<v-menu offset-y="">
		  <v-btn icon="" dark="" slot="activator"><v-icon>folder</v-icon></v-btn>
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
  </v-app-bar>
  
  <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
  <v-list v-if="!busy" two-line="" subheader="">
    <v-subheader inset="">Folders</v-subheader>
    <v-list-item v-for="item in folders" v-bind:key="item.name" @click="folder(item.name)">
      <v-list-tile avatar="">
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>modified: {{ item.modified | formatDate}} size: {{ item.size | readablizeBytes}}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon="" ripple="" @click.native.stop="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </v-list-item>
    <v-divider inset=""></v-divider>
    <v-subheader inset="">Files</v-subheader>
    <v-list-item v-for="item in files" v-bind:key="item.name" @click="file(item.name)">
      <v-list-tile>
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
           <v-list-tile-sub-title>modified: {{ formatDate(item.modified) }} size: {{ readablizeBytes(item.size) }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon="" ripple="" @click.native.stop="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </v-list-item>
  </v-list>
    <v-navigation-drawer right="" light="" temporary="" v-model="infodraw">Some info here {{selected}}</v-navigation-drawer>
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
            busy:false,
            infodraw:false,
            selected:""
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
    info(sel){
      this.selected=sel
      this.infodraw=true
    },
    readablizeBytes(v){
      return Vue.filter('readablizeBytes')(v)
      },
      formatDate(v){
      return Vue.filter('formatDate')(v)
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
const History=Vue.extend({template:` 
 <v-container fluid="">
 <v-list>
          <v-list-item v-for="item in items" v-bind:key="item.title" @click="doEdit(item.url)">
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-icon v-if="item.icon" class="pink--text">star</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title v-text="item.url"></v-list-tile-title>
              </v-list-tile-content>
              <v-list-tile-avatar>
                <img v-bind:src="item.avatar">
              </v-list-tile-avatar>
            </v-list-tile>
          </v-list-item>
        </v-list>
 </v-container>
 `,

  data:  function(){
    return {
      message: 'Hello Vue.js!',
      items:[]
      }
  },
  methods:{
    get() {
      HTTP.get('history')
      .then((res) => {
        this.items = res.data.items;
        console.log("items",this.items)
      });
    },
    doEdit(url){
      console.log("DD"+url)
        router.push({ path: 'edit', query: { url: url  }})
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}

);
const Home=Vue.extend({template:` 
<v-layout class="ma-5">
<v-flex xs4="">
<v-card hover="" raised="">
  <v-card-row height="200px" class="pa-5 green lighten-1">
    <div class="display-1 white--text text-xs-center">VUE-POC</div>
    v0.0.2
  </v-card-row>
</v-card>
</v-flex>
<v-flex xs4="">
  <p>This is a experiment in using <code>vue.js</code>.</p>
  <ul>
  <li><a href="https://vuetifyjs.com/" target="new">vuetifyjs</a></li>
  <li><a href="https://github.com/monterail/vue-multiselect" target="new">vue-multiselect</a></li>
<li><a href="https://github.com/sagalbot/vue-select" target="new"><s>vue-select</s></a></li>
<li><a href="https://github.com/beautify-web/js-beautify" target="new">js-beautify</a></li>
<li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
<li><a href="/dba" target="new">DBA app</a></li>
  </ul>
</v-flex>
<v-btn floating="floating">
  <v-icon>add</v-icon>
</v-btn>
 <my-component>REPLACED</my-component>
</v-layout>
 `,

}

);
const Login=Vue.extend({template:` 
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
         <v-text-field name="input-password" label="Enter your password" hint="Enter your password" v-model="password" :append-icon="hidepass ? 'visibility' : 'visibility_off'" :append-icon-cb="() => (hidepass = !hidepass)" :type="hidepass ? 'password' : 'text'" required=""></v-text-field>      
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
        hidepass: true,
        name:'',
        password: ''
      }
    },
    methods:{
      go () {
       this.hidepass=true
       var data=Qs.stringify(
           {
             username: this.name, //gave the values directly for testing
             password: this.password,
             client_id: 'user-client'
             })
       HTTP.post("login-check", data,
         {
   headers: { 
     "Content-Type": "application/x-www-form-urlencoded"
   }})
      .then(r=>{
        console.log(r)
        alert("loh")
      }).catch(error=> {
        alert("err")
      })
    }
  }
}

);
const Options=Vue.extend({template:` 
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
const People=Vue.extend({template:` 
 <v-container fluid="">
  <v-layout>Look at all the people who work here!
  <v-btn light="" default="" v-on:click.native="reverseMessage">Reverse Message</v-btn>
  <p>{{ message }}</p>
 
  </v-layout>
  <v-layout>
  <v-flex xs5="">
   <v-card-row img="resources/music.jpg" height="300px"></v-card-row>
  </v-flex>
  <v-flex xs1="">
  <v-card-row img="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" height="60px"></v-card-row>
  </v-flex>
  </v-layout>
 </v-container>
 `,

  data:  function(){
    return {
      message: 'Hello Vue.js!',
      img:"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
      }
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
}


);
const Ping=Vue.extend({template:` 
 <v-container fluid="">
 <p>Simple performance measure. Read or increment a database value.</p>
  <h2>Counter:{{counter}}</h2>
  <table class="table">
      <thead> 
        <tr>
          <th>Option</th>
          <th>Repeat</th>
          <th>Last</th>
          <th>Count</th>
         
          <th>Avg</th>
          
          <th>min</th>
          <th>max</th>
           <th>Median</th>
        </tr>
      </thead>
      <tbody>

      
          <tr>
              <td>
                   <v-btn dark="" @click.native="get()">Get count</v-btn>
               </td>
               <td>
     <v-checkbox v-model="repeat.get" dark=""></v-checkbox>
        </td>    
              <td>
                  <span>{{getValues.last}}</span>
              </td>
              <td>
                  <span>{{getValues.count}}</span>
              </td>   
            
              <td>
                  <span>{{getValues.avg | round(2)}}</span>
              </td>
            
              <td>
                  <span>{{getValues.min}}</span>
              </td>
              <td>
                  <span>{{getValues.max}}</span>
              </td>
                <td>
                  <span>{{getValues.median}}</span>
              </td>
          </tr>
            <tr>
          <td>
             <v-btn dark="" @click.native="update()">Update count</v-btn>
          </td>
          
          <td>
           <v-checkbox v-model="repeat.post" dark=""></v-checkbox>
          </td>
           <td class="col-md-1">
                        <span>{{postValues.last}}</span>
                    </td>
          <td class="col-md-1">
            <span>{{postValues.count}}</span>
          </td>
          <td class="col-md-1">
                        <span>{{postValues.median}}</span>
           </td>
           
          <td class="col-md-1">
            <span>{{postValues.avg | round(2)}}</span>
          </td>
          
         
          <td class="col-md-1">
                        <span>{{postValues.min}}</span>
          </td>
          <td class="col-md-1">
              <span>{{postValues.max}}</span>
          </td>
        </tr>
      </tbody>
    </table>
 </v-container>
 `,

  data:  function(){
    return {
      getValues: new perfStat(),
      postValues: new perfStat(),
      repeat:{get:false,post:false},
      counter:null
      }
  },
  methods:{
    update () {
       var _start = performance.now();
      HTTP.post("ping",axios_json)
      .then(r=>{
        var elapsed=Math.floor(performance.now() - _start);
        this.counter=r.data
        Object.assign(this.postValues,this.postValues.log(elapsed))
        if(this.repeat.post){
          this.update(); //does this leak??
        }
      })
    },
    
    get(){
     var _start = performance.now();
     HTTP.get("ping",axios_json)
     .then(r=>{
       var elapsed=Math.floor(performance.now() - _start);
       this.counter=r.data
       Object.assign(this.getValues,this.getValues.log(elapsed))
       this.$forceUpdate()
        if(this.repeat.get){
          this.get(); //does this leak??
        }
     })
    }
  },
  computed: {
   
  }
}

);
const Puzzle=Vue.extend({template:` 
 <v-container fluid="">
  <a href="http://homepages.cwi.nl/~steven/Talks/2017/06-10-iot/game-demo.html">demo</a>
  <v-layout>
 
  <table>
   <tbody><tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:3em;" @click="click(row,col)">{{cell}}</td>
   </tr>
  </tbody></table>
  </v-layout>
 </v-container>
 `,

  data:  function(){
    return {grid: [
      [1,5,8,12],
      [2,6,9,13],
      [3,7,10,14],
      [4,null,11,15] 
    ],
    empty:[3,1]
    }
  },
  methods: {
    click: function (row,col) {
      var g=this.grid
      var h=g[row][col]
      g[row][col]=null
      g[this.empty[0]][this.empty[1]]=h
      var e=[row,col]
      this.empty=e
      this.grid= g
      console.log("click",this.grid,e)
      this.$forceUpdate()
    }
  }
}


);
const Search=Vue.extend({template:` 
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
const Select=Vue.extend({template:` 
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
const Settings=Vue.extend({template:` 
  <v-layout row="">
    <v-flex xs12="" sm6="" offset-sm3="">
      <v-card>

        <v-list two-line="" subheader="">
          <v-subheader>Ace editor settings</v-subheader>
          <v-list-item>
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableSnippets</v-list-tile-title>
                <v-list-tile-sub-title>Allow snippets</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
          <v-list-item>
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableBasicAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableBasicAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
          <v-list-item>
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableLiveAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableLiveAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
 
        </v-list>
      </v-card>
    </v-flex>
  </v-layout>
 `,

  data () {
    return {
      ace: {
        enableSnippets: true,
        enableBasicAutocompletion: true,
        enableLiveAutocompletion: true
    }
    }
  },
  created: function () {
    // `this` points to the vm instance
    console.log('created: ')
    localforage.getItem('ace').then((value) => {
      console.log('oh say can you see, ' + value);
      this.ace=value || this.ace
    }).catch((err) => {
      console.log('the rockets red glare has blinded me');
    });
  },
  updated: function () {
    // `this` points to the vm instance
    console.log('updated: ')
    localforage.setItem('ace', this.ace).then((value) => {
      console.log('woot! we saved ' + value);
    }).catch((err) => {
      console.log('he\'s dead, jim!');
    });
  },
  methods: {
    reverseMessage: function () {
      alert("unused")
    }
  }
}


);
const Tabs=Vue.extend({template:` 
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
const Thumbnail=Vue.extend({template:` 
 <v-container fluid="">
 <v-stepper v-model="step" non-linear="">
  <v-stepper-header>
      <v-stepper-step step="1" :complete="step > 1">Select image location</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="2" :complete="step > 2">Set thumbnail details</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="3">Result</v-stepper-step>
    </v-stepper-header>
  
  <v-stepper-content step="1" non-linear="">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    <v-text-field name="url" label="Image Url" hint="http:...??" v-model="image" required=""></v-text-field>
    </v-card>
        <v-btn primary="" @click.native="step = 2">Next</v-btn>
  </v-stepper-content>
  
  <v-stepper-content step="2" non-linear="">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    <vue-ace editor-id="editorA" :content="taskxml" mode="xml" wrap="true" v-on:change-content="onChange"></vue-ace>
		</v-card>
   
    <v-btn flat="" @click.native="step -= 1">Back</v-btn>
    <v-btn primary="" @click.native="validate()">Validate</v-btn>
     <v-btn primary="" @click.native="step = 3">Next</v-btn>  
  </v-stepper-content>

  <v-stepper-content step="3" non-linear="">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    output todo
    </v-card>

     <v-btn flat="" @click.native="step -= 1">Back</v-btn>
     <v-btn primary="" @click.native="go()">go</v-btn>
  </v-stepper-content>
</v-stepper>
 </v-container>
 `,

  data(){
    return {
      image:"http://images.metmuseum.org/CRDImages/ep/original/DT46.jpg",
      step: 0,
      taskxml:"<task></task>"
      }
  },
  methods:{
    onChange (val) {
      if (this.taskxml !== val) this.taskxml = val;
      },
    validate(){
        alert
      },
    go(){
        alert("post")
        HTTP.post("thumbnail",Qs.stringify({task: this.taskxml,url:this.image}))
        .then(function(r){
          console.log(r)
       alert("not yet:"+r);
     })
      }
  }

}

);
// base -----------------------
localforage.config({
  name: 'vuepoc'
});
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
    { path: '/', component: Home,meta:{title:"Home"} },
    { path: '/people', component: People ,meta:{title:"People"}},
    { path: '/options', component: Options,meta:{title:"Options"} },
    { path: '/select', component: Select,meta:{title:"Select"} },
    { path: '/search', component: Search,meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/thumbnail', component: Thumbnail,meta:{title:"Thumbnail generator"} },
    { path: '/files', component: Files,meta:{title:"File system"} },
    { path: '/files', component: Files,meta:{title:"File system"} },
    { path: '/ping', component: Ping,meta:{title:"Ping"} },
    { path: '/settings', component: Settings,meta:{title:"Settings"} },
    { path: '/history', component: History,meta:{title:"File History"} },
    { path: '/puzzle', component: Puzzle,meta:{title:"Jigsaw"} },
    { path: '/eval', component: Eval,meta:{title:"Evaluate XQuery"} },
    { path: '*', component: Notfound,meta:{title:"Page not found"} }
  ],
});
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (true) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next() // make sure to always call next()!
  }
});

Vue.use(Vuetify);
const app = new Vue({
  router,
  data:function(){return {
    q:"",
    status:{},
    drawer:true,
    mini: false,
    items: [
      {href: '/',title: 'Home', icon: 'home'    }, 
      {href: 'files', title: 'File system',icon: 'folder' },
      {href: 'edit',title: 'edit',icon: 'mode_edit'},
      {href: 'history',title: 'history',icon: 'history'},
      {href: 'eval',title: 'Evaluate',icon: 'cake'}, 
      {href: 'people',title: 'People',icon: 'person'}, 
      {href: 'select',title: 'select',icon: 'extension'},
      {href: 'puzzle',title: 'Puzzle',icon: 'extension'}, 
      {href: 'options',title: 'options',icon: 'domain'}, 
      {href: 'tabs',title: 'tabs',icon: 'switch_camera'}, 
      {href: 'ping',title: 'ping',icon: 'update'},
      {href: 'thumbnail',title: 'thumbnail',icon: 'touch_app'},
      {href: 'settings',title: 'settings',icon: 'settings'  }
]

  }},
  methods: {
      
      search(){
        this.$router.push({path: 'search',query: { q: this.q }})
      }
  },
  created(){
    console.log("create-----------")
    HTTP.get("status")
    .then(r=>{
      console.log("status",r)
      this.status=r.data
    }) 
  },
  beforeDestroy(){
    console.log("destory-----------")
    
  }
  }).$mount('#app');
