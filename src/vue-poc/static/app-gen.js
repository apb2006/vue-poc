// generated 2018-01-29T09:41:19.232Z

// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-confirm.vue
Vue.component('qd-confirm',{template:` 
  <v-dialog v-model="value">
       <v-card>
       <v-toolbar class="orange darken-1">
          <v-card-title>Confirm action</v-card-title>
          </v-toolbar>
          <v-card-text>
            <slot>Test message</slot>
          </v-card-text>
        <v-card-actions>
        <v-spacer></v-spacer>
          <v-btn v-on:click="$emit('confirm',false)">Cancel</v-btn>
          <v-btn v-on:click="$emit('confirm',true)">Ok</v-btn>
        </v-card-actions>
        </v-card>
    </v-dialog>
 `,
      
  props: ['value']
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-fullscreen.vue
Vue.component('qd-fullscreen',{template:` 
<a @click="toggle()" href="javascript:void(0);" title="Fullscreen toggle">
  <v-icon>{{ fullscreenIcon }}</v-icon>
  </a>
 `,
      
  data(){
    return {fullscreenIcon:"fullscreen"}
  },
  methods:{
    toggle(){
      this.$fullscreen.toggle()
      setTimeout(()=>{
        var state=this.$fullscreen.isInFullScreen()
        //console.log("FS",state);
        this.fullscreenIcon=state?"fullscreen_exit":"fullscreen"
        }, 1000);
    }
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-link.vue
Vue.component('qd-link',{template:` 
 <a :href="href" :target="href"> {{href}}<v-icon>link</v-icon></a>
 `,
      
  props: ['href'],
  created:function(){
      console.log("qd-link");
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-navlist.vue
Vue.component('qd-navlist',{template:` 
 <v-list dense="">
    <template v-for="(item, i) in items">
          <v-list-group v-if="item.children" v-bind:key="item.text" :prepend-icon="item.icon" no-action="">
            <v-list-tile slot="activator">
              <v-list-tile-content>
                <v-list-tile-title>{{ item.text }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            
            <v-list-tile v-for="subItem in item.children" v-bind:key="subItem.text" :prepend-icon="subItem.icon" :to="subItem.href" avatar="" ripple="">
              <v-list-tile-avatar>
		             <v-icon>{{ subItem.icon }}</v-icon>
		          </v-list-tile-avatar>
            <v-list-tile-content>
                <v-list-tile-title>{{ subItem.text }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-group>
          
          <v-list-tile v-else="" v-bind:key="item.text" :to="item.href" ripple="">
              <v-list-tile-avatar>
                 <v-icon>{{ item.icon }}</v-icon>
              </v-list-tile-avatar>
          <v-list-tile-content>
                <v-list-tile-title>{{ item.text }}</v-list-tile-title>
              </v-list-tile-content>
     
          </v-list-tile>
          </template>
        </v-list>
 `,
      
  props: ['items']
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-panel.vue
Vue.component('qd-panel',{template:` 
 <v-layout>
		<v-flex>
		<slot name="body"></slot>
		</v-flex>
		
		<v-flex v-if="show" xs4="" grey="" lighten-3="">
		<slot name="aside"></slot>
		</v-flex>
</v-layout>
 `,
      
  props: ['show'],
  created:function(){
      console.log("qd-panel");
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-table.vue
Vue.component('qd-table',{template:` 
 <v-container fluid="">
  <v-card>
   <v-toolbar>
    <v-text-field append-icon="search" label="Filter user" single-line="" hide-details="" v-model="search"></v-text-field>   
      <v-spacer></v-spacer>
      <v-btn @click="getData">Refresh</v-btn>   
    </v-toolbar>
<v-data-table :headers="headers" :items="items" :search="search" v-model="selected" select-all="" class="elevation-1" no-data-text="No users found @todo">
    <template slot="items" scope="props">
    <slot></slot>
    </template>
  </v-data-table>
  </v-card>
 </v-container>
 `,
      
	  props: {
	    headers: {
	      default: [
	        {
	          text: 'Name',
	          left: true,
	          value: 'id'
	        },
	        { text: 'Permission', value: 'state' }
	      ]
	  },
	  dataUri:{
	    default: "users"
	  }
  },
  data:  function(){
    return {
      loading: false,
      items: [],
      search: null,
      selected: [],

      }
  },
  methods:{
      getData(){
        this.loading=true;
        HTTP.get(this.dataUri)
        .then(r=>{
           this.loading=false
           this.items=r.data
        })
     }
  },
  created:function(){
    console.log("qd-table")
    this.getData()
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vis-time-line.vue
Vue.component('vis-time-line',{template:` 
  <div></div>
 `,
       
  props: ['items', 'groups', 'options','events'],
  data(){
    return {timeline:Object}
  },
  methods:{
    select(properties){
      this.$emit('select',properties.items);
    }
  },
  mounted: function () {
    var items = new vis.DataSet(this.items);
    var options = this.options;
    var groups = this.groups;
    this.timeline = new vis.Timeline(this.$el, items, groups, options);
    this.timeline.on('select', this.select);
    if(this.events){
      this.events.$on('fit', (cmd) => {
        this.timeline.fit(true)
        })
    }
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-job.vue
Vue.component('vp-job',{template:` 
 <v-card>
     <v-toolbar dense="">
     <v-card-title>Details:</v-card-title>
       <v-chip class="primary white--text">{{job.id}}</v-chip>
         <v-spacer></v-spacer>
           <v-chip class="primary white--text">{{job.job}}</v-chip>
      
           <v-chip label="" class="grey white--text"> 
           <v-avatar class="red">  <v-icon>lock</v-icon>W</v-avatar>
           {{ jobState.writes }}</v-chip>
           
            <v-chip label="" class="grey white--text"> 
              <v-avatar class="amber"> <v-icon>lock</v-icon>R</v-avatar>
              {{ jobState.reads }}</v-chip>
 
      
          <v-chip>{{ jobState.state }}</v-chip>
         <v-chip class="primary white--text">
          <v-avatar>  <v-icon>timer</v-icon></v-avatar>
         {{elapsed}}ms</v-chip>
    </v-toolbar>
    <v-card-text>
  <v-flex xs12="" style="height:60px;" fill-height="">
  <vue-ace :content="query" mode="xquery" wrap="true" read-only="true"></vue-ace>
    </v-flex>
   </v-card-text>
   <!-- result -->
    <v-card-text>
  <v-flex xs12="" fill-height="">
  <vue-ace :content="aresult" mode="xquery" min-lines="1" wrap="true" read-only="true"></vue-ace>
    </v-flex>
   </v-card-text>
   </v-card>
   
 `,
      
  props: ['job',
          'result',
          'jobState',
          'elapsed'],
  data:function(){
    return {
      query:    "(:to do:)",
      error:    null
    }
  },
  watch:{
    result:function(a){
      console.log("result");
    }
  },
  computed:{
    aresult:function(){return this.result || "none"}
  },
  created:function(){
      console.log("vp-job");
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vue-ace.vue
Vue.component('vue-ace',{template:` 
<div style="width: 100%; height: 100%;"></div>
 `,
      
  props: [ 'content',
          'mode', 
          'wrap',
          'readOnly',
          'events',
          'settings',
          'minLines',
          ],
  data () {
    return {
      editor: Object,
      beforeContent: '',
      aceSettings:{
          theme: "github",
          keybinding: "ace",
          fontsize: 16,
          enableSnippets:true,
          enableBasicAutocompletion:true,
          enableLiveAutocompletion:true
          },
      annots:{
        error:0,warning:0,info:0
        } 
      }
  },
  
  watch: {
    'content' (value) {
        if (this.beforeContent !== value) {
        this.editor.setValue(value, 1)
      }
    },
    'mode' (value) {
        var session=this.editor.getSession()
        session.setMode(`ace/mode/${value}`)
    },
    'wrap' (value) {
      var session=this.editor.getSession()
      session.setUseWrapMode(value)
    },
    "settings":{
      handler:function(vnew,vold){
        this.applySettings(vnew)
       // alert("setting")
        },
      deep:true
    }
  },
  methods:{

    command(cmd){
      //alert("fold")
      var cm = this.editor.commands
      //console.log(cm.commands)
     cm.exec(cmd, this.editor)
    },
    
    outline(){
      var row = this.editor.selection.getCursor().row
      var toks=this.editor.session.getTokens(row).filter(function(t) {
          return true
      })
      console.log("tokens: ",toks);
    },
    
    testAnnotations(){
    this.editor.getSession().setAnnotations([{
      row: 1,
      column: 0,
      text: "Strange error",
      type: "error" // also warning and information
    }]);
    },
    
    applySettings(aceSettings){
      this.editor.setTheme(`ace/theme/${aceSettings.theme}`)
      //this.editor.setKeyboardHandler(`ace/keyboard//${aceSettings.keybinding}`)
      this.editor.setFontSize(parseInt(aceSettings.fontsize,10))
      this.editor.setOptions({ 
                          enableSnippets : aceSettings.enableSnippets,
                          enableBasicAutocompletion : aceSettings.enableBasicAutocompletion,
                          enableLiveAutocompletion : aceSettings.enableLiveAutocompletion,
                          tabSize: 2,
                          useSoftTabs: true
                          });
    }
  },
  
  mounted () {
    const mode = this.mode || 'text'
    const wrap = this.wrap || false

    const readOnly = this.readOnly || false
    ace.config.set("workerPath", "/vue-poc/ui/ace-workers") 
    this.editor = window.ace.edit(this.$el)
    this.applySettings(this.aceSettings)
    this.editor.$blockScrolling = Infinity
    this.editor.setValue(this.content, 1)
    this.editor.setOptions({ readOnly:this.readOnly });
    if(this.minLines){
      this.editor.setOptions({ minLines: this.minLines})
    };
    var session=this.editor.getSession()
    session.setMode(`ace/mode/${mode}`)
    session.setUseWrapMode(wrap)
    this.editor.commands.addCommand({
      name: "showKeyboardShortcuts",
      bindKey: {win: "Ctrl-Alt-h", mac: "Command-Alt-h"},
      exec: function(editor) {
          ace.config.loadModule("ace/ext/keybinding_menu", function(module) {
              module.init(editor);
              editor.showKeyboardShortcuts()
          })
      }
  })
    this.editor.on('change', () => {
        this.beforeContent = this.editor.getValue()
      this.$emit('change-content', this.beforeContent)
    });
    
    this.editor.getSession().on("changeAnnotation", ()=>{
      var annot = this.editor.getSession().getAnnotations();
      this.annots={error:0,warning:0,info:0};
      for (var key in annot){
          if (annot.hasOwnProperty(key)){
            this.annots[annot[key].type]+=1;
            //console.log("[" + annot[key].row + " , " + annot[key].column + "] - \t" + annot[key].type+ "# " +annot[key].text);
          }
      }
      //console.log(this.annots)
       this.$emit('annotation',{error: this.annots["error"]+0, warning: this.annots["warning"]+0})
    });
    if(this.events){
      this.events.$on('eventFired', (cmd) => {
      if(cmd=="outline"){
       this.outline();
      }else this.command(cmd);
    });
    }
  }
}
      );
      
// src: C:\Users\andy\git\vue-poc\src\vue-poc\components\filters.js
/**
 * vue filters
 */

//Define the date time format filter
Vue.filter("formatDate", function(date) {
    return moment(date).format("MMMM D, YYYY")
});
Vue.filter("fromNow", function(date) {
  return moment(date).fromNow()
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
});

// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/404.vue
const Notfound=Vue.extend({template:` 
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/about.vue
const About=Vue.extend({template:` 
<v-container>
<v-parallax src="/vue-poc/ui/vue-poc.png">
</v-parallax> 
<v-card>

  <v-card-text>
 
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
	 <li> <router-link to="database?url=%2Fvue-poc%2F">DB</router-link></li>
</ul>
 <v-btn floating="floating"> <v-icon>add</v-icon> </v-btn> <qd-link href="/dba">REPLACED</qd-link> 
	</v-card-text>
	</v-card>
	</v-container>
	 `,
      
  }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/adminlog/logs.vue
const Log=Vue.extend({template:` 
 <v-container fluid="">
  <v-card>
   <v-toolbar>
       <v-btn icon="" :loading="loading" @click="getItems()" :disabled="loading">
    <v-icon>refresh</v-icon>
    </v-btn>   
      <v-spacer></v-spacer>
      <v-text-field append-icon="search" label="Filter logs" single-line="" hide-details="" v-model="search"></v-text-field>
     
    </v-toolbar>
  <v-data-table :headers="headers" :items="items" :search="search" class="elevation-1" no-data-text="No logs found" v-bind:pagination.sync="pagination">
    <template slot="items" scope="props">
      <td class="text-xs-right">{{ props.item.time }}</td>
      <td class="text-xs-right">{{ props.item.user }}</td>
      <td class="text-xs-right">{{ props.item.type }}</td>
      <td class="text-xs-right">{{ props.item.ms }}</td>
      <td><code>{{ props.item.text }}</code></td>
       <td class="text-xs-right">{{ props.item.address }}</td>
    </template>
  </v-data-table>
 </v-card>
</v-container> `,
      
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      q:this.$route.query.q,
      headers: [
        {
          text: 'time',
          left: true,
          value: 'time'
        },
        { text: 'user', value: 'user' },
        { text: 'Type', value: 'type' },
        { text: 'ms', value: 'ms' },
        { text: 'text', value: 'text' },
        { text: 'address', value: 'address' },
      ],
      items:[],
      pagination:{sortBy: 'time',descending:true,rowsPerPage:25},
      selected:[],
      search:"",
      loading:false,
      timer:null
      }
  },
  methods:{
    getItems(){
      this.loading=true
      HTTP.get("log",{params:this.q})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.items=r.data.items
        this.timer=setTimeout(()=>{ this.getItems() }, 5000);
        }) 
    }
  },
  created:function(){
    this.getItems()
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/brutusin.vue
const Brutusin=Vue.extend({template:` 
 <v-container fluid="">
     <v-card>
       <vue-form-generator :schema="schema" :model="model" :options="formOptions"></vue-form-generator>
    </v-card>
 </v-container>
 `,
      
  components: {
    "vue-form-generator": VueFormGenerator.component
   },
   data() {
     return {
       model: {
           id: 1,
           name: "John Doe",
           password: "J0hnD03!x4",
           age: 35,
           skills: ["Javascript", "VueJS"],
           email: "john.doe@gmail.com",
           status: true
       },
       schema: {
           fields: [{
               type: "input",
               inputType: "text",
               label: "ID",
               model: "id",
               readonly: true,
               featured: false,
               disabled: true
           }, {
               type: "input",
               inputType: "text",
               label: "Name",
               model: "name",
               readonly: false,
               featured: true,
               required: true,
               disabled: false,
               placeholder: "User's name",
               validator: VueFormGenerator.validators.string
           }, {
               type: "input",
               inputType: "password",
               label: "Password",
               model: "password",
               min: 6,
               required: true,
               hint: "Minimum 6 characters",
               validator: VueFormGenerator.validators.string
           }, {
               type: "input",
               inputType: "number",
               label: "Age",
               model: "age",
               min: 18,
               validator: VueFormGenerator.validators.number
           }, {
               type: "input",
               inputType: "email",
               label: "E-mail",
               model: "email",
               placeholder: "User's e-mail address",
               validator: VueFormGenerator.validators.email
           }, {
               type: "checklist",
               label: "Skills",
               model: "skills",
               multi: true,
               required: true,
               multiSelect: true,
               values: ["HTML5", "Javascript", "CSS3", "CoffeeScript", "AngularJS", "ReactJS", "VueJS"]
           }, {
              type: "switch",
               label: "Status",
               model: "status",
               multi: true,
               readonly: false,
               featured: false,
               disabled: false,
               default: true,
               textOn: "Active",
               textOff: "Inactive"
           }]
       },

       formOptions: {
           validateAfterLoad: true,
           validateAfterChanged: true
       }
     };
   },
  methods:{
    onResize(){
      var el=this.$refs["page"]
      console.log("top",el.offsetTop)
      var h=Math.max(1,window.innerHeight - el.offsetTop)-60
       console.log("h",h)
      el.style.height=h +"px"
    }
  },
  created:function(){
    console.log("form")
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/collection/files.vue
const Files=Vue.extend({template:` 
 <v-container fluid="">
 
<v-card>

<v-toolbar dense="">
    <v-btn icon="" :to="{query: { url: '/' }}">
     <v-icon>{{icon}}</v-icon>
     </v-btn>
        
    <v-btn icon="" @click="load()">
    <v-icon>refresh</v-icon>
    </v-btn> 
     
    <v-toolbar-title>
		    <v-breadcrumbs>
				    <v-breadcrumbs-item v-for="item in crumbs" :key="item.path" :to="{ query: { url:  item.path }}" :exact="true">
				    {{ item.name }}
				    </v-breadcrumbs-item>
		    </v-breadcrumbs>
    </v-toolbar-title>
   <v-btn v-if="clipboard" @click="clipboard=null" icon=""><v-icon>content_paste</v-icon></v-btn>
    <v-spacer></v-spacer>
     <v-btn v-if="selection.length" @click="selectNone">S: {{selection.length}}</v-btn>
     
 <v-text-field v-if="!selection.length" prepend-icon="search" label="Filter..." v-model="q" type="search" hide-details="" single-line="" @keyup.enter="setfilter" :append-icon="this.q?'clear':''" :append-icon-cb="e=>this.q=''"></v-text-field>
   
 
    <v-toolbar-items v-if="!selection.length">
    
   <v-btn icon="" v-for="b in buttons" :key="b.icon" @click="action(b)">
      <v-avatar>
        <v-icon v-text="b.icon"></v-icon>
       </v-avatar>
    </v-btn>
</v-toolbar-items>


  
    <v-toolbar-items v-if="selection.length">
		   <v-btn icon="" v-for="b in selopts" :key="b.icon" @click="action(b)">
		        <v-icon v-text="b.icon"></v-icon>
		    </v-btn>
   </v-toolbar-items>
 
    
 <v-menu offset-y="" v-if="selection.length">
      <v-btn icon="" slot="activator">
      <v-icon>more_vert</v-icon>
     </v-btn>
      <v-list>
        <v-list-tile @click="invoke">
          <v-list-tile-title>Invoke</v-list-tile-title>
        </v-list-tile>
        <v-divider></v-divider>
        <v-list-tile @click="invoke">
          <v-list-tile-title>todo</v-list-tile-title>
        </v-list-tile>
         <v-list-tile @click="invoke">
          <v-list-tile-title>todo</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-menu>
 
  
 </v-toolbar>
  
  <v-layout v-if="!busy">
	  <v-flex>
	  <v-list two-line="" subheader="">
	    <v-subheader inset="">
	         <span>Folders ({{ xfolders.length }})</span> 
	     </v-subheader>
	      <v-list-tile v-for="item in xfolders" v-bind:key="item.name" v-model="item.selected" @click="folder(item)" avatar="">
	        <v-list-tile-avatar @click.prevent.stop="item.selected =! item.selected ">
	          <v-icon v-bind:class="[itemClass(item)]">{{ itemIcon(item) }}</v-icon>
	        </v-list-tile-avatar>
	        <v-list-tile-content>
	          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
	          <v-list-tile-sub-title>modified: {{ item.modified | formatDate}}
	                                 size: {{ item.size | readablizeBytes}}
	                                  mimetype: {{ item.mime}}
	                                 </v-list-tile-sub-title>
	        </v-list-tile-content>
	        <v-list-tile-action>
	          <v-btn icon="" @click.stop="info(item)">
	            <v-icon class="grey--text text--lighten-1">info</v-icon>
	          </v-btn>
	        </v-list-tile-action>
	      </v-list-tile>
	    
	    <v-divider inset=""></v-divider>
	    <v-subheader inset="">
	       <span>Files ({{ xfiles.length }})</span> 
	        </v-subheader> 
	      <v-list-tile v-for="item in xfiles" v-bind:key="item.name">
	        <v-list-tile-avatar avatar="" @click.prevent.stop="item.selected =! item.selected ">
	          <v-icon v-bind:class="[itemClass(item)]">{{ itemIcon(item) }}</v-icon>
	        </v-list-tile-avatar>
	        <v-list-tile-content @click="file(item.name)">
	          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
	           <v-list-tile-sub-title>modified:  {{item.modified | formatDate}},
												            size:  {{item.size|readablizeBytes }},
												            mimetype: {{ item.mime}}
	            </v-list-tile-sub-title>
	        </v-list-tile-content>
	        <v-list-tile-action>
	          <v-btn icon="" ripple="" @click.stop="info(item)">
	            <v-icon class="grey--text text--lighten-1">info</v-icon>
	          </v-btn>
	        </v-list-tile-action>
	      </v-list-tile>
	  </v-list>
	  </v-flex>
	
  </v-layout>
  
  
   
</v-card>
<v-progress-linear v-if="busy" v-bind:indeterminate="true" height="2"></v-progress-linear>
 <v-navigation-drawer left="" absolute="" v-model="showInfo" :disable-route-watcher="true">
   <v-card flat="" tile=""> 
       <v-toolbar>
      <v-card-title>{{ selection[0] &amp;&amp; selection[0].name }}</v-card-title>
      <v-spacer></v-spacer>    
       <v-btn flat="" icon="" @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-toolbar>
    <v-card-text> Things to do with  </v-card-text>
    <v-card-actions> 
           <v-btn flat="" @click="invoke()"><v-icon>run</v-icon>run</v-btn>
           </v-card-actions>
    </v-card>
   </v-navigation-drawer> 
 </v-container>
  
 `,
      
  
  props:["protocol"],
  data(){
    return { 
            url: "", 
            items: [],
            q: null,
            busy: false,
            showInfo: false,
            clipboard: null,
          
						buttons: [ 
						    {method: this.todo, icon: "view_quilt"},
			          {method: this.add, icon: "add"},
						    {method: this.todo, icon: "sort"},
						    {method: this.selectAll, icon: "select_all"}     
						],
						selopts: [
						    {method: this.todo, icon: "delete"},
						    {method: this.clip, icon: "content_copy"},
						    {method: this.clip, icon: "content_cut"},
						    {method: this.todo, icon: "text_format"},
						    {method: this.todo, icon: "info"},
						    {method: this.todo, icon: "share"}
						 ]
    }
  },
  methods:{
    file (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/"+val,protocol:this.protocol  }})
    },
    folder (item) {
      this.url=this.url+item.name+"/"
    },
    load(){
      var url=this.url
      this.busy=true
      HTTP.get("collection",{params:{url:url,protocol:this.protocol}})
      .then(r=>{
        this.items=r.data.items
        this.q=null
        this.busy=false
        })
        .catch(error=> {
          console.log(error);
          this.busy=false
          alert("Get query error"+url)
        });
      
    },
    clearq(){
      this.q=null
    },
	  action(b){
	      b.method(b.icon)
	  },
	  clip(icon){
	    this.clipboard=icon
	  },
    add(){
      alert("add")
    },
    setfilter(){
      console.log("TODO",this.q)
      this.$router.push({  query: {url:this.url,q:this.q }})
    },
    info(item){
      this.showInfo=true
    },
    invoke(){
      HTTP.post("eval/invoke",Qs.stringify({path:this.url+this.selection[0].name}))
      .then(r=>{
        var job=r.data.job
        console.log(r.data)
         this.$router.push({ name: 'jobShow', params: {job:job }})
      })
    },
   todo(icon){
      alert("todo: " + icon)
     },
   itemClass(item){
       return (item.selected)?"blue--text text--darken-2":""
     }, 
   itemIcon(item){
       if(item.selected) return "check_circle"
       else return (item.type=="folder")?"folder":"insert_drive_file"
     },
    selectAll(){
       this.items.forEach(item=>{item.selected=true})
     },
    selectNone(){
       this.items.forEach(item=>{item.selected=false})
     }
  },
  computed: {
   icon(){
        return (this.protocol=="xmldb")?"developer_mode":"folder"
      },
   xfiles(){
        return this.items.filter(item=>{return item.type!="folder" &&((!this.q) || item.name.includes(this.q))})
      },
   xfolders(){
        return this.items.filter(item=>{return item.type=="folder" &&((!this.q) || item.name.includes(this.q))})
      },   
   // array of {name:"that", path:"/this/that/"} for url
   crumbs(){
        var parts=this.url.split("/").filter((a)=>a.length>0)
        var a=parts.map(
            function(v,i,a){return {name:v,  path:"/"+a.slice(0,i+1).join("/")+"/"}}
            )
        return a  
      },
   selection(){
        return this.items.filter(item=>{return item.selected} ) 
      }
  },
  watch:{
    url(v){
      this.$router.push({  query: { url: this.url }})
      },
      $route(vnew,vold){
        //console.log("ROUTE",vnew,vold)    
        var url=this.$route.query.url
        this.url=url?url:"/";
        if(vnew.query.url != vold.query.url) this.load() 
      }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:"/";
    this.q=this.$route.query.q || this.q
    this.load()
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/collection/history.vue
const History=Vue.extend({template:` 
 <v-container fluid="">
    <v-list>
            <v-list-tile v-for="item in items" v-bind:key="item.title" @click="doEdit(item)" avatar="">
              <v-list-tile-action>
               <v-chip v-text="item.protocol">Example Chip</v-chip>
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
        router.push({ path: 'edit', query: { url:item.url, protocol:item.protocol  }})
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/edit/edit.vue
const Edit=Vue.extend({template:` 
<v-container fluid="">
      <v-snackbar top="" color="error" v-model="snackbar">
      {{ message }}
      <v-btn flat="" @click="snackbar = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-snackbar>
    
<v-card>
<v-toolbar dense="">
<v-tooltip top="">
<v-menu slot="activator">

  <v-btn color="primary" icon="" slot="activator"><v-icon>{{icon}}</v-icon></v-btn>
  <v-list>
      <v-list-tile v-for="(item,index) in path" :key="index">
        <v-list-tile-content @click="showfiles()">
        <v-list-tile-title>{{ item }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
  </v-list>
</v-menu>
<span>{{ path.join('/') }}</span>
</v-tooltip>
  
   <v-badge right="" v-model="dirty">
     <span slot="badge">*</span>
     <v-toolbar-title>{{ name }}</v-toolbar-title>
     </v-badge>
     <v-btn v-if="dirty" icon="" @click="save()">
      <v-icon>file_upload</v-icon>
    </v-btn>
    <v-spacer></v-spacer>

  <v-menu left="" transition="v-fade-transition">
      <v-chip label="" small="" slot="activator">{{ mode }}</v-chip>
          <v-list dense="">
              <v-list-tile v-for="(mode, mimetype) in mimeTypes" :key="mimetype">
                <v-list-tile-title v-text="mimetype" @click="setMode(mimetype)"></v-list-tile-title>
              </v-list-tile>           
          </v-list>         
   </v-menu>
   
  <v-tooltip top="">
     <v-chip @click="acecmd('goToNextError')" slot="activator">
            <span class="red ">{{annotations &amp;&amp; annotations.error}}</span>
            <span class="yellow ">{{annotations &amp;&amp; annotations.warning}}</span>   
            <span class="green ">{{annotations &amp;&amp; annotations.info}}</span>
 
           <v-avatar>
              <v-icon black="">navigate_next</v-icon>
           </v-avatar>
      </v-chip>
      <span>Annotations: Errors,Warning and Info</span>
   </v-tooltip>
<v-spacer></v-spacer>
   <v-btn icon="" @click="acecmd('outline')" title="outline -todo">
      <v-icon>label_outline</v-icon>
    </v-btn>

  <v-menu left="" transition="v-fade-transition">
      <v-btn icon="" slot="activator" title="display settings">
        <v-icon>playlist_play</v-icon>
      </v-btn>
     
      <v-list dense="">
           <v-subheader>Display settings</v-subheader>
         
           <v-list-tile @click="togglefold" avatar="">
             <v-list-tile-avatar>
                   <v-icon>vertical_align_center</v-icon>
              </v-list-tile-avatar>
              <v-list-tile-title>Toggle folds</v-list-tile-title>
           </v-list-tile>
           
           <v-list-tile @click="wrap=!wrap" avatar="">
             <v-list-tile-avatar>
                   <v-icon>wrap_text</v-icon>
              </v-list-tile-avatar>
              <v-list-tile-title>Soft wrap</v-list-tile-title>
           </v-list-tile>
             <v-divider></v-divider>
              <v-subheader>Help</v-subheader>
             <v-list-tile @click="acecmd('showSettingsMenu')" avatar="">
               <v-list-tile-avatar>
              <v-icon>settings</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title @click="acecmd('showSettingsMenu')">Show ACE settings</v-list-tile-title>
            </v-list-tile>
                      
            <v-list-tile @click="acecmd('showKeyboardShortcuts')" avatar="">
              <v-list-tile-avatar>
              <v-icon>keyboard</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title @click="acecmd('showKeyboardShortcuts')">Show ACE keyboard shortcuts</v-list-tile-title>
            </v-list-tile>          
      </v-list>
    </v-menu>
    
    <v-btn icon="" @click="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn icon="" @click="clearDialog = true">
      <v-icon>delete</v-icon>
    </v-btn>
      
    <v-menu left="" transition="v-fade-transition">
      <v-btn icon="" slot="activator">
        <v-icon>more_vert</v-icon>
      </v-btn>
     
          <v-list dense="">
               <v-list-tile @click="acecmd('showSettingsMenu')" avatar="">
               <v-list-tile-avatar>
              <v-icon>settings</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title @click="acecmd('showSettingsMenu')">Show ACE settings</v-list-tile-title>
            </v-list-tile>
                      
            <v-list-tile @click="acecmd('showKeyboardShortcuts')" avatar="">
              <v-list-tile-avatar>
              <v-icon>keyboard</v-icon>
            </v-list-tile-avatar>
              <v-list-tile-title @click="acecmd('showKeyboardShortcuts')">Show ACE keyboard shortcuts</v-list-tile-title>
            </v-list-tile>          
          </v-list>
          
      </v-menu>
    
     
 </v-toolbar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>

<v-card-text v-if="!busy">
<v-flex xs12="" style="height:70vh" fill-height="">
  
    <vue-ace :content="contentA" :mode="mode" :wrap="wrap" :settings="aceSettings" :events="events" v-resize="onResize" v-on:change-content="changeContentA" v-on:annotation="annotation"></vue-ace>
 </v-flex> 
</v-card-text>
</v-card>
 <qd-confirm v-model="clearDialog" @confirm="reset">Delete all edit text?</qd-confirm>
 </v-container>
 `,
      
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

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/entity.vue
const Entity=Vue.extend({template:` 
 <v-container fluid="">
Entities
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/eval/eval.vue
const Eval=Vue.extend({template:` 
 <v-container fluid="">
  <v-card @keyup.ctrl.enter="submit">
     <v-toolbar dense="">
     
     <v-menu offset-x="">
       <v-btn slot="activator" flat="" icon="" color="pink">
              <v-icon>label_outline</v-icon>
        </v-btn>
        <v-card>
       <v-card-title>Outline here</v-card-title>
       </v-card>
    </v-menu>
    
      <v-menu offset-x="">
       <v-btn slot="activator" flat="" icon="" color="pink">
              <v-icon>add_circle</v-icon>
            </v-btn>
            <v-card>
       <v-btn @click="imports">
    <v-icon>library_books</v-icon>
    Imports</v-btn>
     <v-btn @click="namespaces">
    <v-icon>label</v-icon>
    Namespaces</v-btn>
    </v-card>
    </v-menu>
      <v-spacer></v-spacer>
    <v-btn @click="submit">
      <v-icon>play_circle_outline</v-icon>jobs:run
      </v-btn>
    <v-menu offset-y="">
      <v-btn slot="activator" flat="" icon="">
         <v-icon>more_vert</v-icon>
      </v-btn>
      <v-list dense="">
         <v-subheader>More actions...</v-subheader>
        <v-divider></v-divider>
        
        <v-list-tile @click="run">
          <v-list-tile-title>xquery:eval</v-list-tile-title>
        </v-list-tile>
        
         <v-list-tile @click="plan">
          <v-list-tile-title>Show query plan</v-list-tile-title>
        </v-list-tile>
        
        <v-list-tile @click="hitme">
         <v-list-tile-title>Test large result.</v-list-tile-title>
         </v-list-tile>
     </v-list>
    </v-menu>
   
   
    
   </v-toolbar>

  
  <v-card-text>
  <v-flex xs12="" style="height:200px" fill-height="">
  <vue-ace :content="xq" mode="xquery" wrap="true" v-on:change-content="onChange" :settings="aceSettings"></vue-ace>
    </v-flex>
   </v-card-text>
   
     <v-card-actions v-if="show">
       <v-chip class="primary white--text">{{job.id}}</v-chip>
           <v-chip class="primary white--text">{{job.job}}</v-chip>
      
           <v-chip label="" class="grey white--text"> 
           <v-avatar class="red">  <v-icon>lock</v-icon>W</v-avatar>
           {{ jobState.writes }}</v-chip>
           
            <v-chip label="" class="grey white--text"> 
	            <v-avatar class="amber"> <v-icon>lock</v-icon>R</v-avatar>
	            {{ jobState.reads }}</v-chip>
 
        <v-spacer></v-spacer>
          <v-progress-circular v-if="waiting" indeterminate="" class="primary--text"></v-progress-circular>
          <v-chip>{{ jobState.state }}</v-chip>
         <v-chip class="primary white--text">
          <v-avatar>  <v-icon>timer</v-icon></v-avatar>
         {{elapsed}}ms</v-chip>
         
    </v-card-actions>
    <v-card-text v-if="showError">
     <v-alert color="error" v-model="showError">Error </v-alert>
    </v-card-text>
    
     <v-card-text v-if="showResult">
		     <v-flex xs12="" style="height:200px" fill-height="">
		        <vue-ace :content="result" mode="text" wrap="false" read-only="true" :settings="aceSettings"></vue-ace>
        </v-flex> 
     </v-card-text>
       
       <v-card-text>
       BEFORE<vp-job :job="job" :result:="result" :job-state="jobState" :elapsed="elapsed">IN</vp-job>AFTER
       </v-card-text>
       
    </v-card>

 </v-container>
 `,
      

  data:  function(){
    return {
      xq: '(: type your XQuery :)\n',
      result: null,
      elapsed: null,
      show: false,
      showError: false, 
      showResult: false, //
      job: {}, // {id:"12",job:"job13", dateTime:""}
      waiting: false,
      destroyed: false,
      start: null,
      jobState: {},
      aceSettings:{}
      }
  },
  methods:{
    onChange(val){
      if (this.xq !== val) {
        this.xq = val
      }
    },
    
    run(){
      this.awaitResult(false)
      this.start = performance.now();
      HTTPNE.post("eval/execute",Qs.stringify({xq:this.xq}))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=r.data.result
        this.jobId=null
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
      localforage.setItem('eval/xq', this.xq)
    },
    submit(){
      this.showError=this.showResult=this.show=false
      this.start = performance.now();
      HTTPNE.post("eval/submit",Qs.stringify({xq:this.xq}))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.job=r.data
        this.show=true
        this.pollState()
        
      })
      .catch(r=> {
        alert("catch")
        console.log("error",r)
        this.job=r.response.job
        this.showError=true;

      });
    },
    pollState(){
      if(this.destroyed)return;
      this.waiting=true;
      HTTP.get("job/"+this.job.job)
      .then(r=>{
        this.jobState=r.data
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
      this.awaitResult(true)
       HTTPNE.post("eval/result/"+this.job.job)
       .then(r=>{
         this.result=r.data.result+" "
       }).catch(r=> {
        // alert("catch")
         console.log("error",r)
         this.result=r.response.data
         this.showError=true;

       });
    },
    hitme(){
      this.showResult=true
      setTimeout(()=>{this.result="123\n".repeat(20000); },10);

    },
    imports(){
      alert("@TODO imports")
    },
    namespaces(){
      alert("@TODO namespaces")
    },
    plan(){
      this.awaitResult(true)
      HTTPNE.post("eval/plan",Qs.stringify({xq:this.xq}))
      .then(r=>{
        this.result=r.data.result
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
    },
    awaitResult(show){
      // ace slow when setting large text while hidden
      this.showError=false
      this.show=show
      this.result="(Please wait..)"
      this.showResult=true
    }
  },
  computed: { 
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
      console.log("eval: creatd");
      localforage.getItem('eval/xq').then((value) => { this.xq=value || this.xq});
  },
  beforeDestroy:function(){
    this.destroyed=true;
    console.log("eval: before destroy");
}
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/home.vue
const Home=Vue.extend({template:` 

<v-card hover="" raised=""> 
<v-card-title class="pa-5 indigo">
<div class="display-1 white--text text-xs-center">VUE-POC</div>
<v-spacer></v-spacer>
  <v-speed-dial v-model="fab" hover="" right="" direction="bottom" transition="slide-y-reverse-transition">
      <v-btn slot="activator" class="blue darken-2" dark="" fab="" hover="" v-model="fab">
        <v-icon>account_circle</v-icon>
        <v-icon>close</v-icon>
      </v-btn>
      <v-btn fab="" dark="" small="" class="green">
        <v-icon>edit</v-icon>
      </v-btn>
      <v-btn fab="" dark="" small="" class="indigo">
        <v-icon>add</v-icon>
      </v-btn>
      <v-btn fab="" dark="" small="" class="red">
        <v-icon>delete</v-icon>
      </v-btn>
    </v-speed-dial>
 </v-card-title> 

 <v-card-text>
 
<p>
	links
</p>
<ul>

<li><router-link :to="{path:'files', query:{url:'/vue-poc/'}}">vue-poc files</router-link></li>
<li><router-link :to="{path:'database', query:{url:'/vue-poc/'}}">vue-poc db</router-link></li>
	<li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
	<li><a href="/dba" target="new">DBA app</a></li>
	<li><a href="/vue-poc/ui/database?url=%2Fvue-poc%2F" target="new">db</a></li>
<li><router-link :to="{path:'files', query:{url:'/vue-poc/features/images/'}}">vue-poc image tasks</router-link></li>
</ul>

<v-btn floating="floating"> <v-icon>add</v-icon> 
</v-btn> <qd-link href="/dba">REPLACED</qd-link> 
  
    </v-card-text> 
</v-card> 
	 `,
      
    data:  function(){
      return { 
              fab: false
      }
  }
  }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/dates.vue
const Dates=Vue.extend({template:` 
 <v-container fluid="">
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
     <v-chip>Images by year and month</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  
    </v-toolbar>
    <v-card-text>
     <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
<v-container v-if="!busy" fluid="">
 <v-layout v-for="year in items" :key="year.year">
      <v-flex v-text="year.year"></v-flex> 
      <v-flex v-for="(m,i) in year.months" :key="i"><v-btn icon="" color="primary" :disabled="0==m" @click="go(year.year,i)">{{m}}</v-btn></v-flex>       
  </v-layout>            
</v-container>
<v-layout>
 </v-layout></v-card-text>
 </v-card>
 </v-container>
 `,
        
  data: ()=>({
    busy: false,
    total: 0,
    items: [],
    elapsed: null,
    months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  }),

  methods:{
    getDatetaken(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("images/datetaken")
      .then(r=>{
        this.busy=false
        this.total=r.data.total
        this.items=r.data.items
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    },
    go(year,month){
     
      month=("0" + (1+month)).slice(-2)
      // alert("year: "+year+" "+month)
      var from=year + "-" + month + "-01"
      var lastday=new Date(year, month, 0).getDate()
      var until=year + "-" + month + "-"+ lastday
        this.$router.push({ name: 'images', query: { from:from, until:until }})
    }
  },
  created:function(){
    console.log("create datetaken")
    this.getDatetaken()
  }
    }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/image.vue
const Image=Vue.extend({template:` 
 <v-container fluid="">
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
     <v-chip> {{ image.name }}</v-chip>   
    </v-card-title>
     <span> {{ image.path }}</span>   
    <v-spacer></v-spacer> 
      <span class="white--text">Image: {{ id }}</span>      
    <a :href="path" :download="id +'.jpg'"><v-icon>file_download</v-icon></a>
    </v-toolbar>
    <v-card-text>
 <v-layout>
		 <v-flex xs5="">
		<pre style="overflow:auto;">{{ image.doc }}</pre>
		  <a :href="meta" target="_new">full metadata</a>
		 </v-flex>
		 
		 <v-flex xs7="">
		 <iframe :src="path" style="border:0;width:100%;height:100%;min-height:400px;">image</iframe>
		 </v-flex>
 </v-layout>
 </v-card-text>
 </v-card>
 </v-container>
 `,
        
  props:["id"],
  data: ()=>( {
    image:{},
    loaded:false
  }),
  computed: {
    path(){
    return this.loaded?'/vue-poc/api/images/list/'+ this.id+ '/image':null
    },
    meta(){
      return this.loaded?'/vue-poc/api/images/list/'+ this.id+ '/meta':null
      }
},
  created:function(){
   var id=this._props.id
   HTTP.get("images/list/"+id)
   .then(r=>{
     this.image=r.data
     this.loaded=true
     })
  }
    }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/images.vue
const Images=Vue.extend({template:` 

      <v-card>
      <v-toolbar dense="">
      <v-btn @click.stop="showFilter = true" icon=""><v-icon>search</v-icon></v-btn>
        <v-toolbar-title>{{ qtext }}</v-toolbar-title>
        <v-tooltip top="" v-if="query.keyword || query.from || query.until">      
        <v-btn @click="clear" icon="" slot="activator">
            <v-icon>clear</v-icon>
           </v-btn>
         <span>Clear search</span>
         </v-tooltip>
           <v-btn icon="" @click="getImages">
                    <v-avatar>
                      <v-icon>refresh</v-icon>
                     </v-avatar>
                  </v-btn>
           <v-spacer></v-spacer>
           <span v-if="!busy">
              <v-toolbar-items v-if="!selection.length">
							   <v-btn icon="" v-for="b in buttons" :key="b.icon" @click="action(b)">
							      <v-avatar>
							        <v-icon v-text="b.icon"></v-icon>
							       </v-avatar>
							    </v-btn>
          </v-toolbar-items>
          <v-toolbar-items v-if="selection.length">
                 <v-btn icon="" v-for="b in selopts" :key="b.icon" @click="action(b)">
                    <v-avatar>
                      <v-icon v-text="b.icon"></v-icon>
                     </v-avatar>
                  </v-btn>
          </v-toolbar-items>
          </span>
           <v-spacer></v-spacer>
          <v-toolbar-items>
          <v-btn @click.stop="pageBack()" :disabled="query.page==0" icon="">
           <v-avatar>
           <v-icon>arrow_back</v-icon>
           </v-avatar>
           </v-btn>
           <v-btn @click.stop="pageNext()" icon="">
            <v-avatar>
            <v-icon>arrow_forward</v-icon>
            </v-avatar>
           </v-btn>
         </v-toolbar-items>
        
        </v-toolbar>
        <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
        <v-container v-if="!busy" fluid="" grid-list-md="">
          <v-layout row="" wrap="" v-touch="{ left: () => pageNext(), right: () => pageBack()}">
            <v-flex height="80px" xs2="" v-for="image in images" :key="image.name">
              <v-card flat="" tile="" class="grey lighten-2 pa-1">
                <v-card-media :src="src(image)" @dblclick="go(image)" @click.prevent.stop="image.selected =! image.selected " height="100px" contain="">
                 <span v-if="image.keywords >0 ">#{{image.keywords}}</span>
                 <v-avatar icon="" small="" v-if="image.geo">
                  <v-icon>place</v-icon>
                </v-avatar>
                
               
                </v-card-media>
                
            <div v-if="image.selected" style="position:absolute;right:0;top:0">
                 <v-icon class="white primary--text">check_circle</v-icon>
                 </div>
            </v-card></v-flex>
          </v-layout>
        </v-container>

 <v-navigation-drawer left="" fixed="" v-model="showFilter" :disable-route-watcher="true">
         <v-card>
          <v-toolbar class="green white--text">
                <v-toolbar-title>Show images with...</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn @click="showFilter = false" icon=""><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          
        <v-card-text>    
         <v-select v-bind:items="keywords" v-model="query.keyword" label="Keyword" item-value="text" item-text="text" autocomplete="" clearable="">
             <template slot="item" slot-scope="data">
                  <v-list-tile-content>
                    <v-list-tile-title v-html="data.item.text"></v-list-tile-title>
                    <v-list-tile-sub-title v-html="data.item.count"></v-list-tile-sub-title>
                  </v-list-tile-content>
              </template>
            </v-select>
            
          <v-menu lazy="" :close-on-content-click="false" v-model="menu2" transition="scale-transition" offset-y="" full-width="" :nudge-left="40" max-width="290px">
             <v-text-field slot="activator" label="Earliest date" v-model="query.from" prepend-icon="event" readonly=""></v-text-field>
         
          <v-date-picker v-model="query.from" scrollable="" actions="">
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn flat="" color="primary" @click="cancel()">Cancel</v-btn>
                <v-btn flat="" color="primary" @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
            
         
          </v-date-picker></v-menu>
          
           <v-menu lazy="" :close-on-content-click="false" v-model="showUntil" transition="scale-transition" offset-y="" full-width="" :nudge-left="40" max-width="290px">
           
            <v-text-field slot="activator" label="Latest date" v-model="query.until" prepend-icon="event" readonly=""></v-text-field>
         
          <v-date-picker v-model="query.until" scrollable="" actions="">
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn flat="" color="primary" @click="cancel()">Cancel</v-btn>
                <v-btn flat="" color="primary" @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-date-picker>
          </v-menu>
        
            <v-checkbox :value="location.value" :indeterminate="location.use" @click="cyclelocation" label="With location:"></v-checkbox>
        
        </v-card-text>
        
        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn @click="showFilter = false" color="primary">Apply</v-btn>
        </v-card-actions>
      </v-card>
      </v-navigation-drawer>
        <v-navigation-drawer left="" fixed="" v-model="showInfo" :disable-route-watcher="true">
               <v-card> 
                 <v-toolbar class="green white--text">
                <v-toolbar-title>{{selection.length}} selected</v-toolbar-title>
                <v-spacer></v-spacer>    
                 <v-btn flat="" icon="" @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
              </v-toolbar>
              <v-card-text> 
               <ul>
            <li v-for="sel in selection" :key="sel.name">
            {{sel.name}} {{sel.path}}
            </li>
          </ul>
                </v-card-text> 
             </v-card>
      </v-navigation-drawer>
      
      </v-card>
 
 `,
       
  
  data(){ 
    return {
    images:[],
    query: {page:0,  // current page
           from:null,
           until:null,
           keyword:null
    },
    total: null,
    elapsed: null,
    showFilter: false,
    busy: false,
    menu2: false,
    showUntil: false,
    keywords: [],
    showInfo: false,
    selitem: "TODO",
    location: {use:false,value:true},
    buttons: [
     
      {method: this.selectAll, icon: "select_all"}     
  ],
  selopts: [
    {method: this.selectNone, icon: "select_all"},
    {method: ()=>{this.showInfo= ! this.showInfo}, icon: "info"},
    {method: this.share, icon: "share"}
 ]
  }
    },
  methods:{
    src(item){
        return "data:image/jpeg;base64,"+item.data
    },
    cyclelocation(){
      this.location.use=!this.location.use
    },
    getImages(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("images/list",{params:this.query})
      .then(r=>{
        this.busy=false
        this.total=r.data.total
        this.images=r.data.items
        var t1 = performance.now();
        var elapsed= 0.001 *(t1 - t0);
        var round = Vue.filter('round');
        this.$notification.add("Found " + this.total + " in : "+ round(elapsed,1) +" secs");
        }) 
    },
    slideShow(){
      alert("slideshow not yet");
    },
    clear(){
      this.query.from=null;
      this.query.until=null;
      this.query.keyword=null;
      this.query.page=0;
    },
    selectAll(){
      this.images.forEach(item=>{item.selected=true})
    },
   selectNone(){
      this.images.forEach(item=>{item.selected=false})
    },
    selected(image){
      this.selitem=image;
      this.showInfo=true;
    },
    action(b){
      b.method(b.icon)
    },
    share(){
      alert("sHARE: "+ this.selection.length);
    },
    isChanged(vnew,vold){
      if(vnew.keyword != vold.keyword) return true
      if(vnew.from != vold.from) return true
      if(vnew.until != vold.until) return true
      return false
    },
    go(image){
      this.$router.push({ name: 'image', params: { id: image.id }})
    },
    pageBack(){
      this.query.page=Math.min(0,this.query.page-1)
    },
    pageNext(){
      this.query.page+=1
    }
   
  },
  computed:{
    qtext(){
          var k=this.query.keyword,f=this.query.from, u=this.query.until
          var t= (k?" keyword:'"+k+"'":"")+ (f?" from:" + f:"")+ (u?" until:" + u:"")
          return t?t:"(All)"
    },
    selection(){
      return this.images.filter(item=>{return item.selected} ) 
    }
  },
  watch:{
      "query":{
        handler:function(vnew,vold){
          var b=this.isChanged(vnew,vold)
          console.log("watch",b,vnew,vold)
          if(b) this.query.page=0
          this.$router.push({  query: this.query })
          },
        deep:true
      },
      
      $route(v){
        this.getImages()
      },
      
      showFilter(){
        if(this.keywords.length==0){
          HTTP.get("images/keywords2")
          .then(r=>{
            this.keywords=r.data.items
            }) 
        }
      }
  },
  created:function(){
    console.log("create images")
    this.query.page=Number(this.$route.query.page) || this.query.page
    this.query.keyword=this.$route.query.keyword || this.query.keyword
    this.query.from=this.$route.query.from || this.query.from
    this.query.until=this.$route.query.until || this.query.until
    this.getImages()
    
  },
  mounted:function(){
    console.log("images mount")
    
  }
    }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/ireport.vue
const Report=Vue.extend({template:` 
 <v-container fluid="">
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
     <v-chip>todo</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  
    </v-toolbar>
     <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
    <v-card-text v-if="!busy" v-html="report"></v-card-text>
 </v-card>
 </v-container>
 `,
      
  data: ()=>({
    busy: false,
    report: null,
    elapsed: null
  }),
  methods:{
    get(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("images/report")
      .then(r=>{
        this.busy=false
        this.report=r.data
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    }
  },
  created:function(){
    console.log("reports")
    this.get()
  }
    }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/keywords.vue
const Keywords=Vue.extend({template:` 
 <v-container fluid="">
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
     <v-chip>click to show</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  <v-text-field prepend-icon="search" label="Filter..." v-model="q" type="search" hide-details="" single-line="" @keyup.enter="setfilter" :append-icon="this.q?'clear':''" :append-icon-cb="e=>this.q=''"></v-text-field>
    </v-toolbar>
    <v-card-text>
    <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
        <v-container v-if="!busy" fluid="" grid-list-md="">
          <v-layout row="" wrap="" v-touch="{ left: () => pageNext(), right: () => pageBack()}">
            <v-flex height="80px" @click="show(keyword)" xs3="" v-for="keyword in items" :key="keyword.text">
              <v-card class="grey lighten-2 pt-1">
                       <v-toolbar>
                 <v-card-title v-text="keyword.text"></v-card-title>
                <v-spacer></v-spacer>
                <v-chip>{{keyword.count}}</v-chip>
              </v-toolbar>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
 </v-card-text>
 </v-card>
 </v-container>
 `,
      
  data: ()=>({
    busy: false,
    total: 0,
    items: [],
    elapsed: null,
    q:""
  }),

  methods:{
    getKeywords(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("images/keywords2")
      .then(r=>{
        this.busy=false
        this.total=r.data.total
        this.items=r.data.items
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    },
    show(keyword){
      this.$router.push({ name: 'images', query: { keyword: keyword.text }})
    },
    setfilter(){
      alert("not yet")
    }
  },
  created:function(){
    console.log("create keywords")
    this.getKeywords()
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/people.vue
const People=Vue.extend({template:` 
 <v-container fluid="">
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
     <v-chip>todo</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  
    </v-toolbar>
    <v-card-text>
people
 </v-card-text>
 </v-card>
 </v-container>
 `,
        
 
    }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/job/job.vue
const Job=Vue.extend({template:` 
  <v-card>
   <v-toolbar>
      <v-btn icon="" to="./"><v-icon>arrow_back</v-icon></v-btn>
      <v-toolbar-title>{{ job }}</v-toolbar-title>
    
     <v-btn v-if="!finished" @click="stop()" :disabled="finished">Stop</v-btn>
     <v-btn v-if="finished &amp;&amp; !result" @click="getResult()" :disabled="result || !finished">Result</v-btn>
    <v-chip class="orange white--text">{{  jobstate.state }}</v-chip>
  
        <v-chip label="" class="grey white--text"><v-icon class="red">lock</v-icon>{{  jobstate.writes }}</v-chip>
       <v-chip label="" class="grey white--text"><v-icon class="amber">lock</v-icon>{{  jobstate.reads }}</v-chip>
      <v-spacer></v-spacer>
       <v-chip class="primary white--text">
      <v-avatar>
        <v-icon>account_circle</v-icon>
      </v-avatar>
     {{  jobstate.user }}</v-chip>
       <v-chip class="green white--text">
        <v-avatar><v-icon>timer</v-icon></v-avatar>
       {{  jobstate.duration }}</v-chip>
      <v-btn icon="" :loading="loading" @click="getJob()" :disabled="loading || finished">
         <v-icon>refresh</v-icon>
    </v-btn>     
    </v-toolbar>
    
    <v-card-text v-if="result">
     {{ result }}
  </v-card-text>
  
  <v-card-text>
     <code>{{ jobstate.text }}</code>
  </v-card-text>
  
 </v-card>
 `,
      
  props: ['job'],
  data:  function(){
    return {
      jobstate:{state:"?",user:"?",duration:"?"},
      result:null,
      loading:false,
      timer:null
      }
  },
  methods:{
    getJob(){
      this.loading=true;
	    HTTP.get("job/" + this.job )
	    .then(r=>{
	       this.loading=false
	       this.jobstate=r.data
	       if(!this.jobstate.id) this.jobstate={state:"cached", text:"Job not found"}
	       if(!this.finished)this.timer=setTimeout(()=>{ this.getJob() }, 10000);
	    })
	   
    },
    getResult(){
      HTTP.post("eval/result/"+this.job)
      .then(r=>{
        this.result=r.data.result
    })
    },
    stop(){
      alert("todo stop" + this.job)
    }
  },
  computed: {
    finished(){
      return this.jobstate.state == 'cached'
      }
  },
  created(){
    this.getJob()
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/job/jobs.vue
const Jobs=Vue.extend({template:` 
  <v-card>
   <v-toolbar>
     
    
     <v-btn @click="stop()" :disabled="noSelection">Stop</v-btn>
    <v-text-field append-icon="search" label="Filter jobs" single-line="" hide-details="" v-model="search"></v-text-field>
      <v-btn icon=""><v-icon>add</v-icon></v-btn>   
      <v-spacer></v-spacer>
      
       <v-btn icon="" :loading="loading" @click="getJobs()" @dblclick="autorefresh = !autorefresh" :disabled="loading">
    <v-icon>{{ autorefresh?'refresh':'arrow_downward' }}</v-icon>
    </v-btn>
    </v-toolbar>
  <v-data-table :headers="headers" :items="items" :search="search" v-model="selected" select-all="" class="elevation-1" no-data-text="No Jobs currently running">
    <template slot="items" scope="props">
    <td class="vtop">
        <v-checkbox primary="" hide-details="" v-model="props.selected"></v-checkbox>
      </td>
      <td class="vtop">  <router-link :to="{name: 'jobShow', params: {job: props.item.id }}">{{props.item.id}}</router-link></td>
      <td class="vtop "><div>{{ props.item.state }}</div>
                                     <div>{{ props.item.type }}</div> </td>
      <td class="vtop text-xs-right">{{ props.item.duration }}</td>
       <td class="vtop text-xs-right">{{ props.item.writes }}</td>
        <td class="vtop text-xs-right">{{ props.item.reads }}</td>
      <td class="vtop text-xs-right">{{ props.item.user }}</td>
       <td class="vtop"><code class="multiline-ellipsis">{{ props.item.text }}</code></td>
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
        { text: 'WriteL', value: 'writes' },
        { text: 'ReadL', value: 'reads' },
        { text: 'User', value: 'user' },
        { text: 'Query', value: 'text' }
      ],
      items:[        
      ],
      selected: [],
      search: "",
      loading: false,
      autorefresh: true,
      timer:null
      }
  },
  methods:{
    getJobs(){
      this.loading=true;
	    HTTP.get("job")
	    .then(r=>{
	       this.loading=false
	       this.items=r.data
	       if(this.autorefresh) this.timer=setTimeout(()=>{ this.getJobs() }, 10000);
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
    },
  },
  created(){
    this.getJobs()
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/login/login.vue
const Login=Vue.extend({template:` 
<v-card class="grey lighten-4 elevation-0">

      <v-card-title class="green darken-1">
        <span class="white--text">Login</span>
      </v-card-title>
    <v-alert color="error" v-bind:value="showMessage">
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
       <v-btn color="primary" @click="go()">Continue</v-btn>
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
       var data={
             username: this.name, //gave the values directly for testing
             password: this.password,
             redirect: this.redirect
             }
       HTTP.post("login-check",Qs.stringify( data))
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/namespace.vue
const Namespace=Vue.extend({template:` 
 <v-container fluid="">
namespaces
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/ping/ping.vue
const Ping=Vue.extend({template:` 
 <v-container fluid="">
 <v-card>
 <v-toolbar>
 <v-toolbar-title>Simple performance measure</v-toolbar-title>
 <v-spacer></v-spacer>
 <v-btn @click="reset()">Reset</v-btn>
 </v-toolbar>
 <v-card-text>
  <p>Read or increment a database value. This measures round trip times browser-database-browser.</p>
  <p>Counter:{{counter}}</p>
  <table class="table">
      <thead> 
        <tr>
         <th>Action</th>
          <th>Once</th>
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
              <td>Get</td>
              <td>
               <v-btn @click="get()" icon="">
                   <v-icon>radio_button_checked</v-icon>
                </v-btn>
             
               </td>
               <td>
                <v-switch v-on:change="gchange" v-model="repeat.get"></v-switch>

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
             <td>Update</td>
          <td>
           <v-btn @click="update()" icon="">
                   <v-icon>radio_button_checked</v-icon>
            </v-btn>
          </td>
          
          <td>
           <v-switch v-on:change="pchange" v-model="repeat.post"></v-switch>
          </td>
           <td class="col-md-1">
                        <span>{{postValues.last}}</span>
                    </td>
          <td class="col-md-1">
            <span>{{postValues.count}}</span>
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
            <td class="col-md-1">
                        <span>{{postValues.median}}</span>
           </td>
        </tr>
      </tbody>
    </table>
    </v-card-text>
    </v-card>
    
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
    },
    gchange(v){
      if(v)this.get() 
    },
    pchange(v){
      if(v)this.update() 
    },
    reset(){
      Object.assign(this.getValues,this.getValues.clear());
      Object.assign(this.postValues,this.postValues.clear());
      this.$forceUpdate()
    }
  },
  computed: {
   
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/puzzle.vue
const Puzzle=Vue.extend({template:` 
 <v-container fluid="">
  <v-layout>
 
  <table>
   <tbody><tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:3em;">
    <v-btn @click="click(row,col)" :disabled="disabled(row,col)">{{cell}}</v-btn>
    </td>
   </tr>
  </tbody></table>
   <br>
   <table>
   <tbody><tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:50px;height:50px;" @click="click(row,col)">
    <img :src="src(row,col)" style="width:50px;height:50px;">
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
      if(this.disabled(row,col))return;
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/repository.vue
const Repo=Vue.extend({template:` 
 <v-container fluid="">
  <v-card>
   <v-toolbar>
    <v-text-field append-icon="search" label="Filter repo" single-line="" hide-details="" v-model="search"></v-text-field>   
      <v-spacer></v-spacer>     
    </v-toolbar>
<v-data-table :headers="headers" :items="items" :search="search" v-model="selected" select-all="" class="elevation-1" no-data-text="No repo found @todo">
    <template slot="items" scope="props">
    <td class="vtop">
        <v-checkbox primary="" hide-details="" v-model="props.selected"></v-checkbox>
      </td>
      <td class="vtop">{{ props.item.name }}</td>
      <td class="vtop "><div>{{ props.item.permission }}</div>
    </td></template>
  </v-data-table>
  </v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      loading: false,
      items: [],
      search: null,
      selected: [],
      headers: [
        {
          text: 'Name',
          left: true,
          value: 'id'
        },
        { text: 'Permission', value: 'state' }
      ] 
      }
  },
  methods:{
      getUsers(){
        this.loading=true;
        HTTP.get("repo")
        .then(r=>{
           this.loading=false
           this.items=r.data
        })
     }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/search.vue
const Search=Vue.extend({template:` 
 <v-container fluid="">
 <v-alert color="warning" value="true">Not finished</v-alert>
 <v-text-field label="Search..." v-model="q" v-on:keyup="send"></v-text-field> 
  <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
  <v-layout>
    <v-flex>
    <v-list v-if="!busy" two-line="" subheader="">
      
        <v-list-tile v-for="(item,index) in results" v-bind:key="item.uri" :to="item.uri" v-model="selected[index]" avatar="">
          <v-list-tile-avatar @click.prevent.stop="select(index)">
            <v-icon v-text="icon(index)"></v-icon>
          </v-list-tile-avatar>
          <v-list-tile-content>
            <v-list-tile-title>{{ index }} {{ item.title }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ item.uri }}</v-list-tile-sub-title>
          </v-list-tile-content>
          <v-list-tile-action>
            <v-btn icon="" ripple="">
              <v-icon class="grey--text text--lighten-1">info</v-icon>
            </v-btn>
          </v-list-tile-action>
        </v-list-tile>
     </v-list>
     </v-flex>
     </v-layout>
 </v-container>
 `,
      
  data:  function(){
    return {
      q: this.$route.query.q,
      results: [],
      busy: false,
      selected: []
      }
  },
  methods:{
    get() {
      this.busy= true
      console.log("q",this.q)
      HTTP.get('search',{params:{q:this.q}})
      .then((res) => {
        this.busy=false
        this.results = res.data.items;
        this.selected=[false,true]
      });
    },
    send(e){
      if(e.keyCode==13){
        this.get()
      }
    },
    icon(index){
      return this.selected[index]?"check_circle":"search"
    },
    search(item){
      alert(item.title)
    },
    select(index){
      this.$set(this.selected,index,!this.selected[index])
      //alert(index)
    }
  },
  created:function(){
    console.log("Serch",this.$route.query.q)
    this.get()
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/select.vue
const Select=Vue.extend({template:` 
 <v-container fluid="">
<v-card>
    <v-toolbar class="green darken-1">
    <v-card-title>
      <span class="white--text">Selection</span>     
    </v-card-title>
    <v-spacer></v-spacer>    
       <v-btn flat="" icon="" @click="showInfo = !showInfo"><v-icon>info</v-icon></v-btn>
  </v-toolbar>
  <qd-panel :show="showInfo">
  
    <v-flex slot="body">
    <v-layout>
     
    <v-flex xs6="">
    <p>some text</p>
   
  
     <v-select label="Select" v-bind:items="options" v-model="value" item-text="name" item-value="name" chips="" max-height="auto" autocomplete="" clearable="" deletable-chips="">      
           
       </v-select>
         <pre>{{$data.value }}</pre>
    </v-flex>

    <v-flex xs6="">
    <p>multi select</p>
    
      <v-select label="Select" v-bind:items="options" v-model="value2" item-text="name" item-value="name" multiple="" chips="" deletable-chips="" max-height="auto" autocomplete="">v-select</v-select>
            <pre>{{$data.value2 }}</pre>
    </v-flex>
   </v-layout>
   </v-flex>
   
   <v-card slot="aside" flat=""> 
       <v-card-actions>
      <v-toolbar-title>test</v-toolbar-title>
      <v-spacer></v-spacer>    
       <v-btn flat="" icon="" @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-card-actions>
    <v-card-text> blah blah protocol:  </v-card-text> 
    </v-card>
  </qd-panel>
  

<v-card>
 </v-card></v-card></v-container>
 `,
      
  data: function(){
      return {
          value: null,
          value2: null,
          options: [],
          isLoading: false,
          showInfo:true
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
          console.log("data::::",r.data);
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/session.vue
const Session=Vue.extend({template:` 
 <v-container fluid="">
  <v-layout>
   <v-btn v-on:click="redraw">this.$forceUpdate()</v-btn>
    <v-btn v-on:click="logout">logout</v-btn>
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
   <table class="table">
      <thead> 
        <tr>
          <th>Name</th>
          <th>value</th>
          </tr>
        </thead>
        <tbody>
        <tr>
        <td>created</td><td>{{$auth.created}}</td>
        </tr>
        <tr>
        <td>session</td><td>{{$auth.session}}</td>
        </tr>
        <tr>
        <td>permision</td><td>{{$auth.permission}}</td>
        </tr>
        </tbody>
        </table>
 </v-container>
 `,
      
  data:  function(){
    return {
      fieldValue:"",
      list:[],
      search:"",
      data:[]    }
  },
  methods: {
    logout(){
      alert("TODO")
    },
    redraw(){
      this.$forceUpdate()
    },
    handleSelected(){
      
    }
  }
}


      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/settings/acesettings.vue
const Acesettings=Vue.extend({template:` 
<v-container fluid="">

  <v-layout row="">
    <v-flex xs12="" sm8="" offset-sm2="">
      <v-card>
        <v-alert color="warning" value="true">Not fully implemented</v-alert>
      
      <v-container fluid="">
       <v-layout row="">
          <v-flex xs6="" class="pa-3">
        <v-layout row="">
          
          <v-flex>
            <v-select v-bind:items="themes" v-model="ace.theme" label="Theme"></v-select>
          </v-flex>
        </v-layout>
       
        <v-layout row="">
         
          <v-flex>
            <v-select v-bind:items="keybindings" v-model="ace.keybinding" label="Key binding"></v-select>
           
          </v-flex>
        </v-layout>
        <v-layout row="">
         
          <v-flex>
            <v-text-field label="Font size (px)" v-model="ace.fontsize"></v-text-field>
          </v-flex>
        </v-layout>
         </v-flex>
        <v-flex xs6="" style="height:30vh" class="grey pa-3" fill-height="">
            <vue-ace mode="xquery" content="test" :settings="ace"></vue-ace>
        </v-flex>
        </v-layout>
       <v-divider></v-divider>
 
        
        <v-list two-line="" subheader="">
          <v-subheader>Ace editor settings</v-subheader>
   
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableSnippets</v-list-tile-title>
                <v-list-tile-sub-title>Allow 
                <a href="https://cloud9-sdk.readme.io/docs/snippets" target="docs">snippets</a></v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
    
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableBasicAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>Autocompletion via control-space</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
         
            <v-list-tile avatar="">
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableLiveAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>Autocompletion while typing</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
            
        </v-list>
        <v-card-text>
       
    </v-card-text>
      </v-container></v-card>
    </v-flex>
  </v-layout>
  </v-container>
 `,
      
  data () {
    return {
			     ace: {
			        enableSnippets: true,
			        enableBasicAutocompletion: true,
			        enableLiveAutocompletion: true,
			        theme: "github",
			        keybinding: "ace",
			        fontsize: "14"
			    },
			    keybindings:[  'ace',  'vim', 'emacs', 'textarea', 'sublime' ],
			    themes: [ "github","chrome" ,"tomorrow","-dark-","chaos","twilight"]
			    }
  },
  methods:{
    extend(obj, src) {
      Object.keys(src).forEach(function(key) { if(!obj[key]) obj[key] = src[key]; });
      return obj;
    }
  },
   beforeRouteLeave (to, from, next) {
     settings.setItem('settings/ace',this.ace)
     .then(v=>{
     next()
     })
   },
  mounted: function () {
  
 // console.log("$$$",this.ace)
  settings.getItem('settings/ace')
    .then( v =>{
              //alert("db\n"+JSON.stringify(v))
              this.ace = Object.assign({}, this.ace, v)
              //alert("op\n"+JSON.stringify(this.ace))
                  })

  }
}


      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/settings/settings.vue
const Settings=Vue.extend({template:` 
 <v-container fluid="">
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
<v-switch label="Dark theme" v-model="dark" @change="theme"></v-switch>
	 <v-card>
	   <v-card-title class="lime darken-1">Available settings</v-card-title>
	  


	 <v-card-text>
	   <router-link to="/acesettings">Editor</router-link>
   </v-card-text>
   </v-card>
    <v-switch label="Show advanced options" v-model="showDev"></v-switch>
   <v-card v-if="showDev">
   <v-card-title class="amber darken-1">System information</v-card-title>
   <v-card-text>keys
   <ul>
  <li v-for="key in keys">
    {{ key }}
  </li>
</ul>
   </v-card-text>
   <v-card-actions>
   <v-spacer></v-spacer>
   <v-btn @click="wipe" color="error">Wipe</v-btn></v-card-actions>
   </v-card>
 </v-container>
 `,
      
  data(){return {
    keys: ["?"],
    showDev: false,
    dark:false
  }
  },
  methods:{
    wipe(){
      if(confirm("wipe localstorage? "+this.keys.length)) settings.clear();
    },
    theme(){
     this.$root.$emit("theme",this.dark)
    }
  },
  created(){
    console.log("settings")
    settings.keys()
    .then( v =>{
     this.keys=v
    })
     
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/svg.vue
const Svg=Vue.extend({template:` 
 <v-container fluid="">
<div id="canvasqPWKOg" class="canvas"></div>
<button id="resetButtonqPWKOg">Reset</button>
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tabs.vue
const Tabs=Vue.extend({template:` 
  <v-tabs scroll-bars="" fixed="">
  
    
    <v-tabs-bar class="grey lighten-3" dense="">
      <v-tabs-item v-for="i in 13" :key="i" :href="'#mobile-tabs-6-' + i">
 
       <v-icon>favorite</v-icon>
       <span>Item {{ i }} more</span>
       <v-spacer></v-spacer>
       <v-btn small="" icon="" class="grey">
          <v-icon>close</v-icon>
        </v-btn>
      </v-tabs-item>
       <v-btn icon="">
            <v-icon>menu</v-icon>
          </v-btn>
      <v-tabs-slider class="primary"></v-tabs-slider>
    </v-tabs-bar>
      <v-card>
      <v-card-actions>
          <v-btn icon="">
            <v-icon>menu</v-icon>
          </v-btn>
          <v-card-title>Page Title</v-card-title>
          <v-spacer></v-spacer>
          <v-btn icon="">
            <v-icon>search</v-icon>
          </v-btn>
          <v-btn icon="">
            <v-icon>more_vert</v-icon>
          </v-btn>
        </v-card-actions>
    </v-card>
    <v-tabs-items>
     <v-tabs-content v-for="i in 13" :key="i" :id="'mobile-tabs-6-' + i">
      <v-card flat="">
        <v-card-text>{{i}} - {{ text }}</v-card-text>
      </v-card>
      </v-tabs-content>
    </v-tabs-items>
</v-tabs>
 `,
      
    data () {
      return {
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
      }
    }
  }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/model.build/model.vue
const Model=Vue.extend({template:` 
 <v-container fluid="">
    <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
      <span class="white--text">Generate <code>model.gen.xqm</code></span>      
    </v-card-title>
    <v-spacer></v-spacer>
     <v-btn color="primary" @click="submit()" :loading="waiting" :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid="">
        <v-layout row="" wrap="">
          
          <v-flex xs12="">
            <v-text-field v-model="params.efolder" label="Folder containing model  definitions as xml"></v-text-field>
          </v-flex>
        
          <v-flex xs12="">
            <v-text-field v-model="params.target" label="Path to xqm file to generate"></v-text-field>
          </v-flex>
           <v-flex xs12="">
            <code>{{code}}</code>
          </v-flex>
        </v-layout>
  
      </v-container>
    </v-card-text>
 
      <v-snackbar v-model="snackbar.show" :timeout="6000" :success="snackbar.context === 'success'" :error="snackbar.context === 'error'">
      {{ snackbar.msg }}
      <v-btn dark="" flat="" @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      params:{
			      efolder:"C:/Users/andy/git/vue-poc/src/vue-poc/models",
			      target:"C:/Users/andy/git/vue-poc/src/vue-poc/models.gen.xqm"
			 },
			waiting:false,
			snackbar:{show:false,msg:"",context:"success"},
    }
  },
  methods:{
    submit(){
      this.waiting=true
      HTTP.post("tasks/model",Qs.stringify(this.params))
      .then(r=>{
        this.waiting=false      
        this.snackbar={show:true,msg:r.data.msg,context:"success"}
        console.log(r.data)
      })
      .catch(error=>{
        this.waiting=false
        this.snackbar={show:true,msg:"Problem",context:"error"}
        console.log(error);
      });
   }
  },
  computed:{
    code(){return 'import module namespace entity = "quodatum.models.generated" at "'+this.params.target+'";'}
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/task/task.vue
const Runtask=Vue.extend({template:` 
 <v-container fluid="">
    <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
      <span class="white--text">Task: {{ task }}</span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn color="primary" @click="submit()" :loading="waiting" :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid="">
        <v-layout row="" wrap="">   
          <v-flex xs12="">
            <v-text-field v-model="params.proj" label="vue project to compile"></v-text-field>
          </v-flex>
        </v-layout>
         <v-layout row="" wrap="">
           <v-flex xs12="">
            <code>{{code}}</code>
          </v-flex>
        </v-layout>
  
      </v-container>
    </v-card-text>
   
      <v-snackbar v-model="snackbar.show" :timeout="6000" :success="snackbar.context === 'success'" :error="snackbar.context === 'error'">
      {{ snackbar.msg }}
      <v-btn dark="" flat="" @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-card>
 </v-container>
 `,
      
  props:["task"],
  data:  function(){
    return {
      params:{
			      proj:"C:/Users/andy/git/vue-poc/src/vue-poc/"
			 },
			waiting:false,
			snackbar:{show:false,msg:"",context:"success"},
    }
  },
  methods:{
    submit(){
      this.waiting=true
      HTTP.post("tasks/" + this.task, Qs.stringify(this.params))
      .then(r=>{
        this.waiting=false      
        this.snackbar={show:true,msg:r.data.msg,context:"success"}
        console.log(r.data)
         settings.setItem('tasks/vuecompile',this.params)
      })
      .catch(error=>{
        this.waiting=false
        this.snackbar={show:true,msg:"Problem",context:"error"}
        console.log(error);
      });
   }
  },
  created:function(){
    var task=this.task
    HTTP.get("tasks/"+task)
    .then(r=>{
      console.log(r);
      alert("OK");
      })
   },
  computed:{
    code(){return 'code here'}
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/tasks.vue
const Task=Vue.extend({template:` 
 <v-container fluid="">
  <h3>Available Tasks</h3>
  
  <ul>
  <li v-for="task in tasks" :key="task.to">
  <router-link :to="task.to" v-text="task.text"></router-link>
  </li>
  </ul>
 </v-container>
 `,
      
  data(){
    return {
      tasks: []
      }
  },
  methods:{
    getTasks(){
        HTTP.get("tasks")
        .then(r=>{
		   this.tasks=r.data
       })
    }
   },
  created(){
    this.getTasks()
   }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/vue-compile/vuecompile.vue
const Vuecompile=Vue.extend({template:` 
 <v-container fluid="">
    <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon="" to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
      <span class="white--text">compile</span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn color="primary" @click="submit()" :loading="waiting" :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid="">
        <v-layout row="" wrap="">   
          <v-flex xs12="">
            <v-text-field v-model="params.proj" label="vue project to compile"></v-text-field>
          </v-flex>
        </v-layout>
         <v-layout row="" wrap="">
           <v-flex xs12="">
            <code>{{code}}</code>
          </v-flex>
        </v-layout>
  
      </v-container>
    </v-card-text>
   
      <v-snackbar v-model="snackbar.show" :timeout="6000" :success="snackbar.context === 'success'" :error="snackbar.context === 'error'">
      {{ snackbar.msg }}
      <v-btn dark="" flat="" @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      params:{
			      proj:"C:/Users/andy/git/vue-poc/src/vue-poc/"
			 },
			waiting:false,
			snackbar:{show:false,msg:"",context:"success"},
    }
  },
  methods:{
    submit(){
      this.waiting=true
      HTTP.post("tasks/vue-compile",Qs.stringify(this.params))
      .then(r=>{
        this.waiting=false      
        this.snackbar={show:true,msg:r.data.msg,context:"success"}
        console.log(r.data)
         settings.setItem('tasks/vuecompile',this.params)
      })
      .catch(error=>{
        this.waiting=false
        this.snackbar={show:true,msg:"Problem",context:"error"}
        console.log(error);
      });
   }
  },
   created: function () {
    settings.getItem('tasks/vuecompile')
    .then((v)=>{
      if(v)this.params=v
    })
  },
  computed:{
    code(){return 'code here'}
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/xqdoc/xqdoc.vue
const Xqdoc=Vue.extend({template:` 
 <v-container fluid="">
    <v-card>
     <v-toolbar class="orange darken-1">
     <v-btn icon="" to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
      <span class="white--text">Task: Generate <code>xqdoc</code></span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn color="primary" @click="submit()" :loading="waiting" :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid="">
        <v-layout row="" wrap="">
          
          <v-flex xs12="">
            <v-text-field v-model="params.efolder" label="Root Folder containing xq files"></v-text-field>
          </v-flex>
        
          <v-flex xs12="">
            <v-text-field v-model="params.target" label="Path for xqdoc files"></v-text-field>
          </v-flex>
        
        </v-layout>
  
      </v-container>
    </v-card-text>
   
     
    <v-alert color="success" v-model="alert.success">
    {{alert.timestamp}}:{{alert.msg}}
    </v-alert>
     <v-alert color="error" v-model="alert.error">
    {{alert.timestamp}}:<code>{{alert.msg}}</code>
    </v-alert>
  </v-card>
  <code>{{code}}</code>
 </v-container>
 `,
      
  data:  function(){
    return {
      params:{
			      efolder:"C:/Users/andy/git/graphxq/src",
			      target:"C:/tmp/xqdoc/"
			 },
			waiting:false,
			alert:{msg:"",success:false,error:false},
    }
  },
  methods:{
    submit(){
      this.waiting=true
      this.alert={msg:"Loading..",success:false,error:false}
      HTTP.post("tasks/xqdoc",Qs.stringify(this.params))
      .then(r=>{
        this.waiting=false      
        this.alert={msg:r.data.msg,success:true,error:false}
        console.log(r.data)
         settings.setItem('tasks/xqdoc',this.params)
      })
      .catch(error=>{
        this.waiting=false
        this.alert={msg:error.response.data,success:false,error:true}
        console.log(error);
        alert("bad")
      });
   }
  },
  created: function () {
    settings.getItem('tasks/xqdoc')
    .then((v)=>{
      if(v)this.params=v
    })
  },
  
  computed:{
    code(){return 'generate xqdoc'}
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/thumbnail/thumbnail.vue
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
  <v-stepper-items>
  <v-stepper-content step="1" non-linear="">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    <v-text-field name="url" label="Image Url" hint="http:...??" v-model="image" required=""></v-text-field>
    </v-card>
        <v-btn color="primary" @click="step = 2">Next</v-btn>
  </v-stepper-content>
  
  <v-stepper-content step="2" non-linear="">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    <vue-ace editor-id="editorA" :content="taskxml" mode="xml" wrap="true" v-on:change-content="onChange"></vue-ace>
		</v-card>
   
    <v-btn flat="" @click="step -= 1">Back</v-btn>
    <v-btn color="primary" @click="validate()">Validate</v-btn>
     <v-btn color="primary" @click="step = 3">Next</v-btn>  
  </v-stepper-content>

  <v-stepper-content step="3" non-linear="">
    <v-card class="grey lighten-1 z-depth-1 mb-5" height="200px">
    output todo
    </v-card>

     <v-btn flat="" @click="step -= 1">Back</v-btn>
     <v-btn color="primary" @click="go()">go</v-btn>
  </v-stepper-content>
  </v-stepper-items>
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/timeline.vue
const Timeline=Vue.extend({template:` 
 <v-container fluid="">
 <v-card>
 <v-toolbar class="lime darken-1">
	 <v-card-title>Line 1</v-card-title>
	 <v-spacer></v-spacer>
	 <v-btn @click="fit">fit</v-btn>
	 </v-toolbar>
	 <v-card-text>
	   <vis-time-line :items="vueState.data1" :events="Events" :options="{editable: true, clickToUse: false}" @select="select"></vis-time-line>
	 </v-card-text>
 </v-card>
 
 <v-card>
 <v-card-text>
 {{msg}}
 </v-card-text>
</v-card>
 </v-container>
 `,
      
  data(){
    return {
      vueState: {
      data1: [
        { id: 1, content: 'item 1', start: '2013-04-20 23:06:15.304' },
	      { id: 2, content: 'iso date time', start: '2013-04-14T11:11:15.304' },
	      { id: 3, content: '[GET] http://localhost:8984/vue-poc/ui/icon.png', start: '2013-04-18', end: '2013-04-19' },
	      { id: 4, content: 'item 4', start: '2013-04-16', end: '2013-04-19', className: 'green' },
	      { id: 5, content: '[GET] http://localhost:8984/vue-poc/ui/app.css', start: '2013-04-25' },
	      { id: 6, content: 'item 6', start: '2013-04-27' }]
    },
    Events: new Vue({}),
    msg:"Item detail"
    }
},
methods:{
  fit(){
    this.Events.$emit('fit');
  },
  select(items){
    this.msg='Selected items: ' + items
  }
},
created(){
  console.log("timeline")
}
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/users/users.vue
const Users=Vue.extend({template:` 
 <v-container fluid="">
   <qd-table :headers="headers" data-uri="data/users">
   </qd-table>
 </v-container>

 `,
      
  data:  function(){
    return {
      loading: false,
      items: [],
      search: null,
      selected: [],
      headers: [
        {
          text: 'Name',
          left: true,
          value: 'id'
        },
        { text: 'Permissions', value: 'state' }
      ] 
      }
  },
 
  created:function(){
    console.log("qd-table")
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/validate/validate.vue
const Validate=Vue.extend({template:` 
  <v-container fluid="" v-resize="onResize">
<v-card>
     <v-toolbar class="orange">
          <v-btn @click="validate" :loading="loading" :disabled="loading"><v-icon>play_circle_outline</v-icon>Validate</v-btn>
          <span v-text="elapsed"></span>ms. Height: 
          <span v-text="height"></span>
            <v-spacer></v-spacer>
         
              <v-menu offset-y="" left="">
             <v-btn icon="" dark="" slot="activator"><v-icon>settings</v-icon></v-btn>
              <v-card>
              <v-toolbar class="green">
                  <v-card-title>Settings................</v-card-title>
                  </v-toolbar>
                <v-card-text>
                stuff
                </v-card-text>
                </v-card>
              </v-menu>
          </v-toolbar>
    <v-card-text>
    here
    </v-card-text>
    </v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      loading: false,
      elapsed: null,
      height: null,
      result: null,
      doc: "c:/test.xml",
      schema: "c:/schema.xsd"
      }
  },
  methods:{
    onResize(){
      this.height = window.innerHeight 
    },
    validate(){
    
      this.loading=true
      this.start = performance.now();
      HTTPNE.get("validate",Qs.stringify({doc: this.doc, schema: this.schema}))
      .then(r=>{
       console.log(r)
       this.elapsed=Math.floor(performance.now() - this.start);
       this.loading=false
       if(r.data.rc==0){
         this.result=r.data.result
       }else{
         this.result=r.data.info
       }
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.message + ": "+ r.config.url + "\n"+ r.response.data
        this.loading=false
      });
    },
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/xslt/transform.vue
const Transform=Vue.extend({template:` 
 <v-container fluid="">
<v-card>
     <v-toolbar class="orange">
          <v-btn @click="transform" :loading="loading" :disabled="loading"><v-icon>play_circle_outline</v-icon>Run</v-btn>
          <span v-text="elapsed"></span>ms. Height: 
          <span v-text="height"></span>
            <v-spacer></v-spacer>
           <v-btn-toggle v-model="showOptions" multiple="">
           <v-icon>visibility</v-icon>
              <v-btn flat="" value="result">
                <span :class="resultValid?'':'red'">Result</span>
              </v-btn>
              <v-btn flat="" value="xml">
               <span :class="xmlValid?'':'red'">XML</span>
              </v-btn>
              <v-btn flat="" value="xslt">
                 <span :class="xslValid?'':'red'">XSLT</span>
              </v-btn>
            </v-btn-toggle>
              <v-menu offset-y="" left="">
             <v-btn icon="" dark="" slot="activator"><v-icon>settings</v-icon></v-btn>
              <v-card>
              <v-toolbar class="green">
				          <v-card-title>Settings................</v-card-title>
				          </v-toolbar>
				        <v-card-text>
				        stuff
				        </v-card-text>
				        </v-card>
				      </v-menu>
          </v-toolbar>
    <v-card-text ref="page" v-resize="onResize" style="height:400px; " class="amber">

       <v-layout v-if="showOptions.includes('result')" style="height:100%" fill-height="">
		      <v-flex>
		        <vue-ace :content="result" mode="xml" wrap="true" :settings="aceSettings"></vue-ace>
		      </v-flex>
       </v-layout>
 
      <v-layout style="height:100%" fill-height="">
      <v-flex v-if="showOptions.includes('xml')" class="pa-1">
	      <vue-ace :content="xml" mode="xml" wrap="true" v-on:change-content="v => this.xml=v" v-on:annotation="a => this.xmlValid=a.error===0 &amp;&amp; a.warning===0" :settings="aceSettings"></vue-ace>
     </v-flex>
       <v-flex v-if="showOptions.includes('xslt')" class="pa-1">
	       <vue-ace :content="xslt" mode="xml" wrap="true" v-on:change-content="v => this.xslt=v" v-on:annotation="a => this.xslValid=a.error===0 &amp;&amp; a.warning===0" :settings="aceSettings"></vue-ace>
      </v-flex>
      </v-layout>
 
      </v-card-text>
      
     
      </v-card>
 </v-container>
 `,
      
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
      loading: false,
      start: null,
      elapsed: "?",
      height: "?"
      }
  },
  methods:{
  
    transform(){
      localforage.setItem('transform/xml', this.xml)
      localforage.setItem('transform/xslt', this.xslt)
      if(!this.showOptions.includes("result"))this.showOptions.push("result")
      this.loading=true
      this.resultValid=true
      this.start = performance.now();
      HTTPNE.post("xslt",Qs.stringify({xml:this.xml,xslt:this.xslt}))
      .then(r=>{
       console.log(r)
       this.elapsed=Math.floor(performance.now() - this.start);
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
        this.result=r.message + ": "+ r.config.url + "\n"+ r.response.data
        this.loading=false
      });
    },
    onResize(){
      var el=this.$refs["page"]
      console.log("top",el.offsetTop)
      var h=Math.max(1,window.innerHeight - el.offsetTop) -100
       console.log("h",h)
      this.height = h
      el.style.height=h +"px"
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

      );
      
// src: C:\Users\andy\git\vue-poc\src\vue-poc\router.js
// vue-poc application routes
const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  //
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else if (to.hash) {
      return { selector: to.hash, behavior: 'smooth' }

    } else {
      return { x: 0, y: 0 }
    }
  },
  routes: [
    { path: '/', component: Home, meta:{title:"Home"} },
    { path: '/session', component: Session ,meta: {title:"Session"}},
    
    {path: '/images', redirect: '/images/item' },
    { path: '/images/item', name:'images', component: Images, meta:{title: "Images"} },
    { path: '/images/report', name:"image-reports", component: Report, props: true, meta:{title: "Image report"}},
    { path: '/images/item/:id', name:"image",component: Image, props: true, meta:{title: "Image details"}},
    { path: '/images/thumbnail', component: Thumbnail, meta:{title:"Thumbnail generator"} },
    { path: '/images/keywords', component: Keywords, meta:{title:"Image keywords"} },
    { path: '/images/dates', component: Dates, meta:{title:"Image dates"} },
    { path: '/images/people', component: People, meta:{title:"Image people"} },
    
    { path: '/entity', component: Entity, meta:{title:"Entities"} },
    { path: '/namespace', component: Namespace, meta:{title:"Namespaces"} },
    { path: '/select', component: Select, meta:{title:"Select"} },
    { path: '/search', component: Search, meta:{title:"Search"} },
    { path: '/tabs', component: Tabs,meta:{title:"tab test",requiresAuth: true} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/server/users', component: Users,meta:{title:"Users"} },
    { path: '/server/repo', component: Repo,meta:{title:"Repository"} },
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} },
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"xmldb"} },
    { path: '/ping', component: Ping,meta:{title:"Ping"} },
    { path: '/settings', component: Settings, meta:{title:"Settings"} },
    { path: '/acesettings', component: Acesettings, meta:{title:"Editor settings"} },
    { path: '/history', component: History, meta:{title:"File History"} },
    { path: '/puzzle', component: Puzzle, meta:{title:"Jigsaw"} },
    { path: '/svg', component: Svg, meta:{title:"SVG"} },
    { path: '/transform', component: Transform, meta:{title:"XSLT2 Transform"} },
    { path: '/validate', component: Validate, meta:{title:"Validate"} },
    { path: '/eval', component: Eval, meta:{title:"Evaluate XQuery"} },
    { path: '/logs', component: Log, meta:{title:"Server logs"} },
    { path: '/tasks', component: Task, meta:{title:"Runnable tasks"} },
    { path: '/tasks/model', component: Model, meta:{title:"build model"} },
    { path: '/tasks/xqdoc', component: Xqdoc, meta:{title:"build xqdoc"} },
    { path: '/tasks/vuecompile', component: Vuecompile, meta:{title:"vue compile"} },
    { path: '/tasks/:task', component: Runtask, props: true, meta:{title:"Run task"} },
    { path: '/jobs', component: Jobs, meta:{title:"Jobs running"} },
    { path: '/jobs/:job',  name:"jobShow", component: Job, props: true, meta:{title:"Job Status"} },
    { path: '/timeline', component: Timeline,meta:{title:"timeline"} },
    { path: '/map', component: Map,meta:{title:"map"} },
    { path: '/form', component: Brutusin,meta:{title:"Form demo"} },
    { path: '/about', component: About,meta:{title:"About Vue-poc"} },
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

// src: C:\Users\andy\git\vue-poc\src\vue-poc\app.vue
const Vuepoc=Vue.extend({template:` 
 <v-app id="app" :dark="dark">
  <v-navigation-drawer absolute="" v-model="showNotifications" right="" :disable-route-watcher="true" app="" width="500">
    <v-card>
         <v-toolbar class="amber white--text">
                <v-toolbar-title>Notifications </v-toolbar-title>
                {{ $notification.nextId }}
          <v-spacer></v-spacer>
          <v-btn @click="showNotifications = false" icon=""><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          <v-card-text>
        <v-list three-line="">
          <template v-for="msg in $notification.messages">
           <v-list-tile avatar="" v-bind:key="msg.index" @click="">
              <v-list-tile-avatar>
                   <v-icon color="red">swap_horiz</v-icon>
              </v-list-tile-avatar>
              <v-list-tile-content>
              <v-tooltip>
                <v-list-tile-title slot="activator">{{ msg.created | fromNow("from") }}</v-list-tile-title>
                <span v-text="msg.created"></span>
                </v-tooltip>
                <v-list-tile-sub-title v-html="msg.text"></v-list-tile-sub-title>
              </v-list-tile-content>
              <v-list-tile-action>
               <v-list-tile-action-text>{{ msg.index }}</v-list-tile-action-text>
              </v-list-tile-action>
            </v-list-tile>
           </template>
         </v-list>
      </v-card-text>
      </v-card>
</v-navigation-drawer>
 <v-navigation-drawer app="" :mini-variant.sync="mini" v-model="drawer" absolute="" :disable-route-watcher="true" :enable-resize-watcher="true">
  <v-list class="pa-0">

          <v-list-tile avatar="" tag="div">
            <v-list-tile-avatar>
              <v-btn icon="" @click="session">
              <img src="/vue-poc/ui/quodatum.gif">
              </v-btn>
            </v-list-tile-avatar>
            <v-list-tile-content>
              <v-list-tile-title>Vue PoC</v-list-tile-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-btn icon="" @click.stop="mini = !mini">
                <v-icon>chevron_left</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>

      </v-list>
    <qd-navlist :items="items"></qd-navlist>
 </v-navigation-drawer>
  
 <v-toolbar class="indigo" app="" dark="">
  <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>  
  <v-toolbar-title class="hidden-sm-and-down">{{$route.meta.title}}</v-toolbar-title>
   <v-menu offset-x="" :close-on-content-click="false" :nudge-width="200" v-model="frmFav">
      <v-btn slot="activator" @click="frmFav = !frmFav" icon="" flat="" title="Bookmark this page">
       <v-icon>star_border</v-icon>
       </v-btn>

            <v-card style="width:400px;">
            <v-toolbar class="amber"> 
        <v-card-title>
            Bookmark this page
          </v-card-title>
          </v-toolbar>
         <v-card-text>
         <h6>{{$route.meta.title}}</h6>
            <v-select v-model="tags" label="tags" chips="" tags="" :items="taglist"></v-select>
           </v-card-text>
        <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" flat="" @click.stop="frmFav=false">Cancel</v-btn>
            <v-btn color="primary" flat="" @click.stop="favorite();frmFav=false">Save</v-btn>
          </v-card-actions>
        </v-card>
   </v-menu>
  <v-spacer></v-spacer>
  <v-text-field prepend-icon="search" label="Search..." v-model="q" hide-details="" single-line="" dark="" @keyup.enter="search"></v-text-field>
  <v-spacer></v-spacer>
  
   <v-menu left="" transition="v-fade-transition">
      <v-btn dark="" icon="" slot="activator">
        {{$auth.user}}
      </v-btn>
     
          <v-list>
        
              <v-list-tile @click="logout()">
                <v-list-tile-title>logout</v-list-tile-title>
              </v-list-tile>
               <v-list-tile>
                <v-list-tile-title>permission: {{$auth.permission}}</v-list-tile-title>
              </v-list-tile>
            
          </v-list>
      </v-menu>
      <qd-fullscreen></qd-fullscreen>
       <v-btn @click="showNotifications = ! showNotifications" icon="" flat="" title="Notifications">
       <v-badge overlap="" color="orange">
      <span slot="badge" v-if=" $notification.unseen">{{ $notification.unseen }}</span>
       <v-icon>notifications</v-icon>
       </v-badge>
   </v-btn>
</v-toolbar>
 
 <v-content> 
 <v-alert color="error" value="true" dismissible="" v-model="alert.show">
      <pre style="overflow:auto;">{{ alert.msg }}</pre>
    </v-alert>   
    <transition name="fade" mode="out-in">
      <router-view class="view ma-3"></router-view>
      </transition>
  </v-content>

</v-app>
 `,
      
  router,
  data:function(){return {
    q: "",
    status: {},
    drawer: true,
    showNotifications: false,
    mini: false,
    dark: false,
    alert: {show:false,msg:"Hello"},
    frmFav: false,
    tags: [],
    taglist: [
      'todo',
      'find',
      'some',
      'good',
      'tags'
    ],
    items: [
      {href: '/',text: 'Home', icon: 'home'    },
      {
        icon: 'input',
        text: 'Actions' ,
        model: false,
        children: [
      {href: '/eval',text: 'Query',icon: 'play_circle_outline'},
      {href: '/edit',text: 'Edit',icon: 'mode_edit'},
      {href: '/validate',text: 'Validate',icon: 'playlist_add_check'},
      {href: '/transform',text: 'XSLT Transform',icon: 'forward'},
      {href: '/tasks',text: 'Tasks',icon: 'update'}
      ]},
      {
        icon: 'folder_open',
        text: 'Collections' ,
        model: false,
        children: [
       {href: '/database', text: 'Databases',icon: 'developer_mode' },
       {href: '/files', text: 'File system',icon: 'folder' },
      {href: '/history',text: 'history',icon: 'history'}
      ]},
      {
        icon: 'memory',
        text: 'Models' ,
        model: false,
        children: [
          {href: '/namespace', text: 'Namespaces',icon: 'label' },
          {href: '/entity', text: 'Entities',icon: 'redeem' },
      ]},
      {
        icon: 'cast_connected',
        text: 'Server' ,
        model: false,
        children: [
          {href: '/jobs',text: 'Running jobs',icon: 'dashboard'},   
          {href: '/logs',text: 'Server logs',icon: 'dns'},
          {href: '/timeline',text: 'Time line',icon: 'timelapse'},
          {href: '/server/users',text: 'Users',icon: 'supervisor_account'},
          {href: '/server/repo',text: 'Server code repository',icon: 'local_library'},
          {href: '/ping',text: 'Ping',icon: 'update'}
      ]},
      {
        icon: 'camera_roll',
        text: 'Images' ,
        model: false,
        children: [
          {href: '/images/item',text: 'Collection',icon: 'photo_camera'},
          {href: '/images/keywords',text: 'Keywords',icon: 'label'},
          {href: '/images/dates',text: 'Date taken',icon: 'date_range'},
          {href: '/images/thumbnail',text: 'Thumbnail',icon: 'touch_app'},
          {href: '/images/people',text: 'People',icon: 'people'},
          {href: '/map',text: 'Map',icon: 'place'}, 
          {href: '/images/report',text: 'Reports',icon: 'report'}
          ]},
      {
        icon: 'more_horiz',
        text: 'More' ,
        model: false,
        children: [
      {href: '/session',text: 'Session',icon: 'person'}, 
      {href: '/select',text: 'Select',icon: 'extension'},
      {href: '/puzzle',text: 'Puzzle',icon: 'extension'},
      {href: '/svg',text: 'SVG',icon: 'extension'},
      {href: '/form',text: 'Forms',icon: 'format_list_bulleted'  },
      {href: '/tabs',text: 'Tabs',icon: 'switch_camera'}
      ]},
      
      {href: '/settings',text: 'Settings',icon: 'settings'  },
      {href: '/about',text: 'About (v1.1.1)' , icon: 'help'    }, 
    ]

  }},
  methods: {
      session(){
        this.$router.push({path: '/session'})
      },
      search(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
      logout(){
        HTTP.get("logout").then(r=>{
          alert("logout")
        }) 
      },
      showAlert(msg){
        this.alert.msg=moment().format()+" "+ msg
        this.alert.show=true
      },
      onDark(dark){
        this.dark=dark
      },
      favorite(){
        alert("@TODO")
      }
  },
  watch: {
    showNotifications: function (val) {
      console.log("showNotifications",val);
      if(!val)this.$notification.unseen=0;
    }
    },
  created(){
    console.log("create-----------")
    var that=this
    this.$on("theme",this.onDark)
    Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
        console.error(err, vm, info);
        var msg=JSON.stringify(err)
        that.showAlert("vue error:\n"+msg)
        //alert("vue error");
   };
    
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
  }

      );
      
// src: C:\Users\andy\git\vue-poc\src\vue-poc\core.js
// base -----------------------

const AXIOS_CONFIG={
    baseURL: "/vue-poc/api/",
    headers: {
      'X-Custom-Header': 'vue-poc',
      accept: 'application/json'
    },
    paramsSerializer: function(params) {
      return Qs.stringify(params)
    }
  };

// time requests

// Add a response interceptor
axios.interceptors.response.use(function (response) {
    // Do something with response data
  console.log("AXIOS",response);
    return response;
  }, function (error) {
    // Do something with response error
    return Promise.reject(error);
  });

// errors displayed by interceptor
const HTTP = axios.create(AXIOS_CONFIG);
HTTP.interceptors.request.use((config) => {
  config.qdStartTime=performance.now();
  return config;
});
HTTP.interceptors.response.use((response) => {
  // Do something with response data
  if(response.config && response.config.qdStartTime){
    var s=Math.floor(performance.now() - response.config.qdStartTime);
    var c=response.config;
    var url=response.config.url + "?" + c.paramsSerializer(c.params);
    console.log("interceptors time:",s, response.config);
    Notification.add(s +" "+ url );
  }
  return response;
});

// errors hidden
const HTTPNE = axios.create(AXIOS_CONFIG);
const axios_json={ headers: {accept: 'application/json'}};


// Authorization Object
const Auth={
    user:"guest",
    permission:null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  }
};
Vue.use(Auth);

//Notification Object
const Notification={
    messages:[],
    nextId: 0,
    unseen:0,
    add(msg){
      var data={
          text: msg,
          index: ++this.nextId,
          created: new Date()
      };
      this.messages.unshift(data);
      this.messages.length = Math.min(this.messages.length, 30);
      ++this.unseen;

    },
    install(Vue){
        Object.defineProperty(Vue.prototype, '$notification', {
          get () { return Notification }
      })  }
};
Vue.use(Notification);

// Mimetype info
const MimeTypes={
      "text/xml":"xml",
      "application/xml":"xml",
      "application/xquery":"xquery",
      "text/ecmascript":"javascript",
      "application/sparql-query":"sparql",
      "text/html":"html",
      "text/turtle":"turtle",
      "text/css":"css",
      "image/svg+xml":"svg"
};

// Settings read and write list clear
localforage.config({
  name: 'vuepoc'
});
// https://vuejs.org/v2/guide/state-management.html
var settings = {
    debug: false,
    getItem (key) {
      if (this.debug) console.log('getItem',key);
      return localforage.getItem(key)
        .then(value => {
          //console.log('GET setting', key,value);
          return value;
     
        }).catch(err => {
          console.log('GET failed');

      });
    },
    setItem (key,value) {
      if (this.debug) console.log('setItem',key,value);
      return localforage.setItem(key, value) 
      .then(value => {
        //console.log('SET ',key, value);
        return value
        
      }).catch(err => {
        console.log('set failed');
      });
   },
    keys(){
      return localforage.keys() // returns array of keys 
 
  },
  clear(){
    localforage.clear()
  }
};

// error help 
// https://stackoverflow.com/questions/18391212/is-it-not-possible-to-stringify-an-error-using-json-stringify/18391400#18391400
if (!('toJSON' in Error.prototype))
  Object.defineProperty(Error.prototype, 'toJSON', {
      value: function () {
          var alt = {};

          Object.getOwnPropertyNames(this).forEach(function (key) {
              alt[key] = this[key];
          }, this);

          return alt;
      },
      configurable: true,
      writable: true
  });

//Returns a function, that, as long as it continues to be invoked, will not
//be triggered. The function will be called after it stops being called for
//N milliseconds. If `immediate` is passed, trigger the function on the
//leading edge, instead of the trailing. https://gist.github.com/nmsdvid/8807205
function debounce(func, wait, immediate) {
 var timeout;
 return function() {
     var context = this, args = arguments;
     clearTimeout(timeout);
     timeout = setTimeout(function() {
         timeout = null;
         if (!immediate) func.apply(context, args);
     }, wait);
     if (immediate && !timeout) func.apply(context, args);
 };
};

// https://stackoverflow.com/questions/36672561/how-to-exit-fullscreen-onclick-using-javascript
const Fullscreen={
    isInFullScreen(){
      return (document.fullscreenElement && document.fullscreenElement !== null) ||
      (document.webkitFullscreenElement && document.webkitFullscreenElement !== null) ||
      (document.mozFullScreenElement && document.mozFullScreenElement !== null) ||
      (document.msFullscreenElement && document.msFullscreenElement !== null);
    },
    toggle(){
      var docElm = document.documentElement;
      if (!this.isInFullScreen()) {
          if (docElm.requestFullscreen) {
              docElm.requestFullscreen();
          } else if (docElm.mozRequestFullScreen) {
              docElm.mozRequestFullScreen();
          } else if (docElm.webkitRequestFullScreen) {
              docElm.webkitRequestFullScreen();
          } else if (docElm.msRequestFullscreen) {
              docElm.msRequestFullscreen();
          }
      } else {
          if (document.exitFullscreen) {
              document.exitFullscreen();
          } else if (document.webkitExitFullscreen) {
              document.webkitExitFullscreen();
          } else if (document.mozCancelFullScreen) {
              document.mozCancelFullScreen();
          } else if (document.msExitFullscreen) {
              document.msExitFullscreen();
          }
      }
    },
    install: function(Vue){
      Object.defineProperty(Vue.prototype, '$fullscreen', {
        get () { return Fullscreen }
    })  }
};
Vue.use(Fullscreen);

//leaflet
//Vue.component('v-map', Vue2Leaflet.Map);
//Vue.component('v-tilelayer', Vue2Leaflet.TileLayer);
//Vue.component('v-marker', Vue2Leaflet.Marker);

Vue.use(Vuetify);
new Vuepoc().$mount('#app')

