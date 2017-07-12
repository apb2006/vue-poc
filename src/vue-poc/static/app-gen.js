// generated 2017-07-12T11:37:10.722+01:00
Vue.component('my-component',{template:` 
 <a :href="href" :target="href"> {{href}}<v-icon>link</v-icon></a>
 `,
      
  props: ['href'],
  created:function(){
      console.log("my-component");
    }
}

      );
      Vue.component('nav-list',{template:` 
 <v-list dense="">
<template v-for="(item, i) in items">
  <v-layout row="" v-if="item.heading" align-center="" :key="i"> 
    <v-flex xs6="">
      <v-subheader v-if="item.heading">
        {{ item.heading }}
      </v-subheader>
    </v-flex>
    <v-flex xs6="" class="text-xs-center">
      <a href="#!" class="body-2 black--text">EDIT</a>
    </v-flex>
  </v-layout>
  <v-list-group v-else-if="item.children" v-model="item.model" no-action="">

      <v-list-tile :to="item.href" ripple="" slot="item">
       <v-list-tile-action>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-tile-action>
          <v-list-tile-title>
            {{ item.text }}
          </v-list-tile-title>
          <v-spacer></v-spacer>
        <v-list-tile-action>
          <v-icon>{{ item.model ? 'keyboard_arrow_up' : 'keyboard_arrow_down' }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
        
        </v-list-tile-content>
      </v-list-tile>
    <template v-for="(child, i) in item.children">
      <v-list-tile :to="child.href" :key="i" ripple="">
        <v-list-tile-action v-if="child.icon">
          <v-icon>{{ child.icon }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>
            {{ child.text }}
          </v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </template>
  </v-list-group>
 
    <v-list-tile v-else="" :to="item.href" ripple="">
      <v-list-tile-action>
        <v-icon>{{ item.icon }}</v-icon>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title>
          {{ item.text }}
        </v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>

</template>
</v-list>
 `,
      
  props: ['items'],
 
   created:function(){
      console.log("nav-lst");
    }
}

      );
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
      const Home=Vue.extend({template:`  <v-layout class="ma-5"> <v-flex xs4=""> <v-card hover="" raised=""> <v-card-title height="200px" class="pa-5 green lighten-1">
<div class="display-1 white--text text-xs-center">VUE-POC</div>
v0.0.2 </v-card-title> </v-card> </v-flex> <v-flex xs4="">
<p>
	This is a experiment in using
	<code>vue.js</code>
	.
</p>
<ul>
	<li><a href="https://vuetifyjs.com/vuetify/quick-start" target="new">vuetifyjs</a></li>
	<li><a href="https://github.com/monterail/vue-multiselect" target="new">vue-multiselect</a></li>
	<li><a href="https://github.com/sagalbot/vue-select" target="new"><s>vue-select</s></a></li>
	<li><a href="https://github.com/beautify-web/js-beautify" target="new">js-beautify</a></li>
	<li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
	<li><a href="/dba" target="new">DBA app</a></li>
</ul>
</v-flex> <v-btn floating="floating"> <v-icon>add</v-icon> </v-btn> <my-component href="/dba">REPLACED</my-component> </v-layout>  `,
      
  }

      );
      const Files=Vue.extend({template:` 
 <v-container fluid="">
 
<v-card>
<v-toolbar>
      <v-menu bottom="" right="">
           <v-btn icon="" slot="activator"><v-icon>{{icon}}</v-icon></v-btn>
      <v-list>
          <v-list-tile v-for="item in crumbs" :key="item">
            <v-list-tile-title @click="root()">{{ item }}</v-list-tile-title>
          </v-list-tile>
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
      <v-list-tile v-for="item in folders" v-bind:key="item.name" @click="folder(item.name)" avatar="">
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content @click="folder(item.name)">
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>modified: {{ item.modified | formatDate}} size: {{ item.size | readablizeBytes}}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon="" ripple="" @click.native.stop="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    
    <v-divider inset=""></v-divider>
    <v-subheader inset="">Files</v-subheader> 
      <v-list-tile v-for="item in files" v-bind:key="item.name">
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content @click="file(item.name)">
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
           <v-list-tile-sub-title>modified:  {{item.modified | formatDate}} size:  {{item.size|readablizeBytes }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon="" ripple="" @click.native.stop="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>

  </v-list>
    <v-navigation-drawer right="" light="" temporary="" v-model="showInfo">
     <v-card> 
       <v-toolbar class="green white--text">
      <v-toolbar-title>{{selected}}</v-toolbar-title>
      <v-spacer></v-spacer>    
       <v-btn flat="" icon="" @click.native="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-toolbar>
    <v-card-text> blah blah protocol: {{protocol}} </v-card-text> 
</v-card>
      </v-navigation-drawer>
</v-card>
 </v-container>
 `,
      
  
  props:["protocol"],
  data:  function(){
    return { 
            crumbs:[],
            folders:[],
            files:[],
            items:["root"],
            q:"",
            busy:false,
            showInfo:false,
            selected:""
    }
  },
  methods:{
    file (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/"+val,protocol:this.protocol  }})
    },
    folder (val) {
      this.crumbs.push(val )
    },
    load(url){
      this.busy=true
      HTTP.get("file",{params:{url:url,protocol:this.protocol}})
      .then(r=>{
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
    },
    filter(){
      console.log("TODO")
    },
    info(sel){
      this.selected=sel
      this.showInfo=true
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
      },
   icon(){
        return (this.protocol=="basexdb")?"account_balance":"folder"
      }
  },
  watch:{
    url(v){
      this.$router.push({  query: { url: this.url }})
      },
      $route(v){
        var url=this.$route.query.url
        this.url=url?url:"/";
        this.load(this.url) 
      }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:"/";
    this.load(this.url)
  }
}

      );
      const History=Vue.extend({template:` 
 <v-container fluid="">
    <v-list>
            <v-list-tile v-for="item in items" v-bind:key="item.title" @click="doEdit(item)" avatar="">
              <v-list-tile-action>
               <v-chip v-text="item.mode">Example Chip</v-chip>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title @click="doEdit(item)" v-text="item.url"></v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
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
    doEdit(item){
      console.log("history: ",item)
        router.push({ path: 'edit', query: { url:item.url, mode:item.mode  }})
    }
  },
  created:function(){
    this.get()
    console.log("history")
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

<v-toolbar class="grey lighten-2 black--text">
<v-menu>
  <v-btn primary="" icon="" dark="" slot="activator" v-tooltip:top="{ html: path.join('/') }"><v-icon>folder</v-icon></v-btn>
  <v-list>
      <v-list-tile v-for="item in path" :key="item">
        <v-list-tile-content @click="showfiles()">
        <v-list-tile-title>{{ item }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
  </v-list>
</v-menu>

  <v-toolbar-title>
      <span>{{ name }}</span>
  </v-toolbar-title>
  <v-toolbar-items>
  <span v-tooltip:top="{ html: 'Changed?' }">
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
   <v-btn icon="" @click.native="acecmd('outline')">
      <v-icon>star</v-icon>
    </v-btn>

  
   <v-btn icon="" @click.native="acecmd('foldall')">
      <v-icon>vertical_align_center</v-icon>
    </v-btn>
    
    <v-btn icon="" @click.native="wrap=!wrap">
      <v-icon>wrap_text</v-icon>
    </v-btn>
    
   <v-btn icon="" @click.native="save()">
      <v-icon>file_upload</v-icon>
    </v-btn>
    
    <v-btn icon="" @click.native="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn icon="" @click.native="clearDialog = true">
      <v-icon>delete</v-icon>
    </v-btn>
        <v-menu left="" transition="v-fade-transition">
        <v-btn icon="" slot="activator">
          <v-icon>help</v-icon>
        </v-btn>     
        <v-list>
            <v-list-tile @click="acecmd('showSettingsMenu')" avatar="">
               <v-list-tile-avatar>
              <v-icon>settings</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title>Show settings</v-list-tile-title>
            </v-list-tile>
                      
            <v-list-tile @click="acecmd('showKeyboardShortcuts')" avatar="">
              <v-list-tile-avatar>
              <v-icon>keyboard</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title>Show keyboard commands</v-list-tile-title>
            </v-list-tile>
          </v-list>
       </v-menu>
    <v-menu left="" transition="v-fade-transition">
      <v-btn icon="" slot="activator">
        <v-icon>more_vert</v-icon>
      </v-btn>
     
          <v-list>
              <v-list-tile>
                <v-list-tile-title>unused</v-list-tile-title>
              </v-list-tile>           
          </v-list>
          
      </v-menu>
    </v-toolbar-items>
     <v-dialog v-model="clearDialog">
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
   <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>

<v-card-text v-if="!busy">
<v-flex xs12="" style="height:70vh" fill-height="">
  
    <vue-ace :content="contentA" :mode="mode" :wrap="wrap" v-on:change-content="changeContentA" v-on:annotation="annotation"></vue-ace>
 </v-flex> 
</v-card-text>
</v-card>
  
 </v-container>
 `,
      
  data () {
    return {
      contentA: `declare function local:query($q as xs:string)
{ <json type="object"/> 
};`,
      mode:'xquery',
      url:'',
      protocol:'webfile',
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
      var a=url.split("/")
      this.url=url
      this.name=a.pop()
      this.path=a
      HTTP.get("edit",{params: {url:url,protocol:this.protocol}})
      .then(r=>{
        //console.log(r)
        this.mimetype=r.data.mimetype
        this.mode=this.acetype(r.data.mimetype)
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
            protocol:this.protocol,
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
  this.protocol=this.$route.query.protocol?this.$route.query.protocol:this.protocol
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
  <v-card>

     <v-toolbar>
      <v-btn @click.native="run()">Run</v-btn>
    <v-btn @click.native="submit()">
    <v-icon>play_circle_outline</v-icon>
    Submit</v-btn>
    <v-spacer></v-spacer>
     <v-btn @click.native="imports()">
    <v-icon>play_circle_outline</v-icon>
    Imports</v-btn>
     <v-menu :nudge-width="100">
          <v-toolbar-title slot="activator">
            <span>{{font}}</span>
            <v-icon>arrow_drop_down</v-icon>
          </v-toolbar-title>
          <v-list>
            <v-list-tile v-for="item in dropdown_font" :key="item">
              <v-list-tile-title v-text="item.text" @click="font=item.text"></v-list-tile-title>
            </v-list-tile>
          </v-list>
        </v-menu>
   </v-toolbar>

  
  <v-card-text>
  <v-flex xs12="" style="height:200px" fill-height="">
  <vue-ace :content="xq" mode="xquery" wrap="true" v-on:change-content="onChange"></vue-ace>
    </v-flex>
   </v-card-text>
    <v-alert error="" v-bind:value="showError">
      {{result}}
    </v-alert>
     <v-card-actions v-if="show">
       
        JobId:
      <v-chip class="green white--text">{{jobId}}</v-chip>
       <v-progress-circular v-if="waiting" indeterminate="" class="primary--text"></v-progress-circular>
         Elapsed:
         <v-chip class="green white--text">{{elapsed}}</v-chip>
        <v-spacer></v-spacer>
      <v-btn flat="" class="green--text darken-1">@TODO</v-btn>
    </v-card-actions>
     <v-card-text v-if="show">
     <v-flex xs12="" style="height:200px" fill-height="">
        <vue-ace :content="result" mode="text" wrap="true" read-only="true"></vue-ace>
        </v-flex> 
       </v-card-text>
    </v-card>

 </v-container>
 `,
      
  data:  function(){
    return {
      xq: '(: type your XQuery :)\n',
      result:'',
      elapsed:null,
      show:false,
      showError:false,
      jobId:null,
      waiting:false,
      start:null,
      font:'Courier',
      dropdown_font: [
        { text: 'Arial' },
        { text: 'Calibri' },
        { text: 'Courier' },
        { text: 'Verdana' }
      ]
      }
  },
  methods:{
    onChange(val){
      if (this.xq !== val) {
        this.xq = val
      }
    },
    
    run(){
      var data={xq:this.xq}
      this.showError=this.show=false
      this.start = performance.now();
      HTTP.post("eval/execute",Qs.stringify(data))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=r.data.result
        this.jobId=null
        this.show=true
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
      localforage.setItem('eval/xq', this.xq)
    },
    submit(){
      var data={xq:this.xq}
      this.showError=this.show=false
      this.start = performance.now();
      HTTP.post("eval/submit",Qs.stringify(data))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=this.jobId=r.data.job
        this.show=true
        this.pollState()
        
      })
      .catch(r=> {
        console.log("error",r)
        this.jobId=r.response.job
        this.showError=true;

      });
    },
    pollState(){
      this.waiting=true;
      HTTP.get("job/"+this.jobId)
      .then(r=>{
        this.waiting=r.data.state!="cached";
        this.elapsed=Math.floor(performance.now() - this.start);
         if(this.waiting) {
           setTimeout(()=>{ this.pollState() }, 5000);
         }else{
           this.getResult()
         }
      })
    },
    getResult(){
       HTTP.post("eval/result/"+this.jobId)
       .then(r=>{
         this.result=r.data.result
         this.jobId=null
         this.show=true
       })
    },
    imports(){
      alert("imports")
    }
  },
  
  created:function(){
      localforage.getItem('eval/xq').then((value) => { this.xq=value || this.xq});
  }
}

      );
      const About=Vue.extend({template:`  <v-layout class="ma-5"> <v-flex xs4=""> <v-card hover="" raised=""> <v-card-title height="200px" class="pa-5 green lighten-1">
<div class="display-1 white--text text-xs-center">VUE-POC</div>
v0.0.2 </v-card-title> </v-card> </v-flex> <v-flex xs4="">
<p>
	This is a experiment in using
	<code>vue.js</code>
	.
</p>
<ul>
	<li><a href="https://vuetifyjs.com/vuetify/quick-start" target="new">vuetifyjs</a></li>
	<li><a href="https://github.com/monterail/vue-multiselect" target="new">vue-multiselect</a></li>
	<li><a href="https://github.com/sagalbot/vue-select" target="new"><s>vue-select</s></a></li>
	<li><a href="https://github.com/beautify-web/js-beautify" target="new">js-beautify</a></li>
	<li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
	<li><a href="/dba" target="new">DBA app</a></li>
</ul>
</v-flex> <v-btn floating="floating"> <v-icon>add</v-icon> </v-btn> <my-component href="/dba">REPLACED</my-component> </v-layout>  `,
      
  }

      );
      const Images=Vue.extend({template:` 

      <v-card>
        <v-card-actions>
         <v-btn @click.native="page+=1">next</v-btn>
         {{page}}
          <v-btn @click.native="page-=1">back</v-btn>
          
          <v-spacer></v-spacer>
        </v-card-actions>
        <v-container fluid="" grid-list-md="">
          <v-layout row="" wrap="">
            <v-flex height="80px" xs2="" v-for="image in images" :key="image.name">
              <v-card @click="selected()" class="grey lighten-2 pt-1">
                <v-card-media :src="src(image)" height="80px" :contain="true"></v-card-media>
                 <v-card-actions v-tooltip:top="{ html: image.name }">
              
                <v-btn icon="" small="">
                  <v-icon>favorite</v-icon>
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn icon="" small="">
                  <v-icon>bookmark</v-icon>
                </v-btn>
                <v-btn icon="" small="">
                  <v-icon>share</v-icon>
                </v-btn>
              </v-card-actions>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card>

 `,
        
  data: () => ({
    images:[],
    page:0
  }),
  methods:{
    src(item){
     //return "https://unsplash.it/150/300?image="+Math.floor(Math.random() * 100) + 1
        return "data:image/jpeg;base64,"+item.data
    },
    getImages(){
      HTTP.get("images/list?page="+this.page)
      .then(r=>{
        this.images=r.data.items
        })
      
    },
    selected(){
      alert("not yet")
    }
  },
  watch:{
    page(v){
      this.$router.push({  query: { page: this.page }})
      },
      $route(v){
        this.getImages()
      }
  },
  created:function(){
    this.page=this.$route.query.page || this.page
    this.getImages()
  }
    }

      );
      const Job=Vue.extend({template:` 
  <v-card>
   <v-toolbar class="green white--text">
       <v-btn light="" icon="" :loading="loading" @click.native="getJobs()" :disabled="loading">
    <v-icon>refresh</v-icon>
    </v-btn>
    
     <v-btn @click.native="stop()" :disabled="noSelection">Stop</v-btn>
    
      <v-spacer></v-spacer>
      <v-text-field append-icon="search" label="Search" single-line="" hide-details="" v-model="search"></v-text-field>
     
    </v-toolbar>
  <v-data-table :headers="headers" :items="items" :search="search" v-model="selected" select-all="" class="elevation-1" no-data-text="No Jobs currently running">
    <template slot="items" scope="props">
    <td>
        <v-checkbox primary="" hide-details="" v-model="props.selected"></v-checkbox>
      </td>
      <td>{{ props.item.id }}</td>
      <td class="text-xs-right">{{ props.item.state }}</td>
      <td class="text-xs-right">{{ props.item.duration }}</td>
      <td class="text-xs-right">{{ props.item.type }}</td>
      <td class="text-xs-right">{{ props.item.user }}</td>
       <td><code>{{ props.item.text }}</code></td>
    </template>
  </v-data-table>
 </v-card>
 `,
      
  data:  function(){
    return {
      headers: [
        {
          text: 'Job id',
          left: true,
          value: 'id'
        },
        { text: 'State', value: 'state' },
        { text: 'Duration', value: 'duration' },
        { text: 'Type', value: 'type' },
        { text: 'User', value: 'user' },
        { text: 'Query', value: 'text' }
      ],
      items:[        
      ],
      selected:[],
      search:"",
      loading:false
      }
  },
  methods:{
    getJobs(){
      this.loading=true;
	    HTTP.get("job")
	    .then(r=>{
	       this.loading=false
	       this.items=r.data
	       setTimeout(()=>{ this.getJobs() }, 10000);
	    })
	   
    },
    stop(){
      var s=this.selected.map((j)=>{return j.id}).join(",")
      console.log("AAA",this.selected)
      alert(s)
    }
  },
  computed: {
    // a computed getter
    noSelection: function () {
      // `this` points to the vm instance
      return this.selected.length==0
    }
  },
  created(){
    this.getJobs()
  }
}

      );
      const Login=Vue.extend({template:` 
<v-card class="grey lighten-4 elevation-0">

      <v-card-title class="green darken-1">
        <span class="white--text">Login</span>
      </v-card-title>
    <v-alert error="" v-bind:value="showMessage">
      {{message}}
    </v-alert>
     <v-card-actions>
      <v-text-field name="input-name" label="Enter your name" hint="name??" v-model="name" required=""></v-text-field>
     </v-card-actions>
  
    <v-card-actions>    
         <v-text-field name="input-password" label="Enter your password" hint="Enter your password" v-model="password" :append-icon="hidepass ? 'visibility' : 'visibility_off'" :append-icon-cb="() => (hidepass = !hidepass)" :type="hidepass ? 'password' : 'text'" required=""></v-text-field>      
    </v-card-actions>
        
    <v-divider></v-divider>
    <v-card-actions class="blue-grey darken-1 mt-0">
       <v-btn primary="" @click.native="go()">Continue</v-btn>
       <v-spacer></v-spacer>
    </v-card-actions>
</v-card>
 `,
      
    data () {
      return {
        hidepass: true,
        name:'',
        password: '',
        redirect: this.$route.query.redirect,
        message:"",
        showMessage:false
      }
    },
    methods:{
      go () {
       this.hidepass=true
       this.showMessage=false
       var data=Qs.stringify(
           {
             username: this.name, //gave the values directly for testing
             password: this.password,
             redirect: this.redirect
             })
       HTTP.post("login-check", data)
      .then(r=>{
        console.log("login",r.data)
        if(r.data.status){
          this.$auth.role="admin"
          this.$router.replace(this.redirect)
        }else{
          this.message=r.data.message
          this.showMessage=true;
        }
          
      }).catch(error=> {
        alert("err login")
      })
    }
  }
}

      );
      const Log=Vue.extend({template:` 
 <v-container fluid="">
  <h1>LOGS</h1>
</v-container> `,
      
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
      const People=Vue.extend({template:` 
 <v-container fluid="">
  <v-layout>Look at all the people who work here!
  <v-btn light="" default="" v-on:click.native="reverseMessage">Reverse Message</v-btn>
  <p>{{ message }}</p>
   <v-btn light="" default="" v-on:click.native="logout">logout</v-btn>
   <!-- 
    <v-autocomplete :items="list" 
    v-model="fieldValue" 
    :search.sync="search"
     label="Suburb" item-text="suburb" 
    item-value="suburb" 
    @selected="handleSelected"
     strict="Unknown">
<template slot="item" scope="data">
      <v-list-tile-content>
        <v-list-tile-title>{{data.item.suburb}}</v-list-tile-title>
        <template v-if="!data.item.generatedItem">
          <v-list-tile-sub-title>{{data.item.postcode}} - {{data.item.state}}</v-list-tile-sub-title>
        </template>
      </v-list-tile-content>
    </template>
</v-autocomplete>
 -->
  </v-layout>
  <v-card>
  <v-layout>
  <v-flex xs5="">created:{{$auth.created}}</v-flex>
   <v-flex xs5="">session:{{$auth.session}}</v-flex>
  </v-layout>
  </v-card>
  <v-layout>
  <v-flex xs5="">
   <v-card-media src="resources/music.jpg" height="300px"></v-card-media>
  </v-flex>
  <v-flex xs1="">
  <v-card-media :src="img" height="60px"></v-card-media>
  </v-flex>
  </v-layout>
  
 
 </v-container>
 `,
      
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      fieldValue:"",
      list:[],
      search:"",
      data:[],
      img:"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
    }
  },
  methods: {
    reverseMessage() {
      this.message = this.message.split('').reverse().join('')
    },
    logout(){
      alert("TODU")
    },
    handleSelected(){
      
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
  <v-layout>
 
  <table>
   <tbody><tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:3em;">
    <v-btn @click.native="click(row,col)" :disabled="disabled(row,col)">{{cell}}</v-btn>
    </td>
   </tr>
  </tbody></table>
   <br>
   <table>
   <tbody><tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:50px;height:50px;">
    <v-btn @click.native="click(row,col)" :disabled="disabled(row,col)">
    <img :src="src(row,col)" style="width:50px;height:50px;">
</v-btn>
    </td>
   </tr>
  </tbody></table>
  </v-layout>
    Loosely inspired by <a href="http://homepages.cwi.nl/~steven/Talks/2017/06-10-iot/game-demo.html">demo</a>
 </v-container>
 `,
      
  data:  function(){
    return {grid: [
      [1,5,8,12],
      [2,6,9,13],
      [3,7,10,14],
      [4,null,11,15] 
    ],
    empty:[3,1],
    tiles:[{data:""}]
    }
  },
  methods: {
    click(row,col) {
      var g=this.grid
      var h=g[row][col]
      g[row][col]=null
      g[this.empty[0]][this.empty[1]]=h
      var e=[row,col]
      this.empty=e
      this.grid= g
      console.log("click",this.grid,e)
      this.$forceUpdate()
    },
    disabled(row,col){
      var ok=(row==this.empty[0]) && (col==this.empty[1]-1 ||col==this.empty[1]+1) 
      ok=ok || (col==this.empty[1]) && (row==this.empty[0]-1 ||row==this.empty[0]+1);
      return !ok 
    },
    gettiles(){
      HTTP.get("thumbnail/images")
      .then(r=>{
        this.tiles=r.data.items
        this.$forceUpdate()
        })
      
    },
    src(row,col){
      var v=this.grid[row][col]
      var d=""
      if(typeof this.tiles[v] !== 'undefined') d=this.tiles[v].data 
      
      return "data:image/jpeg;base64,"+d 
    }
   
  },
  created(){
    this.gettiles()
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

    <v-card-title class="green darken-1">
      <span class="white--text">Selection</span>
      
    </v-card-title>
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
   
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableSnippets</v-list-tile-title>
                <v-list-tile-sub-title>Allow snippets</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
    
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableBasicAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableBasicAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
         
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableLiveAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableLiveAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
 
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
    localforage.getItem('settings/ace').then((value) => {
      console.log('oh say can you see, ' + value);
      this.ace=value || this.ace
    }).catch((err) => {
      console.log('the rockets red glare has blinded me');
    });
  },
  updated: function () {
    // `this` points to the vm instance
    console.log('updated: ')
    localforage.setItem('settings/ace', this.ace).then((value) => {
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
      <v-card-actions>
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
        </v-card-actions>
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
      const Task=Vue.extend({template:` 
 <v-container fluid="">
  <h1>Tasks</h1>
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
        alert("validate")
        HTTP.post("thumbnail/validate",Qs.stringify({task: this.taskxml}))
        .then(r=>{alert("gg")})
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

const Auth={
    user:"guest",
    permission:null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  }
};
Vue.use(Auth);
Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
  console.error(err, vm, info);
  alert("vue error");
};


      
var Events = new Vue({});


const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  routes: [
    { path: '/', component: Home,meta:{title:"Home"} },
    { path: '/people', component: People ,meta:{title:"People"}},
    { path: '/images', component: Images,meta:{title:"Images"} },
    { path: '/select', component: Select,meta:{title:"Select"} },
    { path: '/search', component: Search,meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/thumbnail', component: Thumbnail,meta:{title:"Thumbnail generator"} },
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} },
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"basexdb"} },
    { path: '/ping', component: Ping,meta:{title:"Ping"} },
    { path: '/settings', component: Settings,meta:{title:"Settings"} },
    { path: '/history', component: History,meta:{title:"File History"} },
    { path: '/puzzle', component: Puzzle,meta:{title:"Jigsaw"} },
    { path: '/eval', component: Eval,meta:{title:"Evaluate XQuery"} },
    { path: '/logs', component: Log,meta:{title:"Server logs"} },
    { path: '/tasks', component: Task,meta:{title:"Runnable tasks"} },
    { path: '/jobs', component: Job,meta:{title:"Jobs"} },
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
    if ("admin"==Auth.permission) {
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
    items:[
      {href: '/',text: 'Home', icon: 'home'    }, 
      {
        icon: 'folder_open',
        text: 'Collections' ,
        model: false,
        children: [
       {href: 'database', text: 'Databases',icon: 'account_balance' },
       {href: 'files', text: 'File system',icon: 'folder' },
      {href: 'edit',text: 'edit',icon: 'mode_edit'},
      {href: 'history',text: 'history',icon: 'history'},
      {href: 'logs',text: 'Server logs',icon: 'dns'}
      ]},
      {
        icon: 'directions_run',
        text: 'Actions' ,
        model: false,
        children: [
      {href: 'eval',text: 'Query',icon: 'play_circle_outline'},      
      {href: 'jobs',text: 'Running jobs',icon: 'dashboard'},
      {href: 'tasks',text: 'Tasks',icon: 'history'}, 
      ]},
      {
        icon: 'more_horiz',
        text: 'More' ,
        model: false,
        children: [
      {href: 'people',text: 'People',icon: 'person'}, 
      {href: 'select',text: 'select',icon: 'extension'},
      {href: 'puzzle',text: 'Puzzle',icon: 'extension'}, 
      {href: 'images',text: 'Images',icon: 'camera_roll'}, 
      {href: 'tabs',text: 'tabs',icon: 'switch_camera'}, 
      {href: 'ping',text: 'ping',icon: 'update'},
      {href: 'thumbnail',text: 'thumbnail',icon: 'touch_app'}
      ]},
      {href: 'settings',text: 'settings',icon: 'settings'  }
    ]

  }},
  methods: {
      
      search(){
        this.$router.push({path: 'search',query: { q: this.q }})
      },
      logout(){
        HTTP.get("logout").then(r=>{
          alert("logout")
        })
       
      }
  },
  created(){
    console.log("create-----------")
    HTTP.get("status")
    .then(r=>{
      console.log("status",r.data)
      Object.assign(Auth,r.data)
      this.$forceUpdate()
    }) 
  },
  beforeDestroy(){
    console.log("destory-----------")
    
  }
  }).$mount('#app');
