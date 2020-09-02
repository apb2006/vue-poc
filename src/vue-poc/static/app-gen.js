// generated 2020-09-01T22:40:57.014+01:00

// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-autoheight.vue
Vue.component('qd-autoheight',{template:` 
	<v-layout style="height:200px;overflow:hidden;" row wrap ref="auto" v-resize="onResize" class="green">
			<slot>i will auto2</slot>
	</v-layout>
 `,
      
  props: ['show'],
  created:function(){
      console.log("qd-auto");
    },
    methods:{
      onResize(){
        var el=this.$refs["auto"];
        var e=el;
       // console.log("top",e.offsetTop,e.getBoundingClientRect().top,window.innerHeight);
        var h=window.innerHeight - e.getBoundingClientRect().top -10;
        var h=Math.max(1,h) ;
        // console.log("h",h)
        e.style.height=h +"px"; 
    }
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-breadcrumbs.vue
Vue.component('qd-breadcrumbs',{template:` 
		<v-breadcrumbs :items="crumbs">
		    <template slot="item" slot-scope="props">
		        <v-breadcrumbs-item :to="props.item.to" :disabled="props.item.disabled" :exact="true">
		        
		           <v-icon v-if="props.item.icon">props.item.icon</v-icon>
		                 {{ props.item.text }}
		                 <v-btn icon v-if="props.item.menu" @click="$emit(props.item.menu)" :class="props.item.menu">
				              <v-icon>arrow_drop_down</v-icon>
				            </v-btn>
				         
		         </v-breadcrumbs-item>
		     </template>
		</v-breadcrumbs>
 `,
      
  props: ['crumbs'],
  created:function(){
      console.log("qd-crumbs");
    }
}

      );
      
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-fileupload.vue
Vue.component('qd-fileupload',{template:` 
	<div>
	  <v-btn @click="openFileDialog">
	      Select
	   </v-btn>
	   
	   <v-btn @click="uploadFile" icon>
      <v-icon>cloud_upload</v-icon>
     </v-btn>
     
      <input type="file" name="files" ref="file-upload" multiple="multiple" style="display:none" @change="onFileChange">
   </div>
 `,
      
		props: ['url'
		  ],
		data() {
		  return {
		    formData: new FormData()
		  }
		},
		methods: {
		  openFileDialog() {
		    this.$refs['file-upload'].click();
		  },
		  onFileChange(e) {
		      var self = this;
		      var files = e.target.files || e.dataTransfer.files;       
		      if(files.length > 0){
		          for(var i = 0; i< files.length; i++){
		              self.formData.append("files", files[i], files[i].name);
		          }
		          
		      }   
		  },
		  uploadFile() {
		      var self = this; 
		      HTTP.post( this.url, self.formData).then(function (response) {
		          console.log(response);
		          self.$emit("complete",response)
		      }).catch(function (error) {
		          console.log(error);
		      });
		  }
		}
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-fullscreen.vue
Vue.component('qd-fullscreen',{template:` 
<a @click="toggle()" href="javascript:void(0);" title="Fullscreen toggle">
  <v-icon>{{ fullscreenIcon }}</v-icon>
  <slot></slot>
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
 <a :href="href" :target="href">
		 <v-icon>link</v-icon> 
		 <slot>{{href}}</slot>
 </a>
 `,
      
  props: ['href'],
  created:function(){
      console.log("qd-link");
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-mimelist.vue
Vue.component('qd-mimelist',{template:` 
  <v-menu v-model="show" left bottom :close-on-content-click="false">
  <template v-slot:activator="{ on }">
    <v-chip v-on="on"> 
    {{ mimetype }}
      <v-icon right>arrow_drop_down</v-icon>
    </v-chip>
   </template>
   
   <v-card>
    <v-toolbar>
      <v-text-field prepend-icon="filter_list" label="type filter for mimetypes" single-line hide-details v-model="q" clearable></v-text-field>  

  </v-toolbar>
	<v-card-text>
	  <v-list style="height: 300px; overflow-y: auto;"> 
	  
	        <v-list-item v-for="(mime,index) in items" :key="index" dense ripple @click="setItem(mime,index)">
	          <v-list-item-avatar>
	            <v-icon v-if="false">check_circle</v-icon>
	            <v-icon v-else>insert_drive_file</v-icon>
	          </v-list-item-avatar>
	
	          <v-list-item-content>
	            <v-list-item-title>{{ mime.name }}</v-list-item-title>
	          </v-list-item-content>
	
	          <v-list-item-action>
	           {{ mime.mode }}
	          </v-list-item-action>
	        </v-list-item>
	     
	  </v-list>
  </v-card-text>
  <v-card-actions>
 
  </v-card-actions>
</v-card>
</v-menu>
 `,
      
  props: {
    mimetype:{
       type:String, default:"(default)"
    }
  },
    
  data () {
    return {
      q: null,
      show: false
    }
  },
  
  methods:{
    setItem(mime,index){
      console.log("selected ",mime)
      this.$emit('selected', mime)
      this.show=false
    }
  },
  
  computed:{
  items(){
    return this.$MimeTypes.list().filter(item=>{return (!this.q) || item.name.toLowerCase().includes(this.q.toLowerCase())})
  }
  }, 
  
  created:function(){
    //console.log("qd-mimelist",this.$MimeTypes.list())
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-navlist2.vue
Vue.component('qd-navlist2',{template:` 
 <v-list dense nav>
    <template v-for="(item, i) in items">
      <v-list-group v-if="item.children" :key="item.text" v-model="item.model" :prepend-icon="item.icon" :title="item.text">
            <template v-slot:activator>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>
                    {{ item.text }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </template>
             <v-divider :inset="true"></v-divider>
            <v-list-item :to="child.href" v-for="(child, i) in item.children" :key="i" :title="child.text">
	          <v-list-item-icon>
	            <v-icon v-if="mini" v-text="child.icon"></v-icon>
	          </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>
                  {{ child.text }}
                </v-list-item-title>
              </v-list-item-content>
               <v-list-item-action>
              <v-icon v-text="child.icon"></v-icon>
            </v-list-item-action>
            </v-list-item>
            <v-divider :inset="true"></v-divider>
          </v-list-group>

          
            <v-list-item v-else :key="item.text" :to="item.href">
            <v-list-item-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>
                {{ item.text }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          </template>
        </v-list>
 `,
      
  props: ['items','mini']
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-panel.vue
Vue.component('qd-panel',{template:` 
 <v-layout>
		<v-flex>
		<slot name="body"></slot>
		</v-flex>
		
		<v-flex v-if="show" xs4 grey lighten-3>
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-range.vue
Vue.component('qd-range',{template:` 
  <v-menu left bottom :close-on-content-click="false">
  <template v-slot:activator="{ on }">
    <v-chip v-on="on"> 
    Range
      <v-icon right>arrow_drop_down</v-icon>
    </v-chip>
   </template>
      
   <v-card>
    <v-card-title class="headline grey lighten-2" primary-title>Range</v-card-title>
     
	<v-card-text>
	 <v-text-field type="number" v-model.number="query.window" label="window (secs)"> </v-text-field>
	 <v-text-field type="number" v-model.number="query.start" label="start"> </v-text-field>
    <v-text-field type="number" v-model.number="query.limit" label="limit"> </v-text-field> 
  </v-card-text>
  <v-card-actions>
  <v-btn>Reset</v-btn>
  </v-card-actions>
</v-card>
</v-menu>
 `,
      
  props: ['query' ]
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-search.vue
Vue.component('qd-search',{template:` 
  <v-combobox placeholder="Search..." prepend-icon="search" autocomplete :loading="loading" clearable :items="items2" @keyup.enter="goSearch" :search-input.sync="si" v-model="q">
            
            <template slot="item" slot-scope="{ index, item, parent }">
		             <v-list-item-action>
		                 <v-btn icon :to="item.value">		                  
		                  <v-icon>arrow_forward</v-icon>	
		                 </v-btn>
		            </v-list-item-action>
                      <v-list-item-content>
                        
					      <v-list-item-title>
					          {{ item.text }}
					      </v-list-item-title>
					      <v-list-item-subtitle>Page {{ item.value }}</v-list-item-subtitle>
					   </v-list-item-content>
             </template>
              
     </v-combobox>
 `,
      
  data:function(){return {
    q: "",
    loading: false,
    searchItems:[],
    si: '',
    items2:[{text:"todo", value:"TODO"},
            {text:"set", value:"SET"},
            {"text":"search",value:"SEARCH"}
            ]
  }
  },
  methods: {
    querySelections (v) {
      this.loading = true
      // Simulated ajax query
      setTimeout(() => {
        this.items2 = this.si?this.matchItems(this.si.toLowerCase()):[],
        this.loading = false
      }, 500)
    },
    
    goSearch(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
      
    matchItems(typed){
        var hits=this.titles;
        var typed=typed.toLowerCase();
         hits=hits.filter(item=>item.title.indexOf(typed) !== -1)
        return hits.map(r=>{return {text:r.title,
                                    value:r.path}
                      });
      },
      
      gopage(){
        alert("GO")
      }
  },
  watch: {
    si:function(val){
      console.log("si: ",val);
      this.querySelections();
    }
  },
  created:function(){
	  var hits=this.$router.options.routes;  
	  var res=[];
	  const extract = function(item,path) {if(item.hasOwnProperty("meta")) 
		                                     return {title: item.meta.title.toLowerCase(), 
		                                             path: path + item.path}
	                                     else if(item.hasOwnProperty("children"))
	                                    	 return item.children.map(item=>extract(item, path  +"/"))
	                                     else
	                                    	 return []
	                                      };
	  res=hits.map(item=>extract(item,item.path))
	  res=res.flat(Infinity);
	 //console.log("extract",res)
	  this.titles=res;
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-table.vue
Vue.component('qd-table',{template:` 
 <v-container fluid>
  <v-card>
   <v-toolbar>
    <v-text-field prepend-icon="filter_list" label="Filter items..." single-line hide-details v-model="search" clearable></v-text-field>   
      <v-spacer></v-spacer>
         <v-btn icon :loading="loading" :disabled="loading" @click="getItems">
    <v-icon>refresh</v-icon>
    </v-btn> 
    <span>{{ entity }}</span>
    </v-toolbar>
    
   <v-data-table :headers="headers" :items="items" :search="search" v-model="selected" show-select class="elevation-1" :no-data-text="noDataMsg">
    <template slot="items" slot-scope="props">
     <td>
        <v-checkbox primary hide-details v-model="props.selected"></v-checkbox>
      </td>
      <td v-for="col in headers" :key="col.name">{{ foo(props,col) }}</td>
    </template>
  </v-data-table>
  </v-card>
 </v-container>
 `,
      
	  props: {
	    headers: {
	      default: [
	        { text: 'Name', value: 'id'},
	        { text: 'Permission', value: 'state' }
	      ]
	  },
	  dataUri:{
	    default: "entity"
	  },
	  noDataMsg:{
	    default: "No data found."
	  },
	  entity:{
      default: "entity"
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
      getItems(){
        this.loading=true;
        HTTP.get(this.dataUri)
        .then(r=>{
           this.loading=false;
           console.log("items",r.data.items,"headers ",this.headers);
           this.items=r.data.items;
        })
     },
     foo(props,header){
       //console.log("value ",header)
       if(header){
         return  props.item[header.value]
       }
       return props.selected
     }
  },
  created:function(){
    console.log("qd-table");
    this.getItems();
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/qd-tablist.vue
Vue.component('qd-tablist',{template:` 
  <v-menu left bottom :close-on-content-click="false">
  <template v-slot:activator="{ on }">
    <v-chip v-on="on"> 
    {{ edittabs.length }}
      <v-icon right>arrow_drop_down</v-icon>
    </v-chip>
   </template>
      
   <v-card>
    <v-toolbar>
      <v-text-field prepend-icon="filter_list" label="type filter text" single-line hide-details v-model="q" clearable></v-text-field>  

  </v-toolbar>
	<v-card-text>
	  <v-list style="height: 300px; overflow-y: auto;"> 
	        <v-list-item v-for="index in edittabs.sorted(q)" :key="index" dense ripple @click="setItem(index)" :inactive="index == current">
	          <v-list-item-avatar :title="edittabs.items[index].contentType">
	            <v-icon v-if="index == current">check_circle</v-icon>
	            <v-icon v-else>insert_drive_file</v-icon>
	          </v-list-item-avatar>
	
	          <v-list-item-content :title="edittabs.items[index].url">
	            <v-list-item-title>{{ edittabs.items[index].name }}</v-list-item-title>
	          </v-list-item-content>
	
	          <v-list-item-action>
	            {{ edittabs.items[index].id }} [{{ index }}]
	          </v-list-item-action>
	        </v-list-item>
	  </v-list>
  </v-card-text>
  <v-card-actions>
  current : {{ current }}
  </v-card-actions>
</v-card>
</v-menu>
 `,
      
  props: ['edittabs',
          'current'
    ],
    
  data () {
    return {
      q:null
    }
  },
  
  methods: {
    setItem(index){     
       this.$emit('selected', index)
    }, 
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
    },
    rebuild(data){
    	var items = new vis.DataSet(data);
        //this.timeline = new vis.Timeline(this.$el, items, this.groups, this.options);
        this.timeline.setItems(items)
        this.timeline.fit(true)
    }
  },
  watch:{
	  items(newItems){
		  console.log("vis-time-line: new items:" + newItems.length)
		  this.rebuild(newItems)
	  },
	  options(newOpts){
		  console.log("opts: ",newOpts)
	  }
  },
  mounted: function () {
   
    var options = this.options;
    var groups = this.groups;
    var items = new vis.DataSet(this.items);
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-entitylink.vue
Vue.component('vp-entitylink',{template:` 
		    <router-link :to="'entity/'+entity">E</router-link>   
 `,
      
  props: ['entity']
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-favorite.vue
Vue.component('vp-favorite',{template:` 
  <v-menu :close-on-click="false" offset-x :close-on-content-click="false" :nudge-width="200" v-model="frmfav">
    <template v-slot:activator="{ on }">
       <v-btn v-on="on" text @click.stop="set(!frmfav)" icon title="Bookmark this page">
          <v-icon>star_border</v-icon>
       </v-btn>
     </template>
       <v-card style="width:400px;">
            <v-toolbar class="green"> 
        <v-card-title>
            Bookmark this page
          </v-card-title>
          </v-toolbar>
          
         <v-card-text>
            <h6>{{$route.meta.title}}</h6>
            <v-combobox multiple v-model="tags" label="tags" chips tags :items="taglist"></v-combobox>
         </v-card-text>
         
         <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" text @click.stop="set(false)">Cancel</v-btn>
            <v-btn color="primary" text @click.stop="favorite(); set(false)">Save</v-btn>
          </v-card-actions>
        </v-card>
   </v-menu> `,
       
  props: { 
    frmfav: Boolean
  },
  data(){
    return {
      tags: [],
      taglist: [
        'todo',
        'find',
        'some',
        'good',
        'tags'
      ],
    }
  },
  methods:{
    set(v){
      this.$emit('update:frmfav', v)
    },
    
    favorite(){
      this.$store.commit('increment')
      console.log(this.$store.state.count)
      alert("save");
    }
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-filepick.vue
Vue.component('vp-filepicker',{template:` 
 <v-layout>
		<v-flex>
		<slot name="body"></slot>
		</v-flex>
		
		<v-flex v-if="show" xs4 grey lighten-3>
		<slot name="aside"></slot>
		</v-flex>
</v-layout>
 `,
      
  props: ['show'],
  created:function(){
      console.log("vp-filepicker");
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-job.vue
Vue.component('vp-job',{template:` 
  <v-toolbar dense>
       <v-chip class="primary white--text">{{job.id}}</v-chip>
           <v-chip class="primary white--text">{{job.job}}</v-chip>
      
           <v-chip label class="grey white--text"> 
           <v-avatar class="red">W</v-avatar><v-icon>lock</v-icon>
           {{ jobState.writes }}</v-chip>
           
            <v-chip label class="grey white--text"> 
	            <v-avatar class="amber">R</v-avatar><v-icon>lock</v-icon>
	            {{ jobState.reads }}</v-chip>
 
        <v-spacer></v-spacer>
          <v-progress-circular v-if="waiting" indeterminate class="primary--text"></v-progress-circular>
          <v-chip>{{ jobState.state }}</v-chip>
         <v-chip class="primary white--text">
          <v-avatar>  <v-icon>timer</v-icon></v-avatar>
         {{elapsed}}ms</v-chip>
   </v-toolbar>
 `,
      
  props: ['job',
          'jobState',
          'elapsed',
          'waiting' 
          ],
  created:function(){
      console.log("vp-job: ", this.job);
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-notifications.vue
Vue.component('vp-notifications',{template:` 
   <v-card>
         <v-app-bar class="amber white--text">
                <v-toolbar-title>Notifications </v-toolbar-title>
                {{ $notification.nextId }}
                 <v-btn @click="refresh" icon><v-icon>refresh</v-icon></v-btn>
          <v-spacer></v-spacer>
          <v-btn @click="set(false)" icon><v-icon>close</v-icon></v-btn>
          </v-app-bar>
          <v-card-text>
        <v-list three-line>
          <template v-for="msg in $notification.messages">
           <v-list-item v-bind:key="msg.index" @click>
              <v-list-item-avatar>
                   <v-icon color="red">swap_horiz</v-icon>
              </v-list-item-avatar>
              
             <v-list-item-content>
              <v-list-item-title>{{  msg.created | fromNow("from") }}</v-list-item-title>
              <v-list-item-subtitle v-html="msg.html">msg</v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action-text>
              <v-chip>#{{ msg.index }}</v-chip>
           </v-list-item-action-text>
            <v-list-item-action-text v-if="msg.elapsed"> ({{ msg.elapsed }} ms) </v-list-item-action-text>
            
           
            </v-list-item>
           </template>
         </v-list>
      </v-card-text>

      </v-card>
 `,
      
  props: { 
    showNotifications: Boolean
  },
  data:function(){
    return {timer:null};
  },
  methods:{
    set(v){
      this.$emit('update:showNotifications', v)
    },
    refresh(){
      this.$forceUpdate();
    }
  },
  watch:{showNotifications(v){
    if(v){
       this.refresh();
       if(!this.timer) this.timer=setInterval(()=>{ this.refresh() }, 1000);
    }
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
    alert("notifi gone")
  }
    
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-paramform.vue
Vue.component('vp-paramform',{template:` 
  <v-card>
     <v-toolbar color="blue lighten-3" dense>
       <v-card-title>{{ description }}</v-card-title>
       <v-spacer></v-spacer>
          <router-link :to="{name:'edit', query:{url: url}}">
            <v-icon :title="url">history</v-icon>{{ name }}
          </router-link>
    </v-toolbar>
    <v-card-text>
       <v-form ref="form" lazy-validation>

              <v-layout row>
              
	              <v-layout column xs8> 
	              <v-flex v-for="field in fields" :key="field.model">
	              
	              <v-text-field v-if="field.type === 'xs:anyURI'" v-model="params[field.model]" :label="field.label" clearable :rules="fieldrules(field)" filled append-outer-icon="send" @click:append-outer="source(field)"></v-text-field>
	              
	              <v-switch v-else-if="field.type === 'xs:boolean'" :label="field.label" v-model="params[field.model]">
	              </v-switch>
	              
	              <v-text-field v-else filled v-model="params[field.model]" :label="field.label" clearable></v-text-field>
	                
	              </v-flex>
	             
	              </v-layout>
               <v-layout column>TODO
               </v-layout> 
              </v-layout>
            </v-form>
           
       </v-card-text>
           <v-card-actions>
              <v-btn @click="clear()" id="btn-clear">Clear</v-btn>
		     <v-btn @click="reset()">Reset</v-btn>
           </v-card-actions>
           <v-btn @click="zlog()">console</v-btn>
           
    </v-card>
 `,
      
  props: ['endpoint'],
  data: function(){
    return {
      fields: [],      
      params: null,
      description: null,
      updating: false,
      url: null,
      rules: {
        required: value => !!value || 'Required.'
      }
    } 
  },
  methods:{
      reset(){
        HTTP.get(this.endpoint)
        .then(r=>{
          this.fields= r.data.fields;
          this.description= r.data.description;
          this.updating= r.data.updating;
          this.url= r.data.url;
          this.params = Object.assign({}, this.params, r.data.values);
        })
     },
     source(field){
       router.push({ path: 'tabs', query: { url:this.params[field.model]}})
     },
     zlog(){
    	 console.log(JSON.stringify(this.params)) 
     },
     clear () {
       this.$refs.form.reset()
     },
     fieldrules(field){
       return [this.rules.required];
     },
     submit(){
       return HTTP.post(this.endpoint, Qs.stringify(this.params));
     },
     valid(){
       return this.$refs.form.validate()
     }
  },
  computed: {
	  name(){
	   return this.url && this.url.substring(this.url.lastIndexOf('/') + 1)
	  }
  },
  watch:{
	 params(vold,vnew) {
		 console.log("params: ",vnew)
	 }
  },
  created:function(){
    this.reset();
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-selectpath.vue
Vue.component('vp-selectpath',{template:` 
   <v-dialog v-model="frmfav" persistent max-width="800">
   <template v-slot:activator="{ on }">
      <v-btn v-on="on" @click.stop="set(!frmfav)" icon title="Add ">
   </v-btn></template>
   
      <slot>
      <v-icon>add_circle</v-icon>
       </slot>
       
       <v-card>
          <v-toolbar> 
               <v-card-title>
                Content of new tab {{type}}
              </v-card-title>
          </v-toolbar>
          
         <v-card-text>
         Content:
         
          <v-tabs v-model="type" icons-and-text centered>
             <v-tab v-for="item in protocols" :key="item.name">
              {{item.name}}
                <v-icon>{{item.icon}}</v-icon>
              </v-tab>
    
 
              <v-tab-item v-for="item in protocols" :key="item.name">
                <v-card flat>
                  <v-card-text>
                    <v-text-field v-for="f in item.fields" :key="f.model" :label="f.label" :v-model="f.model"></v-text-field>
                  </v-card-text>
                </v-card>
              </v-tab-item>
          </v-tabs>
          
         </v-card-text>
        <v-card-actions>
               <v-spacer></v-spacer>
               <v-btn color="primary" text @click.stop="set(false)">Cancel</v-btn>
               <v-btn color="primary" text @click.stop="favorite(); set(false)">Add tab</v-btn>
         </v-card-actions>
        </v-card>
   </v-dialog>
 `,
       
  props: { 
    frmfav: Boolean
  },
  data(){
    return {
      type: 0, 
      xmldb: "",
      webfile:"",
      protocols:[
        {name: "new",icon: "fiber_new",fields: [{label: "test gg", model: "webfile"}]},
        {name:"xmldb",icon:"favorite", fields: [{label: "test2", model: "webfile"}]},
        {name:"webfile",icon:"account_box", fields: [{label: "test3", model: "webfile"}]},
        {name:"file",icon:"fiber_new", fields: [{label: "test 4", model: "webfile"}]} 
        ]
      }
  },
  methods:{
    set(v){
      this.$emit('update:frmfav', v)
    },
    
    favorite(){
      this.$emit('selectpath', {
          type:this.protocols[this.type],
          uri: this.xmldb,
          name: "doc" + moment().format("YYYY-MM-DDThh:mm:ss") ,
          text:"Some text"
          })
    }
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/vp-validationreport.vue
Vue.component('vp-validationreport',{template:` 
       <v-card v-if="report">
       
       <v-toolbar class="orange darken-1">
          <v-card-title>Validation</v-card-title>
          <span v-for="(value, key) in report.msgcounts">{{ key }}:{{ value }}</span>
          </v-toolbar>
          
          <v-card-text>
            <pre>*** {{ report }}</pre>
          </v-card-text>
       
        </v-card>
 `,
      
  props: ['report']
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
          'events',  // event bus if set handles "eventFired",cmd 
          'settings',
          'minLines',
          'completer',
          'snippets'
          ],
  data () {
    return {
      editor: Object,
      beforeContent: '',
      aceSettings:{
          theme: "github",
          themeDark: "chaos",
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
        //console.log("aCe settings:",vnew,this)
        this.applySettings(vnew)
        },
      deep:true
    },
 
    // whenever theme changes, this function will run
    "$vuetify.theme.dark": function (newState) {this.setTheme()}
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
    
    setTheme(){
    	 var theme=this.$vuetify.theme.dark ? this.aceSettings.themeDark : this.aceSettings.theme;
         this.editor.setTheme(`ace/theme/${theme}`)
    },
    
    applySettings(aceSettings){
      var theme=this.$vuetify.theme.dark?aceSettings.themeDark:aceSettings.theme;
      this.editor.setTheme(`ace/theme/${theme}`)
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
   //console.log("setValue: ",this.content)
    this.editor.setValue((this.content == null)?"NULL":this.content, 1);
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
    });
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
    
    this.editor.getSession().selection.on('changeCursor', (e) => {
      var position = this.editor.selection.cursor;
      var token =  this.editor.getSession().getTokenAt(position.row, position.column);
      //console.log("token",token);
      this.$emit('token', token);
    });
    
    if(this.events){
      this.events.$on('eventFired', (cmd) => {
      if(cmd=="outline"){
       this.outline();
      }else this.command(cmd);
    });
    }
    
    if(this.completer){
	    var langTools = ace.require("ace/ext/language_tools");
	    langTools.addCompleter(this.completer);  
    }
    
    if(this.snippets){
      var snippetManager = ace.require("ace/snippets").snippetManager;
      snippetManager.register(this.snippets, "xquery");
      }
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/aceextras.js
// ace customisations installs to $aceExtras
// rhymeCompleter, basexCompleter, snippets
const AceExtras={
    rhymeCompleter:  {
      // test completer
      getCompletions: function(editor, session, pos, prefix, callback) {
        if (prefix.length === 0) { callback(null, []); return }
        axios.get("http://rhymebrain.com/talk",{params:{function:"getRhymes",word:prefix}})
        .then(
            function(wordList) {
                // wordList like [{"word":"flow","freq":24,"score":300,"flags":"bc","syllables":"1"}]
                var r=wordList.data.map(function(ea) {
                  return {name: ea.word, value: ea.word, score: ea.score, meta: "rhyme"}
                })
                callback(null,r)
                })
 
      }
    },
    
    //basex functions
    basexCompleter: {
      getCompletions: function(editor, session, pos, prefix, callback) {
        if (prefix.length === 0) { callback(null, []); return }
        console.log("dd",prefix)
        callback(null, [{
              caption: "archive:create#2",
              snippet: "archive:create(${1:entries}, ${2:contents})",
              score: 100,
              meta: "archive",
              completer: this
          }, {
              caption: "archive:create#3",
              snippet: "archive:create(${1:entries}, ${2:contents}, ${3:options})",
              score: 100,
              meta: "archive",
              completer: this
          }])
      }
  },

    
    snippets:[
          {
            name: "test",
            content: "this is a test snippet",
            tabTrigger: "test:"
          },
          {
            name: "sniptest2",
            content: "some2",
            tabTrigger: "he"
          }
    ],
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$aceExtras', {
          get () { return AceExtras }
      })  
    }
};
Vue.use(AceExtras);


// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/auth.js
// Authorization Object
const Auth={
    user: "guest",
    role: null,
    session: null,
    created: null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  
    },
    logout(){
      Auth.user="guest";
      Auth.role=null;
    }
};
Vue.use(Auth);


// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/EditTabs.js
//Manage array of text sources  used for:edit tabs
// item{
//     name: file name
//     contentType: "text/xml",
//     mode: "xml",
//     text:
//     id: ids have the form "Tn"
//     uri: path to save to
// requires: Settings,HTTP
//
const GEditTabs={
    data(){
      return {
                items:[],
                length: 0,
                nextId: 1,
                currentId: null,
                restored: null
            }
    },
    
    methods: {
      // add tab return index
      addItem(tab,pos){
        //console.log("new: ",tab," ,pos:",pos);
        var def={name: "AA"+this.nextId, 
                 contentType: "text/xml",
                 mode: "xml",
                 text: "<foo>" +this.nextId +"</foo>",
                 uri: null
                 };
        var etab = Object.assign(def,tab);
        etab.id= "T" + this.nextId
        if(pos){
          this.items.splice(pos, 0, etab)
        }else{
          this.items.push (etab);
        }
        this.length++
        this.nextId++;
        var ind=this.items.indexOf(etab)
        return ind;
      },
      
      closeItem(item){
        //https://github.com/vuejs/vue/issues/5855
        this.items=this.items.filter(t => t.id !== item.id)
        this.length--;
      },
      
      // fetch content from server and create tab
      loadItem(url){
        HTTP.get("get",{params: {url:url}})
        .then(r=>{
            console.log(r)
            var tab={
              text: ""+ r.data.data,
              url: url,
              name: url.split(/.*[\/|\\]/)[1]
            };
            this.addItem(tab);
          })
          .catch(error=> {
            console.log(error);
            alert("Get query error:\n"+url)
          });
      },
      
      save(){
        Settings.setItem('edit/items',this.items);
      },
      
      restore(){
        that=this
        this.restored=Settings.getItem('edit/items')
        .then(function (v){
           //console.log("items ",v)
           v.forEach(v =>that.addItem(v))
           })
         .catch(error=> {
             console.log(error);
             alert("load error")
           });   
      },
      
      sorted(q){ /* return sorted and filtered array of tab indices */
        var len=this.items.length
        var indices = new Array(len);
        for (var i = 0; i < len; ++i) indices[i] = i;
        var list=this.items;
        indices=indices.filter(a=>(!q) || list[a].name.toLowerCase().includes(q.toLowerCase()))
        indices.sort((a,b) =>list[a].name.localeCompare(list[b].name))
        return indices
      }
    },
    created(){
      console.log("EditTabs created")
    }
};



// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/filters.js
/**
 * some vue filters, requires moment
 *  formatDate
 *  fromNow
 *  readablizeBytes
 *  round 
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

Vue.filter('pretty',function(value) {
  return JSON.stringify(value, null, 2);
});


// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/fullscreen.js
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



// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/mimetypes.js
// Mimetype info as vue extension. defines $MimeTypes
// 
// 
const MimeTypes=new function(){
  var formatdom= t=>html_beautify(t, { indent_size: 3 ,indent_inner_html:true});
  var formatjs= t=>js_beautify(t, { indent_size: 2 });
  var formatcss= t=>css_beautify(t, { indent_size: 2 });
 
 // mimetype to ace mode
 this.contentType={
     "text/plain":{ mode: "text"},
     "text/xml":{ mode: "xml"},
     "application/xml":{ mode:"xml"},
     "application/xquery":{ mode:"xquery"},
     "text/ecmascript":{ mode:"javascript"},
     "application/sparql-query": {mode:"sparql"},
     "text/html":{ mode:"html"},
     "text/turtle":{ mode:"turtle"},
     "text/css": {mode:"css"},
    "image/svg+xml":{ mode:"svg"}
 };

  
  this.mode={
    "text": {
      "icon": "library_books"
    },
    "javascript": {
      "format": formatjs
    },
   "xml": {
     "format": formatdom
    },
    "html": {
      "format": formatdom
    },
    "css": {
      "format": formatcss,
      "icon": "school"
    },
    "xquery": {
      "icon": "spa"
    }
  };
  // return [{name:.. mode:..}..]
  this.list=function(){
    var that=this
    var h= Object.keys(this.contentType).map(
        function(k){ return {name: k, mode: that.contentType[k].mode}}
        )
    return h
  };
  
  this.icon=function(mode){
    var i= this.mode[mode] && this.mode[mode].icon
    return  i || "insert_drive_file"
  };
  
  this.install=function(Vue){
      Object.defineProperty(Vue.prototype, '$MimeTypes', {
        get () { return MimeTypes }
    })  }

};
Vue.use(MimeTypes);

// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/components/notification.js
//Notification Object
const Notification={
    messages:[],
    nextId: 0,
    unseen:0,
    add(opts){
      var data=Object.assign({
          html: 'no html',
          index: ++this.nextId,
          created: new Date(),
          elapsed: null
      },
      opts);
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


// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/404.vue
const Notfound=Vue.extend({template:` 
 <v-container fluid>
 Not found
 </v-container>
 `,
      
  data:  function(){
    return {
      message: 'bad route!'
      }
  },
 mounted:function(){
    console.log("notfound",this.$route.path)
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/about/about.vue
const About=Vue.extend({template:` 
  
    <v-container>
    <v-card hover raised> 
    <v-toolbar>
<v-card-title>VUE-POC </v-card-title>
 <span v-if="pack"> {{ pack.version }}</span>
<v-spacer></v-spacer>

 </v-toolbar>

 <v-card-text>
      <v-layout align-center>
        <v-flex color="grey lighten-2">
          <span class="subheading">A development environment for managing XML sources and processes.</span>
      
          <v-divider class="my-3"></v-divider>
       
          <div class="title mb-3">Links</div>
              
      <v-list dense nav>     
         <v-list-item v-for="(item, i) in links" :key="i" :to="item.to" link>
         <v-list-item-icon>
            <v-icon v-text="item.icon"></v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title v-text="item.text">fill</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        
      </v-list>
      
           <v-layout row wrap>
          <v-flex xs6>
          <v-list dense>
		 	     
	          <v-list-item> <a href="https://vuejs.org/" target="new">vue.js</a></v-list-item>
              
			<v-list-item><a href="https://vuetifyjs.com/vuetify/quick-start" target="new">vuetifyjs</a></v-list-item>
					    
			<v-list-item><a href="https://github.com/axios/axios" target="new">axios</a></v-list-item>
					
			<v-list-item><a href="https://github.com/beautify-web/js-beautify" target="new">js-beautify</a></v-list-item>
					    
			<v-list-item><a href="https://developers.google.com/web/tools/workbox/" target="new">workbox</a></v-list-item>
              
              <v-list-item><a href="https://material.io/tools/icons/?style=baseline" target="new">icons (material)</a></v-list-item>
                  
			 </v-list>
			 </v-flex>
			 <v-flex xs6>
			 <ul>
			  <li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
			  <li><a href="/dba" target="new">DBA app</a></li>
			   <li> <router-link to="database?url=%2Fvue-poc%2F">DB</router-link></li>
			</ul>
			</v-flex>
			</v-layout>
        </v-flex>
     
	<v-speed-dial :bottom="true" :right="true">
      <template v-slot:activator>
        <v-btn v-model="fab" color="blue darken-2" dark fab>
          <v-icon v-if="fab">mdi-close</v-icon>
          <v-icon v-else>mdi-account-circle</v-icon>
        </v-btn>
      </template>
      <v-btn fab dark small color="green">
        <v-icon>mdi-pencil</v-icon>
      </v-btn>
      <v-btn fab dark small color="indigo">
        <v-icon>mdi-plus</v-icon>
      </v-btn>
      <v-btn fab dark small color="red">
        <v-icon>mdi-delete</v-icon>
      </v-btn>
    </v-speed-dial>
	 </v-layout>  		
 </v-card-text>
 </v-card>
    </v-container>
      
	 `,
      
  data:  function(){
    return { 
      pack: null,
      fab: false,
      links:[
    	  {text:"3rd party components",icon:"mdi-clock",to:"about/package"},
    	  {text:"components",icon:"mdi-flag",to:"about/vue-cmps"},
    	  {text:"routes",icon:"mdi-plus",to:"about/routes"},
    	  {text:"routes2",icon:"mdi-plus",to:"about/routes2"}
      ]
  }
  },
  methods:{
	  refresh(){
	      HTTP.get("package.json")
	      .then(r=>{
	        console.log("status",r)
	        this.pack=r.data
	        //this.$forceUpdate()
	      })  
	    },
  },
  created(){
	  this.refresh()
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/about/package.vue
const Package=Vue.extend({template:`  
<v-container>
<v-card hover raised> 
    <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" :crumbs="[{to: '/about', text:'about'}, {text: '3rd party components', disabled: false, menu: 'todo'}]">crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer></v-spacer> 
	</v-toolbar>
	 <v-data-table :headers="headers" :items="pack" :items-per-page="100" class="elevation-1"></v-data-table> 
</v-card> 
</v-container> 
 `,
      
  data:  function(){
    return { 
      pack: [],
      fab: false,
      showmenu: false,
      headers:[
    	  { text: 'name', value: 'name' },
    	  { text: 'version', value: 'version' }
    	  ], 
  }
  },
  methods:{
	  refresh(){
	      HTTP.get("package.json")
	      .then(r=>{
	        console.log("status",r)
	        var m=r.data.dependencies
	        var d = Object.keys(m).map(function (v,i){return {"name": v ,"version": m[v]}});
	        this.pack=d.sort((a,b)=>a.name.localeCompare(b.name))
	      })  
	    },
  },
  created(){
	  this.refresh()
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/about/routes.vue
const Routes=Vue.extend({template:`  
<v-container>
<v-card hover raised> 
    <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" :crumbs="[{to: '/about', text:'about'}, {text: 'routes', disabled: false, menu: 'todo'}]">crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer></v-spacer> 
	</v-toolbar> 
	<v-card-text>  
	<v-data-table :headers="headers" :items="routes" :items-per-page="100" class="elevation-1"></v-data-table>
	 <pre>{{ pack | pretty }}</pre> </v-card-text> 
</v-card> 
</v-container> 
 `,
      
  data:  function(){
    return { 
      pack: null,
      fab: false,
      showmenu: false,
      routes:null,
      headers:[
    	  { text: '#', value: 'index' },
    	  { text: 'Path', value: 'path' },
    	  { text: 'Name', value: 'name' },
          { text: 'Title', value: 'title' },
          { text: 'Children', value: 'children' }
    	  ], 
  }
  },
  methods:{
	  refresh(){
		  var hits=this.$router.options.routes;
		  hits=hits.map(function(v,i){
			  return {"index":i,
				      "path": v.path,
				      "name": v.name,
				      "title": v.meta && v.meta.title,
				      "children": v.children && v.children.length
		  }});
		  hits.sort((a,b)=>a.path.localeCompare(b.path) )
		  this.routes=hits
		  console.log("routes: ",hits)
	    },
  },
  created(){
	  this.refresh()
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/about/routes2.vue
const Routes2=Vue.extend({template:`  
<v-container>
  <v-card hover raised> 
  <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" :crumbs="[{to: '/about', text:'about'}, {text: 'routes tree', disabled: false, menu: 'todo'}]">crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer>
	<v-text-field v-model="search" label="Search routes" prepend-icon="filter_list" flat solo-inverted hide-details clearable clear-icon="mdi-close-circle-outline"></v-text-field>
	</v-spacer>
	<v-btn @click="refresh"> 
	<v-icon>refresh</v-icon>
    </v-btn>
	</v-toolbar> 
	<v-card-text>
	 <v-row>
      <v-col>  
	 <v-treeview style="max-height: calc(100vh - 210px); overflow-y: auto;" v-model="tree" :open="open" :items="items" activatable item-key="index" :search="search" :filter="filter" open-on-click v-on:update:active="doActive">
    <template v-slot:prepend="{ item, open }">
      <v-icon v-if="item.children">
        {{ open ? 'mdi-folder-open' : 'mdi-folder' }}
      </v-icon>
      <v-icon v-else>mdi-file-document-outline</v-icon>
    </template>
    
    <template v-slot:label="{ item, open }">
    <v-card :id="'path'+item.index">
    <v-card-title style="padding:0">
     
     {{ item.name }} 
    
     <v-spacer></v-spacer>
    
         {{ item.index }} 
   
       </v-card-title>
       </v-card>
    </template>
    
  </v-treeview>
  </v-col>
  
  <v-col v-if="active">
  <v-card>
  <v-toolbar> 
  <v-card-title>
  {{ active.path}}
  </v-card-title>
   <router-link :to="active.path"><v-icon>link</v-icon></router-link>
  <v-spacer></v-spacer>
  <v-btn @click="$vuetify.goTo('#path'+ active.index)">{{ active.index }}</v-btn>
  </v-toolbar>
  <v-card-text>ffgfgfgf bbfb
  <pre><code>{{ active | pretty }}</code></pre>
  </v-card-text>
  </v-card>
  </v-col>
  </v-row>
</v-card-text></v-card>

</v-container> 
 `,
      
  data:  () => ({
	  showmenu: false,
      open: [],    
      tree: [],
      items: [],
      active:null, // object from routelist or null.
      routes: [],
      search:null
    }),

  methods:{
	  refresh(){
		  var hits=this.routelist();
		  console.log("routelist",this.$router.options.routes)
		  this.items=hits
		  
	    },
	    doActive(a){
	    	this.active= a[0]?this.findItem(this.routelist(),a[0],"index"):null
	    	console.log("act",a[0],this.active)
	    },
	    routelist(){
	    	 var hits=this.$router.options.routes;
			  var index=0;
			  var pick=function(list,parent){
				  return list.map(function(route){
					  const path=(parent.path?parent.path + "/":"")+ route.path+(route.children?"/":"")
					  const data={
							  "index":++index,
						      "refname": route.name,
						      "path": route.path,
						      "name": path,
						      "title": route.meta && route.meta.title
					  };
					  if(route.children){
						  data.children=pick(route.children,data)  
					  }
					 return data
				  })
				  };
			  hits=pick(hits,{})
			  hits.sort((a,b)=>a.name.localeCompare(b.name) )
			  return hits	
	    },
	    findItem (tree, value, key = 'id', reverse = false) {
	    	  const stack = tree
	    	  while (stack.length) {
	    	    const node = stack[reverse ? 'pop' : 'shift']()
	    	    if (node[key] === value) return node
	    	    node.children && stack.push(...node.children)
	    	  }
	    	  return null
	    	}
  },
  
  watch: {
	    active: function (a) {
	    	const query = Object.assign({}, this.$route.query);
	    	if(a){
			 query.index = a.index
	    	}else 
	    		delete query.index;
			 this.$router.push({ query });
	    }
  },
  
  created(){
	  this.routes=this.routelist()
	  console.log("routes: ",this.routes)
	  this.refresh()
	  if(this.$route.query.index){
		    const index= parseInt(this.$route.query.index)
	    	//const h= this.findItem(this.routes,index)
	    	//console.log("search",h, index)
	    	//this.active=h
	    }
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/about/vue-cmps.vue
const VueComps=Vue.extend({template:`  
<v-container>
<v-card hover raised> 
    <v-toolbar> 
    <v-card-title> 
      <qd-breadcrumbs @todo="showmenu= ! showmenu" :crumbs="[{to: '/about', text:'about'}, {text: 'vue-comps', disabled: false, menu: 'todo'}]">crumbs</qd-breadcrumbs> 
     </v-card-title>
	<v-spacer></v-spacer> 
	</v-toolbar> 
	<v-card-text>  <pre>{{ pack | pretty }}</pre> </v-card-text> 
</v-card> 
</v-container> 
 `,
      
  data:  function(){
    return { 
      pack: null,
      fab: false,
      showmenu: false
  }
  },
  methods:{
	  refresh(){
	      HTTP.get("package.json")
	      .then(r=>{
	        console.log("status",r)
	        this.pack=r.data
	      })  
	    },
  },
  created(){
	  this.refresh()
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/adminlog/basexlogdate.vue
const Basexlogdate=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 
   <v-toolbar>
   <v-toolbar-title>
    <v-breadcrumbs :items="crumbs">
         <template slot="item" slot-scope="props">
             <v-breadcrumbs-item :to="props.item.to" :disabled="props.item.disabled" :exact="true">
                  {{ props.item.text }}
              </v-breadcrumbs-item>
          </template>
     </v-breadcrumbs>
   </v-toolbar-title>
   <v-spacer></v-spacer>
   
   <v-text-field prepend-icon="filter_list" label="Filter..." v-model="q" type="search" hide-details single-line @keyup.enter="setfilter" clearable></v-text-field>
   
   <v-spacer></v-spacer>
      <v-btn @click="load" icon :loading="loading" :disabled="loading"><v-icon>refresh</v-icon></v-btn>
   <vp-entitylink entity="basexlogfile"></vp-entitylink> 
   </v-toolbar>
   
   <v-card-text>
    <v-data-table :headers="headers" :items="items" :loading="loading" hide-default-footer :search="q" class="elevation-1">
  
  <template v-slot:item.date="{ item }"> 
	      <td><router-link :to="{path:'logdate/'+ item.date}">
                 {{ item.date }}
                </router-link></td>
    </template>
    
   <template v-slot:item.perhr="{ item }"> 
	      <td>
               <v-sparkline :value="points(item.perhr)" :labels="labels" :fill="true" height="30px" type="bar" :gradient="['red', 'orange', 'yellow','green','blue']"></v-sparkline>  
          </td>
    </template> 
      
    <template slot="no-results">
        No matching results.
    </template>

  </v-data-table>
   </v-card-text>
   </v-card>
   </v-container>
 `,
      
  data:  function(){
    return {
      items: [],
      loading: false,
      q: "",
      message: 'bad route!',
     
      selected:[],
      headers: [
        { text: 'Date', value: 'date' },
        {text: 'Entries', value: 'entries', align:"end" },
        {text: 'Max (secs)', value: 'max', align:"end" },
        {text: 'Rate', value: 'perhr' },
        { text: 'File name', value: 'name' }
        ],
      crumbs:[{to:"/logdate", text:"Log files"}],
      labels: [
          '.','.','.',
          '3am','.','.',
          '6am','.','.',
          '9am','.','.',
          'noon','.','.',
          '3pm','.','.',
          '6pm','.','.',
          '9pm','.','.'
        ],
      }
  },
  methods: {
    load(){
    
      this.loading= true
      HTTP.get("data/quodatum.logfile",{params:{q:this.q}})
      .then(r=>{
        this.items= r.data.items
        this.loading= false
        })
      
    },
    points(perhr){
      return perhr.split(' ').map(Number);
    },
    setfilter(){
      console.log("TODO",this.q)
      this.$router.push({  query: {url:this.url,q:this.q }})
    },
  },
  watch:{
    $route(vnew,vold){
      console.log("ROUTE",vnew,vold)    
      var url=this.$route.query.url
      this.url=url?url:"/";
      if(vnew.query.url != vold.query.url) this.load() 
    }
  },

  created:function(){
    this.q=this.$route.query.q || this.q;
    this.load();
    console.log("logfiles")
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/adminlog/basexlogdate1.vue
const Basexlogdate1=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 <v-toolbar>
	 <v-card-title>
	 <qd-breadcrumbs @todo="showmenu= ! showmenu" :crumbs="[{to: '/logdate', text:'log files'}, {text: date, disabled: false, menu: 'todo'}]">crumbs</qd-breadcrumbs> 
	 </v-card-title>
	
	  <v-menu ref="menu" v-model="showFrom" :close-on-content-click="false" :nudge-right="40" :return-value.sync="query.from" transition="scale-transition" offset-y>
        <template v-slot:activator="{ on }">
          <v-text-field v-model="query.from" label="Start time" prepend-icon="access_time" readonly v-on="on" class="mt-3"></v-text-field>
        </template>
        
        <v-time-picker v-if="showFrom" v-model="query.from" use-seconds @click:second="$refs.menu.save(query.from)" format="24hr"></v-time-picker>
      </v-menu>
   <v-toolbar-items>
	   <v-btn @click="pageBack()" icon> 
		<v-avatar><v-icon>skip_previous</v-icon> </v-avatar> 
	  </v-btn> 
	   <v-btn @click="pageNext()" icon title="increment From by window">
		  <v-avatar> <v-icon>skip_next</v-icon> </v-avatar> 
		</v-btn>
		</v-toolbar-items>
			 
	 <v-spacer></v-spacer>
	  <v-btn-toggle v-model="seek">
          <v-btn small>
            Seek
          </v-btn>
       </v-btn-toggle>
        <v-btn-toggle v-model="fit">
          <v-btn small>
            Fit
          </v-btn>
       </v-btn-toggle>      
	  <qd-range :query="query"></qd-range>
	    
	 <v-toolbar-items>
	<v-btn @click="getItems">
	     <v-avatar><v-icon>refresh</v-icon></v-avatar>
	     </v-btn> 
	
   </v-toolbar-items>
    <v-menu bottom left>
	       <template v-slot:activator="{ on }">
	         <v-btn icon v-on="on">
              <v-icon>more_vert</v-icon>
            </v-btn>
           </template>
             <v-list>
              <v-list-item>
                <v-list-item-title> <qd-range :query="query"></qd-range></v-list-item-title>
              </v-list-item>
            </v-list>
      </v-menu>
                
	 </v-toolbar>
	 
	 <v-card-text>
	   <vis-time-line :items="data" :events="Events" :options="options" @select="select"></vis-time-line>
	 </v-card-text>
 </v-card>
 
 <v-card>
 <v-card-text>
 <pre>{{msg}}</pre>
 </v-card-text>
</v-card>
 </v-container>
 `,
      
  data:function(){
    return {

      loading: false,
      options: {editable: false, clickToUse: false,
    	  timeAxis: {scale: 'minute', step: 1}
      },
      data:[],
    query:{date: this.date, start: 1, limit:30, from:"00:00:00", window:600},
    showmenu: false,
    seek: false,
    fit: false,
    Events: new Vue({}),
    msg:"Select an entry",
    showFrom: false
    }
},
props: ['date'],
methods:{
  fit(){
    this.Events.$emit('fit');
  },
  
  select(sel){  
    var hit=this.data.find(item => item.id==sel )
    var h=JSON.stringify(hit,null,2)
    this.msg= h
  },
  
  pageNext(){
	 this.query.from= this.addtime(this.query.from,this.query.window)
	 this.getItems()
  },
  
  pageBack(){
	  this.query.from = this.addtime(this.query.from,-this.query.window)
	  this.getItems()
  },
  
  addtime(time,secs){
	  var result= moment(time,moment.HTML5_FMT.TIME_SECONDS).add(secs,"s")
	  var result= moment.max(result,moment("00:00:00",moment.HTML5_FMT.TIME_SECONDS))       
	  return  result.format(moment.HTML5_FMT.TIME_SECONDS) 
  },
  
  getItems(){
      this.loading=true
      HTTP.get("logxml", {params:this.query})
      .then(r=>{
       
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        var items=r.data.items
        //console.log("logxml",items)
        // {id: 4, content: 'item 4', start: '2014-04-16', end: '2014-04-19', type: 'point'}
        this.data=items.map(x=>Object.assign({}, x, 
        		{
        	      content: x.text.split(";",1)[0],
        	      title: x.text,
        	      style: x.text.startsWith("[POST] ")?"background-color: red;": "background-color: yellow;",
        	      group: x.user}
               ))


       
        //https://stackoverflow.com/a/39637877/3210344 roundDate(date, moment.duration(15, "minutes"), "ceil")
        var roundDate= function (date, duration, method) {
                  return moment(Math[method]((+date) / (+duration)) * (+duration)); 
        }
        var start=moment(this.date + "T" + this.query.from)
        var first=moment(this.data[0].start);
        var w=Number(this.query.window);
        first1=roundDate(first,moment.duration(w, "seconds"), "floor");
        console.log("Ab",first,this.query,first1,this.data);
        return;
        
        if(first){     	
        	first=moment(first.start)
        	start=roundDate(first,moment.duration(this.query.window, "seconds"), "floor")
        	console.log("rounded ",start)
        	//this.query.from=start.format(moment.HTML5_FMT.TIME_SECONDS)
        }
        this.loading=false 
        this.options.start=start.toDate()
        this.options.end=start.add(this.query.window,"s").toDate()
        //console.log("data",this.data)
        
        }) 
    }
},
watch:{
	"query":{
	    handler:function(vnew,vold){
	      //console.log("watch",this.query)
	     
	      this.$router.push({  query: this.query })
	      if(!this.loading)  this.getItems()
	      },
	    deep:true
	  }
},
created(){
  
  this.query=Object.assign(this.query,this.$route.query)
  this.query.start=Number(this.query.start)
  this.query.limit=Number(this.query.limit)
  console.log("basexlogdate1 query: ",this.$route.query)
  var v= this.query.from.match(/^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$/)
  this.query.from= v? this.query.from : "00:00:00"
  this.getItems();
}
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/adminlog/logadd.vue
const Logadd=Vue.extend({template:` 

 <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
      <span class="white--text">Create log entry</span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn :disabled="!valid" @click="submit">
      submit
    </v-btn>
    <v-btn @click="clear">clear</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid>
<v-form ref="form" v-model="valid" lazy-validation>
    <v-text-field v-model="message" :rules="[v => !!v || 'message is required']" :counter="10" label="Message" required></v-text-field>
   
    <v-select v-model="type" :items="types" :rules="[v => !!v || 'type is required']" label="Type" required></v-select>
    <v-checkbox v-model="checkbox" label="Add more?"></v-checkbox>

   
  </v-form>
 </v-container>
 </v-card-text>
 </v-card>

 `,
      
  data: () => ({
    valid: true,
    message: '',
    nameRules: [
      v => !!v || 'Message is required'
    ],
    
    type: "INFO",
    types: [
      'INFO',
      'TEST'
    ],
    checkbox: false
  }),

  methods: {
    submit () {
      if (this.$refs.form.validate()) {

         var data={message: this.message,
               type: this.type,
               checkbox: this.checkbox};
         HTTP.post("log/add",Qs.stringify(data))
      .then(r=>{
        console.log("submit: ",data);
        if(this.checkbox){
          this.clear()
        }else{
          router.push({ name: 'logs'});
        }
      })
    }
    },
    clear () {
      this.$refs.form.reset()
    }
  },
 mounted:function(){
    console.log("logadd",this.$route.path)
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/adminlog/logs.vue
const Log=Vue.extend({template:` 
 <v-container fluid>
  <v-card>
   <v-toolbar>
    <v-toolbar-title>Logs
    </v-toolbar-title>
    <v-spacer></v-spacer>
      <v-text-field prepend-icon="filter_list" label="Filter logs" single-line hide-details clearable v-model="search"></v-text-field>
     
        <v-btn icon :color="autorefresh?'green':''" :loading="loading" :disabled="loading" @click="getItems" @dblclick="toggle">
    <v-icon>refresh</v-icon>
    </v-btn>
    
      <v-btn to="add" append small absolute bottom right fab>
              <v-icon>add</v-icon>
       </v-btn>
     <v-spacer></v-spacer>
      <v-menu bottom left min-width="300px">
      
       <template v-slot:activator="{ on }">
            <v-btn icon v-on="on">
              <v-icon>settings</v-icon>
            </v-btn>
         </template>
         
         <v-list subheader>
          <v-subheader>Settings</v-subheader>
              
              <v-list-item>
                <v-list-item-title><v-switch label="Auto Refresh" v-model="autorefresh"></v-switch></v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
    </v-toolbar>
  <v-data-table :headers="headers" :items="items" :search="search" class="elevation-1" no-data-text="No logs found" v-bind:options.sync="pagination">
    <template slot="items" slot-scope="props">
      <td :title="props.item.time">{{ props.item.time  }}</td>
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
      timer:null,
      autorefresh: true
      }
  },
  methods:{
    address(text){
      return "%" + text;
    },
    getItems(){
      this.loading=true
      HTTP.get("basex.log",{params:this.q})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.items=r.data.items
        if(this.autorefresh){
          this.timer=setTimeout(()=>{ this.getItems() }, 5000);
        }
        }) 
    },
    toggle(){
      alert("toggle auto");
      this.autorefresh= !this.autorefresh;
    }
  },
  created:function(){
    this.getItems()
  },
  beforeRouteLeave(to, from, next){
    this.autorefresh=false;
    if(this.timer) clearTimeout(this.timer);
    return next()
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/collection/documentation.vue
const Documentation=Vue.extend({template:` 
 <v-container fluid grid-list-md>
    <v-data-iterator :items="items" :items-per-page.sync="itemsPerPage" :search="search" hide-default-footer>

   <template v-slot:header>
        <v-toolbar>
       <v-toolbar-title>XQDocs</v-toolbar-title>
        <v-spacer></v-spacer>
          <v-text-field v-model="search" clearable flat solo-inverted hide-details prepend-inner-icon="search" label="Search"></v-text-field>
           <v-spacer></v-spacer>
           <router-link :to="{path:'/tasks/xqdoca'}">
              <v-icon>add_circle</v-icon>
           </router-link>
           <v-btn @click="get" icon :loading="loading" :disabled="loading"><v-icon>refresh</v-icon></v-btn>
          </v-toolbar>
      </template>
          
      <template v-slot:default="props">
        <v-layout wrap>
          <v-flex v-for="item in props.items" :key="item.name" xs12 sm6 md4 lg3>
            <v-card :hover="true">
		           <v-toolbar color="blue lighten-3" dense>
			           <v-card-title>{{ item.name }}</v-card-title>
			           <v-spacer></v-spacer>
			           <a :href="item.href" target="_new">go</a>
		           </v-toolbar>
		           <v-card-text>{{ item.id }}</v-card-text>
		            <v-card-text>
		              <span :title="item.created">{{ item.created | fromNow }}</span>
		              
		            </v-card-text>
		           <v-card-actions>
		           <v-btn>Run</v-btn>
		           </v-card-actions>
           </v-card>
            
          </v-flex>
        </v-layout>
      </template>

    </v-data-iterator>
  </v-container>
 `,
      
  data:  function(){
    return {
      itemsPerPage: 100,
      page: 1,
      items:[],
      search: '',
      filter: {},
      loading: false
      }
  },
  methods:{
    get() {
      this.loading=true;
      HTTP.get('xqdocjob')
      .then((res) => {
        this.items = res.data;
        this.loading=false;
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/collection/files.vue
const Files=Vue.extend({template:` 
 <v-container fluid>
 
<v-card>

<v-toolbar dense>
    
    <v-toolbar-title>
		    <v-breadcrumbs :items="crumbs">
		        <span slot="divider" style="padding:0;"></span>
		         <template slot="item" slot-scope="props">
						    <v-breadcrumbs-item :to="{ query: { url:  props.item.path }}" :exact="true">
						    <v-icon v-if="props.item.icon">{{ props.item.icon }}</v-icon>
						    {{ props.item.name }}
						    </v-breadcrumbs-item>
				    </template>
		    </v-breadcrumbs>
    </v-toolbar-title>
     <v-btn icon @click="load()">
    <v-icon>refresh</v-icon>
    </v-btn> 
   <v-btn v-if="clipboard" @click="clipboard=null" icon><v-icon>content_paste</v-icon></v-btn>
    <v-spacer></v-spacer>
     <v-btn v-if="selection.length" @click="selectNone">S: {{selection.length}}</v-btn>
     
 <v-text-field v-if="!selection.length" prepend-icon="filter_list" label="Filter..." v-model="q" type="search" hide-details single-line @keyup.enter="setfilter" :append-icon="this.q?'clear':''" @click:append="e=>this.q=''"></v-text-field>
   
 
    <v-toolbar-items v-if="!selection.length">
    
   <v-btn icon v-for="b in buttons" :key="b.icon" @click="action(b)">
      <v-avatar>
        <v-icon v-text="b.icon"></v-icon>
       </v-avatar>
    </v-btn>
</v-toolbar-items>


  
    <v-toolbar-items v-if="selection.length">
		   <v-btn icon v-for="b in selopts" :key="b.icon" @click="action(b)">
		        <v-icon v-text="b.icon"></v-icon>
		    </v-btn>
   </v-toolbar-items>
 
    
 <v-menu offset-y v-if="selection.length">
   <template v-slot:activator="{ on }"> 
      <v-btn icon v-on="on">
      <v-icon>more_vert</v-icon>
     </v-btn>
    </template>
      
      <v-list>
        <v-list-item @click="invoke">
          <v-list-item-title>Invoke</v-list-item-title>
        </v-list-item>
        <v-divider></v-divider>
        <v-list-item @click="invoke">
          <v-list-item-title>todo</v-list-item-title>
        </v-list-item>
         <v-list-item @click="invoke">
          <v-list-item-title>todo</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
 
  
 </v-toolbar>
  
  <v-layout v-if="!busy">
	  <v-flex>
	  <v-list two-line subheader>
	    <v-subheader inset>
	         <span>Folders ({{ xfolders.length }})</span> 
	     </v-subheader>
	      <v-list-item v-for="item in xfolders" v-bind:key="item.name" v-model="item.selected" @click="folder(item)">
	        <v-list-item-avatar @click.prevent.stop="item.selected =! item.selected ">
	          <v-icon v-bind:class="[itemClass(item)]">{{ itemIcon(item) }}</v-icon>
	        </v-list-item-avatar>
	        <v-list-item-content>
	          <v-list-item-title>{{ item.name }}</v-list-item-title>
	          <v-list-item-subtitle>modified: {{ item.modified | formatDate}}
	                                 size: {{ item.size | readablizeBytes}}
	                                  mimetype: {{ item.mime}}
	                                 </v-list-item-subtitle>
	        </v-list-item-content>
	        <v-list-item-action>
	          <v-btn icon @click.stop="info(item)">
	            <v-icon class="grey--text text--lighten-1">info</v-icon>
	          </v-btn>
	        </v-list-item-action>
	      </v-list-item>
	    
	    <v-divider inset></v-divider>
	    <v-subheader inset>
	       <span>Files ({{ xfiles.length }})</span> 
	        </v-subheader> 
	      <v-list-item v-for="item in xfiles" v-bind:key="item.name">
	        <v-list-item-avatar avatar @click.prevent.stop="item.selected =! item.selected ">
	          <v-icon v-bind:class="[itemClass(item)]">{{ itemIcon(item) }}</v-icon>
	        </v-list-item-avatar>
	        <v-list-item-content @click="file(item.name)">
	          <v-list-item-title>{{ item.name }}</v-list-item-title>
	           <v-list-item-subtitle>modified:  {{item.modified | formatDate}},
												            size:  {{item.size|readablizeBytes }},
												            mimetype: {{ item.mime}}
	            </v-list-item-subtitle>
	        </v-list-item-content>
	        <v-list-item-action>
	          <v-btn icon ripple @click.stop="info(item)">
	            <v-icon class="grey--text text--lighten-1">info</v-icon>
	          </v-btn>
	        </v-list-item-action>
	      </v-list-item>
	  </v-list>
	  </v-flex>
	
  </v-layout>
  
  
   
</v-card>
<v-progress-linear v-if="busy" v-bind:indeterminate="true" height="2"></v-progress-linear>
<!--
 <v-navigation-drawer left app v-model="showInfo" :disable-route-watcher="true">
   <v-card flat tile> 
       <v-toolbar >
      <v-card-title >{{ selection[0] && selection[0].name }}</v-card-title>
      <v-spacer></v-spacer>    
       <v-btn  icon text @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-toolbar>
    <v-card-text> Things to do with  </v-card-text>
    <v-card-actions> 
           <v-btn text @click="invoke()"><v-icon>run</v-icon>run</v-btn>
           </v-card-actions>
    </v-card>
   </v-navigation-drawer>
   -->   
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
        return this.items.filter(item=>{return item.type!="folder" &&((!this.q) || item.name.toLowerCase().includes(this.q.toLowerCase()))})
      },
   xfolders(){
        return this.items.filter(item=>{return item.type=="folder" &&((!this.q) || item.name.toLowerCase().includes(this.q.toLowerCase()))})
      },   
   // array of {name:"that", path:"/this/that/"} for url
   crumbs(){
     var url=this.url.split("/").slice(0,-1).map(
         function(v,i,a){return {name: v +"/",  
                                 path: a.slice(0,i+1).join("/")+"/"}}
         );
       url[0].icon=this.icon;
       return url;  
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/components/markdown.vue
const Markdown=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
	 <v-card-title>Markdown</v-card-title>
	<v-btn-toggle v-model="toc">
          <v-btn>
            TOC
          </v-btn>
      </v-btn-toggle>
	   <v-checkbox v-model="toc" label="toc"></v-checkbox>
	 <v-spacer></v-spacer>
	    <qd-link href="https://github.com/miaolz123/vue-markdown">vue-markdown@2.2.4</qd-link>
	      <v-menu :close-on-content-click="false" offset-y left>
               <template v-slot:activator="{ on }">
                  <v-btn icon v-on="on"><v-icon>settings</v-icon></v-btn>
               </template>
              <v-card>
                    <v-toolbar class="lime darken-1">
				          <v-card-title>Markdown Settings</v-card-title>
				          </v-toolbar>
				        <v-card-text>
				        <ul>
					 <li><v-checkbox v-model="html" label="html"></v-checkbox></li>
					 <li><v-checkbox v-model="breaks" label="breaks"></v-checkbox></li>
					  <li><v-checkbox v-model="linkify" label="linkify"></v-checkbox></li>
					  <li><v-checkbox v-model="emoji" label="emoji"></v-checkbox></li>
					  <li> <v-checkbox v-model="typographer" label="typographer"></v-checkbox></li>
					   </ul>
				        </v-card-text>
	        </v-card>
	      </v-menu>
	 </v-toolbar>
	 <v-card-text>
	  <v-row no-gutters style="flex-wrap: nowrap;">
      <v-col v-if="toc" cols="3" class="flex-grow-0 flex-shrink-0">
        <v-card class="pa-2" outlined tile>
          <div v-html="tochtml"></div>
        </v-card>
      </v-col>
       <v-col cols="1" style="min-width: 100px; max-width: 100%;" class="flex-grow-1 flex-shrink-0" color="orange lighten-2">
       <vue-markdown :watches="['show','html','breaks','linkify','emoji','typographer','toc']" :source="source" :show="show" :html="html" :breaks="breaks" :linkify="linkify" :emoji="emoji" :typographer="typographer" :toc="toc" v-on:rendered="allRight" v-on:toc-rendered="tocAllRight" toc-id="toc"> 
 </vue-markdown>
       </v-col>
      </v-row>
           

	 </v-card-text>
 </v-card>
  
 </v-container>
 `,
      
	data(){
	    return { 
	        source: "",
	        show: true,
	        html: false,
	        breaks: true,
	        linkify: false,
	        emoji: true,
	        typographer: true,
	        toc: false,
	        tochtml: null
	      }
	    },
	      methods: {
	          allRight: function (htmlStr) {
	            console.log("markdown is parsed !");
	          },
	          tocAllRight: function (tocHtmlStr) {
	        	  this.tochtml=tocHtmlStr
	            console.log("toc is parsed :");
	          }
	        },    
	created:function(){	

		    HTTP.get("components/markdown")
		    .then(r=>{      
		          //console.log("data::::",r.data);
		          this.source=r.data;
		          })
		    .catch(err=> {
		            console.log(err);
		            alert("Get query error")
		          });
		    
		    console.log("loaded markdown:");
		    } 
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/components/svg.vue
const Svg=Vue.extend({template:` 
 <v-container fluid>
<div id="canvasqPWKOg" class="canvas"></div>
<button id="resetButtonqPWKOg">Reset</button>
<div>
    <svg width="500" height="300"></svg>
    <br>
    <input type="range" v-model="circleSize" min="1" max="100" step="1">
</div>
 </v-container>
 `,
      
  data:  function(){
    return {
      message: 'bad route!',
      circleSize: 50
      }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  },
  mounted: function(createElement) {
    var svg = d3.select(this.$el).select('svg');
    this.circle = svg
      .append('circle')
      .attr('cx', '250')
      .attr('cy', '150')
      .attr('r', this.circleSize)
  },
  watch: {
    circleSize: function(newValue) {
      this.circle
        .attr('r', newValue)
    }
  }

}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/components/svg2.vue
const Svg2=Vue.extend({template:` 
<div ref="panel" v-resize="onResize">
  <v-toolbar dense>
	  <v-btn @click="view.reset()">Reset</v-btn>
	   <v-btn @click="size()">Size</v-btn>
	     <v-select v-model="url" combobox clearable open-on-clear :items="svgs"></v-select>
	   
	    <v-btn @click="load()">set</v-btn>
	</v-toolbar>
	
	 <div ref="svgcanvas" style="width:100%;height:100%;background-color:yellow;"></div>
</div>
 `,
      
  data: function() {
    return {
      canvasd3:null,
      view:null,
      url:"/vue-poc/ui/resources/svg/butterfly.svg",
      svgs:["/vue-poc/ui/resources/svg/butterfly.svg",
            "/vue-poc/ui/resources/svg/tiger.svg"]
    };
  },
  methods:{
    size(){
      this.view.width(200).height(200).render();
    },
    
    load(){
      var that=this;
      d3.xml(this.url,
          function(error, xml) {
        if (error) {
          //alert("load err");
          throw error;
        }
        var d=d3.select(xml.documentElement)
        that.view.setItem(d);
    });
    },
    
    onResize(){
      var el=this.$refs["panel"];
       
      //console.log("top",e.offsetTop)
      var h=Math.max(1,window.innerHeight - el.offsetTop -10);
      var w=Math.max(1,window.innerWidth- el.offsetLeft ) 
      console.log("resize:",w,h)
      el.style.height=h +"px";
      if(this.view ){
        this.view.height(h-20);
       this.view.render();
      }
    }

  },
  
  watch:{
    url(v){
      this.$router.push({  query: { url: this.url }})
      },
      $route(vnew,vold){
        //console.log("ROUTE",vnew,vold)    
        var url=this.$route.query.url
        this.url=url?url:"/vue-poc/ui/resources/svg/butterfly.svg";
        if(vnew.query.url != vold.query.url) this.load() 
      }
  },
  
  mounted: function() {
    var url=this.$route.query.url
    this.url=url?url:"/vue-poc/ui/resources/svg/butterfly.svg";
    this.canvasd3 = d3.select(this.$refs.svgcanvas);
    /** RUN SCRIPT **/
    var canvasWidth = 800;

    var canvas = d3.demo.canvas().width(canvasWidth).height(400);
    this.view=canvas;
    this.canvasd3.call(canvas);
    
    this.load();
   

  }

}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/components/timeline.vue
const Timeline=Vue.extend({template:` 
 <v-container fluid>
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/components/tree.vue
const Tree=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
   <v-toolbar card color="grey lighten-3"> 
		   <v-card-title>Taxonomy test</v-card-title>
		   <v-spacer></v-spacer>
		   <v-btn>todo</v-btn>
   </v-toolbar>

     <v-card-text>
       <v-layout>
      
       <v-flex xs6>
       <v-sheet class="pa-3 primary lighten-2">
      <v-text-field v-model="search" label="Filter tag" flat solo-inverted hide-details clearable></v-text-field>
      <v-checkbox v-model="caseSensitive" dark hide-details label="Case sensitive search"></v-checkbox>
    </v-sheet>
        <v-treeview :items="items" item-text="label" v-model="tree" :search="search" :open.sync="open" activatable active-class="grey lighten-4 indigo--text" selected-color="indigo" open-on-click selectable>
           <template slot="prepend" slot-scope="{ item, open }">
				      <v-icon v-if="item.children">
				        {{ open ? 'folder_open' : 'folder' }}
				      </v-icon>
				      <v-icon v-else>
				        {{ 'label' }}
				      </v-icon>
				    </template>
         </v-treeview>
        </v-flex>
        <v-divider vertical></v-divider>
        <v-flex xs6>
          <div v-if="tree.length === 0" key="title" class="title font-weight-light grey--text pa-3 text-xs-center">
            Select some tags
          </div>

          <v-scroll-x-transition group hide-on-leave>
            <v-chip v-for="leaf, i) in tree" :key="i" color="grey" dark small>
              <v-icon left small>label</v-icon>
              {{ leaf }}
            </v-chip>
          </v-scroll-x-transition>
        </v-flex>
       </v-layout>
   </v-card-text>
   

 </v-card>
 </v-container>
 `,
      
  data:function(){
    return {
		  data: [],
		  items: [],
		  tree: [],
	    search: null,
	    open: [1, 2],
	    caseSensitive: false
	  }
  },
  
methods: {

},

computed:{

},

created:function(){
  HTTP.get("components/tree")
  .then(r=>{
    console.log("loaded tree:",r);
    this.items= r.data;
    })
}

}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/components/tree2.vue
const Tree2=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
   <v-card-title><qd-link href="https://github.com/riophae/vue-treeselect">vue-treeselect@0.0.29</qd-link> </v-card-title>
   <v-spacer></v-spacer>
   <v-btn>todo</v-btn>
   </v-toolbar>
   <v-card-text>
     <v-layout row wrap>
     <v-flex xs4>
     Select some things:
     </v-flex>
      <v-flex xs4>
		    <treeselect v-model="value" :multiple="true" :options="source">
    </treeselect></v-flex>
    
    <v-flex xs4>
       <pre>{{ value }}</pre>
    </v-flex>
   </v-layout>
   </v-card-text>

 </v-card>
 </v-container>
 `,
      
  //components: { Treeselect },
  
  data:function(){
    return {
      value: [
        "DITA",
        "CSS",
        "Linking",
        "Hardware-basedProcessing"
      ],
      source: []
    }
  },
methods: {
  itemClick (node) {
    console.log(node.model.text + ' clicked !')
  },
  load(){
    HTTP.get("components/tree")
    .then(r=>{
      console.log(r);
      this.source=r.data
      })
      .catch(error=> {
        console.log(error);
       
        alert("Get query error"+url)
      });
    
  },
},
created:function(){
  this.load()
}

}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/edit/edit.vue
const Edit=Vue.extend({template:` 
<v-container>
      <v-snackbar top color="error" v-model="snackbar">
      {{ message }}
      <v-btn text @click="snackbar = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-snackbar>
    
<v-card>
<v-toolbar dense>
<v-tooltip top>
 <template v-slot:activator="{ on }">
  <v-menu v-on="on">
  <template v-slot:activator="{ on }">
      <v-btn color="primary" icon v-on="on"><v-icon>{{icon}}</v-icon></v-btn>
  </template>
  <v-list>
      <v-list-item v-for="(item,index) in path" :key="index">
        <v-list-item-content @click="showfiles()">
        <v-list-item-title>{{ item }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
  </v-list>
  </v-menu>
  </template>
<span>{{ path.join('/') }}</span>
</v-tooltip>
  
   <v-badge right v-model="dirty">
     <span slot="badge">*</span>
     <v-toolbar-title>{{ name }}</v-toolbar-title>
     </v-badge>
     <v-btn v-if="dirty" icon @click="save()">
      <v-icon>file_upload</v-icon>
    </v-btn>
    <v-spacer></v-spacer>

  <v-menu left transition="v-fade-transition">
	   <template v-slot:activator="{ on }">
	      <v-chip label small v-on="on">{{ mode }}</v-chip>  
	    </template>
          <v-list dense>
              <v-list-item v-for="type in $MimeTypes.list()" :key="type.name">
                <v-list-item-title v-text="type.name" @click="setMode(type)"></v-list-item-title>
              </v-list-item>           
          </v-list>         
   </v-menu>
   
  <v-tooltip top>
   <template v-slot:activator="{ on }">
     <v-chip @click="acecmd('goToNextError')" v-on="on">
            <span class="red ">{{annotations &amp;&amp; annotations.error}}</span>
            <span class="yellow ">{{annotations &amp;&amp; annotations.warning}}</span>   
            <span class="green ">{{annotations &amp;&amp; annotations.info}}</span>
 
           <v-avatar>
              <v-icon black>navigate_next</v-icon>
           </v-avatar>
      </v-chip>
      </template>
      <span>Annotations: Errors,Warning and Info</span>
   </v-tooltip>
<v-spacer></v-spacer>
   <v-btn icon @click="acecmd('outline')" title="outline -todo">
      <v-icon>label_outline</v-icon>
    </v-btn>

  <v-menu left transition="v-fade-transition">
    <template v-slot:activator="{ on }">
      <v-btn icon v-on="on" title="display settings">
        <v-icon>playlist_play</v-icon>
      </v-btn>
     </template>
      <v-list dense>
           <v-subheader>Display settings</v-subheader>
         
           <v-list-item @click="togglefold">
             <v-list-item-avatar>
                   <v-icon>vertical_align_center</v-icon>
              </v-list-item-avatar>
              <v-list-item-title>Toggle folds</v-list-item-title>
           </v-list-item>
           
           <v-list-item @click="wrap=!wrap">
             <v-list-item-avatar>
                   <v-icon>wrap_text</v-icon>
              </v-list-item-avatar>
              <v-list-item-title>Soft wrap</v-list-item-title>
           </v-list-item>
             <v-divider></v-divider>
              <v-subheader>Help</v-subheader>
             <v-list-item @click="acecmd('showSettingsMenu')">
               <v-list-item-avatar>
              <v-icon>settings</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showSettingsMenu')">Show ACE settings</v-list-item-title>
            </v-list-item>
                      
            <v-list-item @click="acecmd('showKeyboardShortcuts')">
              <v-list-item-avatar>
              <v-icon>keyboard</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showKeyboardShortcuts')">Show ACE keyboard shortcuts</v-list-item-title>
            </v-list-item>          
      </v-list>
    </v-menu>
    
    <v-btn icon @click="beautify()">
      <v-icon>format_align_center</v-icon>
    </v-btn>
    <v-btn icon @click="clearDialog = true">
      <v-icon>delete</v-icon>
    </v-btn>
      
    <v-menu left transition="v-fade-transition">
      <template v-slot:activator="{ on }">
      <v-btn icon v-on="on">
        <v-icon>more_vert</v-icon>
      </v-btn>
     </template>
          <v-list dense>
               <v-list-item @click="acecmd('showSettingsMenu')">
               <v-list-item-avatar>
              <v-icon>settings</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showSettingsMenu')">Show ACE settings</v-list-item-title>
            </v-list-item>
                      
            <v-list-item @click="acecmd('showKeyboardShortcuts')">
              <v-list-item-avatar>
              <v-icon>keyboard</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showKeyboardShortcuts')">Show ACE keyboard shortcuts</v-list-item-title>
            </v-list-item>          
          </v-list>
          
      </v-menu>
    
     
 </v-toolbar>
   <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>

<v-card-text v-if="!busy">
<v-flex xs12 style="height:70vh" fill-height>
  
    <vue-ace :content="contentA" :mode="mode" :wrap="wrap" :settings="aceSettings" :events="events" v-resize="onResize" :completer="$aceExtras.basexCompleter" :snippets="$aceExtras.snippets" v-on:change-content="changeContentA" v-on:annotation="annotation"></vue-ace>
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
    setMode(type){
      this.mimetype=type.name
      var r=type.mode
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

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/edit/tabs.vue
const Tabs=Vue.extend({template:` 
<div> 
  <v-toolbar tabs dense>
     <v-toolbar-items>
	      <vp-selectpath :frmfav.sync="showadd" @selectpath="add"> <v-icon>add_circle</v-icon></vp-selectpath>
	      <v-btn icon @click="openUri"><v-icon>insert_drive_file</v-icon></v-btn>
      </v-toolbar-items>
      <v-toolbar-title>i={{ curIndex   }} </v-toolbar-title>
      
       <v-menu v-if="active" left transition="v-fade-transition">
        <template v-slot:activator="{ on }">
       <v-chip label small v-on="on">{{ active.mode }}</v-chip>
       </template>
          <v-list dense>
                <v-list-item v-for="type in $MimeTypes.list()" :key="type.name">
                <v-list-item-title v-text="type.name" @click="setMode(type)"></v-list-item-title>
              </v-list-item>         
          </v-list>         
      </v-menu>
      
       <v-menu v-if="active" left transition="v-fade-transition">
         <template v-slot:activator="{ on }">
        <v-btn v-on="on">Action<v-icon>arrow_drop_down</v-icon></v-btn>
        </template>
          <v-list dense>
          <v-subheader>Actions</v-subheader>
                <v-list-item @click="format()">
                <v-list-item-title>Format</v-list-item-title>
              </v-list-item>
               <v-list-item @click="validate()">
                <v-list-item-title>Validate</v-list-item-title>
              </v-list-item>             
          </v-list>         
      </v-menu>
      <v-btn @click="add">*{{  EditTabs.nextId }}</v-btn>
     
       <v-spacer></v-spacer>
       
         <v-tooltip top>
               <template v-slot:activator="{ on }">
			     <v-chip @click="acecmd('goToNextError')" v-on="on">
			            <span class="red ">{{annotations &amp;&amp; annotations.error}}</span>
			            <span class="yellow ">{{annotations &amp;&amp; annotations.warning}}</span>   
			            <span class="green ">{{annotations &amp;&amp; annotations.info}}</span>
			 
			           <v-avatar>
			              <v-icon black>navigate_next</v-icon>
			           </v-avatar>
			      </v-chip>
			        </template>
			      <span>Annotations: Errors,Warning and Info</span>
			   </v-tooltip>
			   
        <qd-mimelist v-if="active" :mimetype="active.contentType" @selected="setmime">{{ active.mode }}</qd-mimelist>
        
        <v-menu left transition="v-fade-transition">
        <template v-slot:activator="{ on }">
		      <v-btn :disabled="!active" icon v-on="on" title="display settings">
		        <v-icon>playlist_play</v-icon>
		      </v-btn>
      </template>
      <v-list dense>
           <v-subheader>Display settings</v-subheader>
         
           <v-list-item @click="togglefold">
             <v-list-item-avatar>
                   <v-icon>vertical_align_center</v-icon>
              </v-list-item-avatar>
              <v-list-item-title>Toggle folds</v-list-item-title>
           </v-list-item>
           
           <v-list-item @click="wrap=!wrap">
             <v-list-item-avatar>
                   <v-icon>wrap_text</v-icon>
              </v-list-item-avatar>
              <v-list-item-title>Soft wrap</v-list-item-title>
           </v-list-item>
             <v-divider></v-divider>
              <v-subheader>Help</v-subheader>
             <v-list-item @click="acecmd('showSettingsMenu')">
               <v-list-item-avatar>
              <v-icon>settings</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showSettingsMenu')">Show ACE settings</v-list-item-title>
            </v-list-item>
                      
            <v-list-item @click="acecmd('showKeyboardShortcuts')">
              <v-list-item-avatar>
              <v-icon>keyboard</v-icon>
            </v-list-item-avatar>
              <v-list-item-title @click="acecmd('showKeyboardShortcuts')">Show ACE keyboard shortcuts</v-list-item-title>
            </v-list-item>          
      </v-list>
    </v-menu>
    
    <v-menu>
         <template v-slot:activator="{ on }">
            <v-btn icon v-on="on"><v-icon>view_quilt</v-icon></v-btn>
          </template>
          <v-list dense>
          <v-subheader>View</v-subheader>
           <v-list-item @click="showInfo = false">
		           <v-list-item-action>
		              <v-icon>mode_edit</v-icon>
		            </v-list-item-action>
                 <v-list-item-content>
                <v-list-item-title>Source</v-list-item-title>
                </v-list-item-content>
           </v-list-item>
             
           <v-list-item @click="showInfo = true">
              <v-list-item-action>
                  <v-icon>info</v-icon>
                </v-list-item-action>
                 <v-list-item-content>
                <v-list-item-title>Info</v-list-item-title>
              </v-list-item-content></v-list-item>             
          </v-list>         
    </v-menu>
    <v-layout slot="extension">
   
     <v-flex xs11>   
        <v-tabs v-model="curIndex" slot="extension">
		      <v-tab v-for="item in EditTabs.items" :key="item.id" ripple :title="item.uri" style="text-transform: none;text-align:left">
			       <v-avatar>
			          <v-icon :title="item.mode">{{ $MimeTypes.icon(item.mode) }}</v-icon> 
			       </v-avatar>
			        <span>{{ (item.dirty?"*":"") }}</span>
			        <span>{{ item.name  }}</span>
			       <v-spacer></v-spacer>
			       <v-btn icon @click.stop="tabClose(item)">
			          <v-icon size="16px">close</v-icon>
			        </v-btn>
		      </v-tab>
     </v-tabs>
     </v-flex>
      <v-flex xs1>
       <qd-tablist v-if="EditTabs" :edittabs="EditTabs" :current="curIndex" @selected="setItem">tab list</qd-tablist>
     </v-flex>
     </v-layout>
  </v-toolbar>
  
   
  <v-tabs-items v-model="curIndex">
     <v-tab-item v-for="item in EditTabs.items" :key="item.id">
	    <v-card>
        <div style="height:200px" ref="ace" v-resize="onResize">
        <v-flex xs12 fill-height>
			    <vue-ace :content="item.text" v-on:change-content="changeContent" :events="events" :mode="item.mode" :wrap="wrap" :settings="aceSettings" v-on:annotation="annotation"></vue-ace>
			  </v-flex>
        </div> 
      </v-card>
    </v-tab-item>
 </v-tabs-items>
 
</div>
 `,
      
    data () {
      return {
        showadd: false,  // showing add form
        showInfo: false, // showing info
        a1:"",
        curIndex: null, //index of current
        active: null,
        items: [],
      wrap: true,
      aceSettings: {},
      events:  new Vue({}),
      annotations: null,
      folded:false,
      EditTabs: EditTabs
      }
  },
  
  methods:{
    add(){
      var tab={name:"@" + this.active.name, 
               text:"active: "+ JSON.stringify(this.active, null, 2) 
      }
      this.curIndex=this.EditTabs.addItem(tab, this.curIndex+1)
    },
  
    tabClose(item,index){
      if(item.dirty){
        if (!confirm("Not saved continue? "+ index))return;
      }else{
        this.EditTabs.closeItem(item)
        this.curIndex=0
      }
    },
    setItem(v){
      this.curIndex=v;
    },
    setmime(mime){
      this.$set(this.active, 'contentType', mime.contentType)
      this.$set(this.active, 'mode', mime.mode)
      //alert(mime.contentType+" "+mime.mode)
    },
    
    
    openUri(){
      alert("openUri TODO")
    },
    
    setMode(type){
      this.active.mode=type.mode
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
    
    format(d){
      var d=this.active.mode;
      var f=this.$MimeTypes.mode[d];
      var f=f && f.format;
      if(f){
        this.active.text=f(this.active.text);
      }
    },
    
    annotation(counts){
      this.annotations=counts
      //console.log("annotations: ",counts)
    },
    
    validate(){
        var d=this.active.mode;
        var f=this.$MimeTypes.mode[d];
        var f=f && f.validate;
        var t={name:"validate", text:"validate: todo\n "+ this.curIndex +"\n" + new Date()};
        this.curIndex=this.EditTabs.addItem(t)
    },
    
   
    
    
    changeContent(val){
      var item=this.active;
      //console.log("change",val);
 
      if (item.text !== val) {
        item.text = val;
        item.dirty=true;
      }
    },
    
    onResize(){
      var el=this.$refs["ace"];
      for (e of el){
      //console.log("top",e.offsetTop)
      var h=Math.max(1,window.innerHeight - e.offsetTop -200) 
      // console.log("h",h)
      e.style.height=h +"px";
    }
    }
  },
  
  watch:{
    curIndex (val) {
      this.active = EditTabs.items[val];
      console.log("curIndex: ",val)
      if(this.active) this.$router.push({  query: { id: this.active.id }});
    }
  },
  
  computed:{
    
    dirty(){
        return this.active && this.active.dirty
      }
  },
  
  beforeRouteEnter (to, from, next) {
    Promise.all([Settings.getItem('settings/ace')
                 ])
    .then(function(values) {
      next(vm => {
          vm.aceSettings = values[0];
          })
          })
    },
     
  beforeRouteLeave (to, from, next) {
    // called when the route that renders this component is about to
    // be navigated away from.
    // has access to `this` component instance.
    Settings.setItem('edit/items',EditTabs.items);
    next(true);
  },

  created:function(){
    var url=this.$route.query.url;
    if(url){
      EditTabs.loadItem(url);
    }else{
    var tid=this.$route.query.id;
    var id=EditTabs.items.findIndex(i=>i.id ==tid)
    console.log("set tab",tid,id)
    EditTabs.restored.then(()=>{
      var id=EditTabs.items.findIndex(i=>i.id ==tid)
      console.log("set tab",tid,id)
      this.curIndex= id;
    });
    }
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/eval/eval.vue
const Eval=Vue.extend({template:` 
 <v-container fluid>
  <v-card @keyup.ctrl.enter="submit">
     <v-toolbar dense> 
     <v-menu offset-x> 
     <template v-slot:activator="{ on }"> 
	<v-btn v-on="on" text icon color="pink"> 
	<v-icon>label_outline</v-icon> 
	</v-btn> 
	</template> 
  <v-card>
<v-card-title>Outline here</v-card-title> </v-card> </v-menu>
    
      <v-menu offset-x>
       <template v-slot:activator="{ on }">
           <v-btn v-on="on" text icon color="pink">
              <v-icon>add_circle</v-icon>
            </v-btn>
        </template>    
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
    <v-menu offset-y left>
      <template v-slot:activator="{ on }">
           <v-btn v-on="on" text icon>
              <v-icon>more_vert</v-icon>
            </v-btn>
      </template>    
    
      <v-list dense>
         <v-subheader>More actions...</v-subheader>
        <v-divider></v-divider>
        
        <v-list-item @click="run">
          <v-list-item-title>xquery:eval</v-list-item-title>
        </v-list-item>
        
         <v-list-item @click="plan">
          <v-list-item-title>Show query plan</v-list-item-title>
        </v-list-item>
        
        <v-list-item @click="hitme">
         <v-list-item-title>Test large result.</v-list-item-title>
         </v-list-item>
     </v-list>
    </v-menu>
   
   
    
   </v-toolbar>
 
  <v-flex xs12 style="height:200px" fill-height>
  <vue-ace :content="xq" mode="xquery" wrap="true" :settings="aceSettings" v-on:change-content="onChange"></vue-ace>
    </v-flex>
   
    <vp-job v-if="showJob" :job="job" :waiting="waiting" :job-state="jobState" :elapsed="elapsed"></vp-job>
    <v-card-text v-if="showError">
     <v-alert color="error" v-model="showError">Error </v-alert>
    </v-card-text>
    
     <v-card-text v-if="showResult">
		     <v-flex xs12 style="height:200px" fill-height>
		        <vue-ace :content="result" mode="text" wrap="false" read-only="true" :settings="aceSettings"></vue-ace>
        </v-flex> 
     </v-card-text>
       
      
       
    </v-card>

 </v-container>
 `,
      

  data:  function(){
    return {
      xq: '(: type your XQuery :)\n',
      result: '',
      done: false,
      elapsed: null,
      showJob: false,
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
    // execute imediatly
    run(){
    	  console.log("run:",this.xq);
      this.showResult= true;
      this.start = performance.now();
      HTTPNE.post("eval/execute",Qs.stringify({xq:this.xq}))
      .then(r=>{
        console.log("exec:",r);
        this.elapsed=Math.floor(performance.now() - this.start);
        this.result=r.data.job
        this.jobId=null
      })
      .catch(r=> {
        console.log("error",r)
        this.result=r.response.data
        this.showError=true;

      });
      localforage.setItem('eval/xq', this.xq)
    },
    // request run
    submit(){
      this.showError=this.showResult=this.showJob=false
      this.start = performance.now();
      console.log("*****",Qs.stringify({xq:this.xq}));
      HTTP.post("eval/submit",Qs.stringify({xq:this.xq}))
      .then(r=>{
        this.elapsed=Math.floor(performance.now() - this.start);
        this.job=r.data
        this.showJob=true
        this.pollState()
        
      });
      
    },
    // 
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
         this.done= true;
         console.log("$$$$$",this.result);
       }).catch(r=> {
        // alert("catch")
         console.log("error",r)
         this.result=r.response.data
         this.showError=true;
         this.done= true;
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

      this.showError= false
      this.show= show
      this.result= "(Please wait..)"
      this.showResult= true
    }
  },
  computed: { 
  },
  beforeRouteEnter (to, from, next) {
    Settings.getItem('settings/ace')
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/eval/evalid.vue
const Evalid=Vue.extend({template:` 
 <v-container fluid>
 todo {{id}}
 </v-container>
 `,
      
  props:["id"],
  data:  function(){
    return {
      xq: '(: type your XQuery :)\n'
     
      }
  }
 
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/form/brutusin.vue
const Brutusin=Vue.extend({template:` 
 <v-container fluid>
     <v-card>
     <v-card-title>
	     <v-toolbar-title>Form </v-toolbar-title>
	
	        <v-chip v-if="formValid" color="success">valid</v-chip>
	        <v-chip v-else color="danger">invalid</v-chip>
	        <v-btn color="primary" @click="$refs.myForm.validate()">validate</v-btn>
	      <v-spacer></v-spacer>
	      <qd-link href="https://github.com/koumoul-dev/vuetify-jsonschema-form/">vuetify-jsonschema-form@v1.10.0</qd-link>
     </v-card-title>
     <v-card-actions>
     <v-layout row wrap>
       <v-flex xs2>
      <v-select :items="schemas" v-model="schemaUri" label="Choose an Schema" @change="applyExample">
      </v-select></v-flex>
        <v-flex>
      <v-btn @click="showschema()">show</v-btn>
      </v-flex>
      </v-layout>
      </v-card-actions>
     <v-card-text>
      <v-container grid-list-md>
    <v-layout row wrap>
      <v-flex xs8>
      <v-form ref="myForm" v-model="formValid">
        <v-btn @click="submit" :disabled="!formValid">submit</v-btn>
          <v-jsf v-if="schema" :schema="schema" v-model="model" :options="options" @error="e => window.alert(e)">
       </v-jsf></v-form>
       </v-flex>
       
       <v-flex xs4 class="grey lighten-2">
        <h2 class="title my-4">Data:</h2>
        <pre style="text-align:left">{{ model | pretty }}</pre>
       </v-flex>
       </v-layout>
       </v-container>
       </v-card-text>
    </v-card>
 </v-container>
 `,
      
  components: {
    "v-jsf": VJsf.default
   },
   data() {
     return {
       model: {},
       schema: null,
       schemaUri: "person.json",
       schemas: [
         "person.json",
         "select.json",
         "arrays.json"
       ],
       formValid: false,
       options: {
         debug: true,
         disableAll: false,
         autoFoldObjects: true,
         httpLib: HTTP
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
    },
    applyExample(uri){
      console.log(uri);
      this.model={}
      this.schema=null
      HTTP.get("form/schema",{params: {uri: uri}})
      .then(r=>{
        this.schema=r.data;
      })
    },
    submit(){
      alert("todo")
    },
    showschema(){
      alert("as")
    }
  },
  
  filters: {
    pretty: function(value) {
      return JSON.stringify(value, null, 2);
    }
  },
  created:function(){
    console.log("form")
    HTTP.get("form/schema",{})
    .then(r=>{
      this.schema=r.data;
    })
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/history/filehistory.vue
const Filehistory=Vue.extend({template:` 
 <v-container>
 <v-card>
  <v-card-title>File History</v-card-title>
 <v-card-text>
    <v-list>
            <v-list-item v-for="item in items" v-bind:key="item.title">
              <v-list-item-action>
               <v-chip v-text="item.protocol">Example Chip</v-chip>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title v-text="item.url"></v-list-item-title>
              </v-list-item-content>
              
              <v-list-item-action>
              <v-btn :to="{name:'edit', query:{ url:item.url, protocol:item.protocol}}" icon ripple>
                <v-icon color="grey lighten-1">info</v-icon>
              </v-btn>
              </v-list-item-action>
              <v-list-item-action>
              <v-btn :to="{name:'multi-edit', query:{  url:item.protocol + ':' +item.url }}" icon ripple>
                <v-icon color="grey lighten-1">switch_camera</v-icon>
              </v-btn>
            </v-list-item-action>
            </v-list-item>
   </v-list>
   </v-card-text>
   </v-card>
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
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/home.vue
const Home=Vue.extend({template:` 

<v-card raised> 
<v-card-title>links</v-card-title>
 <v-card-text>
<v-card-text>
<v-list dense>
		<v-list-item @click>
		<router-link :to="{path:'files', query:{url:'/vue-poc/'}}"> <v-icon>developer_mode</v-icon>vue-poc files</router-link>
		</v-list-item>
		<v-list-item @click>
		<router-link :to="{path:'database', query:{url:'/vue-poc/'}}"> <v-icon>folder</v-icon>vue-poc db</router-link>
		</v-list-item>
			<v-list-item @click>
			<a href="/doc/#/data/app/vue-poc" target="new">doc</a>
			</v-list-item>
			<v-list-item @click>
			<a href="/dba" target="new">DBA app</a>
			</v-list-item>
			<v-list-item @click>
			<a href="/vue-poc/ui/database?url=%2Fvue-poc%2F" target="new">db</a>
			</v-list-item>
		<v-list-item @click>
		<router-link :to="{path:'files', query:{url:'/vue-poc/features/images/'}}">vue-poc image tasks</router-link>
		</v-list-item>
</v-list>
 </v-card-text> 
 <v-card-actions>
		<v-btn floating="floating"> <v-icon>add</v-icon> 
		</v-btn> <qd-link href="/dba">REPLACED</qd-link> 
  </v-card-actions>
   
</v-card-text></v-card> 
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
 <v-container fluid>
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
     <v-chip>Images by year and month</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  
    </v-toolbar>
    <v-card-text>
     <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
<v-container v-if="!busy" fluid>
 <v-layout v-for="year in items" :key="year.year">
      <v-flex v-text="year.year"></v-flex> 
      <v-flex v-for="(m,i) in year.months" :key="i"><v-btn icon color="primary" :disabled="0==m" @click="go(year.year,i)">{{m}}</v-btn></v-flex>       
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
 <v-container fluid>
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
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
		 <v-flex xs5>
		<pre style="overflow:auto;">{{ image.doc }}</pre>
		  <a :href="meta" target="_new">full metadata</a>
		 </v-flex>
		 
		 <v-flex xs7>
		 
      <v-img v-if="loaded" src="/vue-poc/api/images/list/17236456/image" min-height="400px" height="100%" width="100%">
		 </v-img></v-flex>
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
    	var a=this.loaded?'/vue-poc/api/images/list/'+ this.id+ '/image':null
    	console.log("path",a)
    return a
    },
    meta(){
      return this.loaded?'/vue-poc/api/images/list/'+ this.id+ '/meta':null
      }
},
  created:function(){
   var id=this.id
   
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
      <v-toolbar dense>
      <v-btn @click.stop="showFilter = true" icon><v-icon>filter_list</v-icon></v-btn>
        <v-toolbar-title>{{ qtext }}</v-toolbar-title>
        <v-tooltip top v-if="query.keyword || query.from || query.until">
         <template v-slot:activator="{ on }">  
		        <v-btn @click="clear" icon v-on="on">
		            <v-icon>clear</v-icon>
		         </v-btn>
         </template>
         <span>Clear search</span>
         </v-tooltip>
           <v-btn icon @click="getImages">
                    <v-avatar>
                      <v-icon>refresh</v-icon>
                     </v-avatar>
                  </v-btn>
           <v-spacer></v-spacer>
           <span v-if="!busy">
              <v-toolbar-items v-if="!selection.length">
							   <v-btn icon v-for="b in buttons" :key="b.icon" @click="action(b)">
							      <v-avatar>
							        <v-icon v-text="b.icon"></v-icon>
							       </v-avatar>
							    </v-btn>
          </v-toolbar-items>
          <v-toolbar-items v-if="selection.length">
                 <v-btn icon v-for="b in selopts" :key="b.icon" @click="action(b)">
                    <v-avatar>
                      <v-icon v-text="b.icon"></v-icon>
                     </v-avatar>
                  </v-btn>
          </v-toolbar-items>
          </span>
           <v-spacer></v-spacer>
           
          <v-toolbar-items>
	          <v-btn @click.stop="pageBack()" :disabled="query.page==0" icon>
	           <v-avatar>
	           <v-icon>arrow_back</v-icon>
	           </v-avatar>
	           </v-btn>
	           
	           <v-btn @click.stop="pageNext()" icon>
	            <v-avatar>
	            <v-icon>arrow_forward</v-icon>
	            </v-avatar>
	           </v-btn>
         </v-toolbar-items>
        
        </v-toolbar>
        <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
        <v-container v-if="!busy" fluid grid-list-md>
          <v-layout row wrap v-touch="{ left: () => pageNext(), right: () => pageBack()}">
            <v-flex xs12 sm6 md4 lg3 xl2 v-for="image in images" :key="image.name">
              <v-card tile :elevation="2" :hover="true" color="grey lighten-3">
                 <v-toolbar height="16px">
                 <v-toolbar-title :title="image.path">{{image.name}}</v-toolbar-title>
                 <span v-if="image.keywords >0 ">#{{image.keywords}}</span>
	                 <v-avatar icon small v-if="image.geo">
	                  <v-icon>place</v-icon>
	                </v-avatar>
                  <v-spacer></v-spacer>
                 <a :href="src(image)" target="thumb" :title="image.id">
	                  <v-avatar icon small>
	                     <v-icon>search</v-icon>
                     </v-avatar>
                 </a>
                	
                </v-toolbar>
             
                <div :style="style(image)" v-bind:class="{ selcard: image.selected}" @dblclick="go(image)" @click.prevent.stop="image.selected =! image.selected ">
                 
                </div>
               
                
                <div v-if="image.selected" style="position:absolute;right:0;top:0">
                 <v-icon class="white primary--text">check_circle</v-icon>
                 </div>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>

 <v-navigation-drawer left fixed v-model="showFilter" :disable-route-watcher="true">
         <v-card>
          <v-toolbar class="green white--text">
                <v-toolbar-title>Show images with...</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn @click="showFilter = false" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          
        <v-card-text>    
         <v-autocomplete v-bind:items="keywords" v-model="query.keyword" label="Keyword" item-value="text" item-text="text" clearable>
             <template slot="item" slot-scope="data">
                  <v-list-item-content>
                    <v-list-item-title v-html="data.item.text"></v-list-item-title>
                    <v-list-item-subtitle v-html="data.item.count"></v-list-item-subtitle>
                  </v-list-item-content>
              </template>
            </v-autocomplete>
            
          <v-menu :close-on-content-click="false" v-model="menu2" transition="scale-transition" offset-y :nudge-left="40" max-width="290px">
         <template v-slot:activator="{ on }">  
             <v-text-field v-on="on" label="Earliest date" v-model="query.from" prepend-icon="event" readonly clearable></v-text-field>
         </template>
          <v-date-picker v-model="query.from" scrollable actions>
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn text color="primary" @click="cancel()">Cancel</v-btn>
                <v-btn text color="primary" @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
            
         
          </v-date-picker></v-menu>
          
           <v-menu :close-on-content-click="false" v-model="showUntil" transition="scale-transition" offset-y :nudge-left="40" max-width="290px">
           
            <template v-slot:activator="{ on }">  
            <v-text-field v-on="on" label="Latest date" v-model="query.until" prepend-icon="event" readonly clearable></v-text-field>
         </template>
          <v-date-picker v-model="query.until" scrollable actions>
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn text color="primary" @click="cancel()">Cancel</v-btn>
                <v-btn text color="primary" @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-date-picker>
          </v-menu>
        
            <v-checkbox :value="location.value" :indeterminate="location.use" @click="cyclelocation" label="With location"></v-checkbox>
        
        </v-card-text>
        
        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn @click="showFilter = false" color="primary">Apply</v-btn>
        </v-card-actions>
      </v-card>
      </v-navigation-drawer>
        <v-navigation-drawer left fixed v-model="showInfo" :disable-route-watcher="true">
               <v-card> 
                 <v-toolbar class="green white--text">
                <v-toolbar-title>{{selection.length}} selected</v-toolbar-title>
                <v-spacer></v-spacer>    
                 <v-btn text icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
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
         return "data:image/jpeg;base64,"+item.data;
        //console.log('/vue-poc/api/images/list/'+ item.id +'/thumb')
        //return '/vue-poc/api/images/list/'+ item.id +'/thumb'
    },
    style(item){
      return "height:100px; background:url('"+this.src(item)+"'); background-repeat: no-repeat;background-position: center;background-size: contain;";
    },
    cyclelocation(){
      this.location.use=!this.location.use
    },
    getImages(){
      this.busy=true
      console.log("Images",this.query);
      var t0 = performance.now();
      HTTP.get("images/list",{params:this.query})
      .then(r=>{
        this.busy=false
        this.total=r.data.total
        this.images=r.data.items
        console.log("III",this.images);
        var t1 = performance.now();
        var elapsed= 0.001 *(t1 - t0);
        var round = Vue.filter('round');
        this.$notification.add({html:"Found " + this.total, elapsed: round(elapsed,1)});
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
      this.query.page=Math.max(0,this.query.page-1)
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/imagesfilter.vue
const Imagesfilter=Vue.extend({template:` 
         <v-card>
          <v-toolbar class="green white--text">
                <v-toolbar-title>Show images with...</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn @click="showFilter = false" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          
        <v-card-text>    
         <v-autocomplete v-bind:items="keywords" v-model="query.keyword" label="Keyword" item-value="text" item-text="text" clearable>
             <template slot="item" slot-scope="data">
                  <v-list-item-content>
                    <v-list-item-title v-html="data.item.text"></v-list-item-title>
                    <v-list-item-subtitle v-html="data.item.count"></v-list-item-subtitle>
                  </v-list-item-content>
              </template>
            </v-autocomplete>
            
          <v-menu lazy :close-on-content-click="false" v-model="menu2" transition="scale-transition" offset-y full-width :nudge-left="40" max-width="290px">
         <template v-slot:activator="{ on }">
           <v-text-field v-on="on" label="Earliest date" v-model="query.from" prepend-icon="event" readonly clearable></v-text-field>
           </template>
           
          <v-date-picker v-model="query.from" scrollable actions>
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn text color="primary" @click="cancel()">Cancel</v-btn>
                <v-btn text color="primary" @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-date-picker></v-menu>
          
           <v-menu lazy :close-on-content-click="false" v-model="showUntil" transition="scale-transition" offset-y full-width :nudge-left="40" max-width="290px">
           
            <template v-slot:activator="{ on }">
		            <v-text-field v-on="on" label="Latest date" v-model="query.until" prepend-icon="event" readonly clearable></v-text-field>
          </template>        
          <v-date-picker v-model="query.until" scrollable actions>
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn flat color="primary" @click="cancel()">Cancel</v-btn>
                <v-btn flat color="primary" @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-date-picker>
          </v-menu>
        
            <v-checkbox :value="location.value" :indeterminate="location.use" @click="cyclelocation" label="With location"></v-checkbox>
        
        </v-card-text>
        
        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn @click="showFilter = false" color="primary">Apply</v-btn>
        </v-card-actions>
      </v-card>
     
 
 `,
       
  
  data(){ 
    return {
    query: {page:0,  // current page
           from:null,
           until:null,
           keyword:null
    },
    showFilter: false,
    busy: false,
    menu2: false,
    showUntil: false,
    keywords: [],
    showInfo: false,
    selitem: "TODO",
    location: {use:false,value:true},
   
  }
    },
  methods:{
    
    cyclelocation(){
      this.location.use=!this.location.use
    },
  
    clear(){
      this.query.from=null;
      this.query.until=null;
      this.query.keyword=null;
      this.query.page=0;
    },
   
    isChanged(vnew,vold){
      if(vnew.keyword != vold.keyword) return true
      if(vnew.from != vold.from) return true
      if(vnew.until != vold.until) return true
      return false
    },
   
   
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
    console.log("image filter mount")
    
  }
    }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/images/ireport.vue
const Report=Vue.extend({template:`  <v-container fluid> <v-card>
<v-toolbar class="orange darken-1"> <v-btn icon to="./">
<v-icon>arrow_back</v-icon></v-btn> <v-card-title> <v-chip>Settings</v-chip>
</v-card-title> <v-spacer></v-spacer> </v-toolbar> <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear> <v-card-text>
<ul v-if="report">
	<li>DB: {{ report.imagedb }}</li>
	<li><a :href="'/vue-poc/ui/database?url=/' + report.imagedb + '/'" target="new">db</a></li>
	<li></li>
</ul>
<pre>    {{ report | pretty }}
    </pre> </v-card-text> </v-card> </v-container>  `,
      
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
  <v-card> 
    <v-toolbar dense class="orange darken-1"> 
    <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn> 
    <v-card-title> 
    <v-chip>click to show</v-chip> 
    </v-card-title> 
    <v-spacer></v-spacer> 
    <v-text-field prepend-icon="search" label="Filter..." v-model="q" type="search" hide-details single-line @keyup.enter="setfilter" :append-icon="this.q?'clear':''" @click:append="e=>this.q=''"></v-text-field> </v-toolbar>
    <v-card-text>
    <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
        <v-container v-if="!busy" fluid grid-list-md>
          <v-layout row wrap v-touch="{ left: () => pageNext(), right: () => pageBack()}">
            <v-flex height="80px" @click="show(keyword)" xs3 v-for="keyword in items" :key="keyword.text">
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
 <v-container fluid>
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
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
      <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
      <v-toolbar-title>{{ job }}</v-toolbar-title>
    
     <v-btn v-if="!finished" @click="stop()" :disabled="finished">Stop</v-btn>
     <v-btn v-if="finished &amp;&amp; !result" @click="getResult()" :disabled="result || !finished">Result</v-btn>
    <v-chip class="orange white--text">{{  jobstate.state }}</v-chip>
  
        <v-chip label class="grey white--text"><v-icon class="red">lock</v-icon>{{  jobstate.writes }}</v-chip>
       <v-chip label class="grey white--text"><v-icon class="amber">lock</v-icon>{{  jobstate.reads }}</v-chip>
      <v-spacer></v-spacer>
      
       <v-chip class="primary white--text">
      <v-avatar>
        <v-icon>account_circle</v-icon>
      </v-avatar>
     {{  jobstate.user }}</v-chip>
     
       <v-chip class="green white--text">
        <v-avatar><v-icon>timer</v-icon></v-avatar>
       {{  jobstate.duration }}</v-chip>
       
      <v-btn icon :loading="loading" @click="getJob()" :disabled="loading || finished">
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
     <v-text-field prepend-icon="filter_list" label="Filter jobs" single-line hide-details clearable v-model="search"></v-text-field> 
      <v-spacer></v-spacer>
     <v-btn @click="stop()" :disabled="noSelection">Stop</v-btn>
   
      <v-btn icon><v-icon>add</v-icon></v-btn>   
      <v-spacer></v-spacer>
      
       <v-btn icon :loading="loading" @click="getJobs()" @dblclick="autorefresh = !autorefresh" :disabled="loading">
    <v-icon>{{ autorefresh?'refresh':'arrow_downward' }}</v-icon>
    </v-btn>
    </v-toolbar>
  <v-data-table :headers="headers" :items="items" :search="search" v-model="selected" show-select class="elevation-1" no-data-text="No Jobs currently running">
    <template slot="items" slot-scope="props">
    <td class="vtop">
        <v-checkbox primary hide-details v-model="props.selected"></v-checkbox>
      </td>
      <td class="vtop">  <router-link :to="{name: 'jobShow', params: {job: props.item.id }}">{{props.item.id}}</router-link></td>
      <td class="vtop "><div>{{ props.item.state }}</div><div>{{ props.item.type }}</div> </td>
      <td class="vtop " :title="props.item.registered">{{ props.item.registered | fromNow}}</td>
      <td class="vtop " :title="props.item.start">{{ props.item.start | fromNow}}</td>
       <td class="vtop text-xs-right">{{ props.item.duration }}</td>    
       <td class="vtop text-xs-right">{{ props.item.writes }}</td>
        <td class="vtop text-xs-right">{{ props.item.reads }}</td>
      <td class="vtop text-xs-right">{{ props.item.user }}</td>
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
        { text: 'Registered', value: 'registered' },
        { text: 'Start', value: 'start' },
        { text: 'Duration', value: 'duration' },
        { text: 'WriteL', value: 'writes' },
        { text: 'ReadL', value: 'reads' },
        { text: 'User', value: 'user' }
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/job/services.vue
const Services=Vue.extend({template:` 
  <v-card>
   <v-toolbar>
   <v-toolbar-title>Services</v-toolbar-title>
     <v-spacer></v-spacer>
     <v-text-field prepend-icon="filter_list" label="Filter services" single-line hide-details clearable v-model="search"></v-text-field> 
      <v-spacer></v-spacer>
     <v-btn @click="stop()" :disabled="noSelection">Stop</v-btn>
   
      <v-btn icon><v-icon>add</v-icon></v-btn>   
      <v-spacer></v-spacer>
      
       <v-btn icon :loading="loading" @click="getJobs()" @dblclick="autorefresh = !autorefresh" :disabled="loading">
    <v-icon>{{ autorefresh?'refresh':'arrow_downward' }}</v-icon>
    </v-btn>
     <vp-entitylink entity="basex.service"></vp-entitylink> 
    </v-toolbar>
  <v-data-table :headers="headers" :items="items" :search="search" v-model="selected" show-select class="elevation-1" no-data-text="No Jobs currently running">
    <template slot="items" slot-scope="props">
    <td class="vtop">
        <v-checkbox primary hide-details v-model="props.selected"></v-checkbox>
      </td>
      <td class="vtop">  <router-link :to="{name: 'jobShow', params: {job: props.item.id }}">{{props.item.id}}</router-link></td>
      <td class="vtop "><div>{{ props.item.running }}</div>
      </td><td class="vtop " :title="props.item.interval">{{ props.item.interval }}</td>
      <td class="vtop " :title="props.item.base-uri">{{ props.item['base-uri'] }}</td>
       <td class="vtop ">{{ props.item.query }}</td>    
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
        { text: 'Running', value: 'running' },
        { text: 'Interval', value: 'interval' },
        { text: 'Base-uri', value: 'base-uri' },
        { text: 'Query', value: 'query' },

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
    load(){    
        this.loading= true
        HTTP.get("data/basex.service",{params:{q:this.q}})
        .then(r=>{
          this.items= r.data.items
          this.loading= false
          if(this.autorefresh) this.timer=setTimeout(()=>{ this.load() }, 10000);
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
    this.load()
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/login/login.vue
const Login=Vue.extend({template:` 
 <v-container fluid>
	<v-card class="col-md-8 offset-md-2 ">
	      <v-card-title class="red">
	        <span class="white--text">The current credentials do the give access this page, please login.</span>
	      </v-card-title>
	   
	     <v-card-actions>
	    <v-form v-model="valid" ref="form">
                    <v-text-field label="Enter your user id " v-model="name" :rules="nameRules" required></v-text-field>
                    
                    <v-text-field label="Enter your password" v-model="password" min="8" :append-icon="hidepass ? 'visibility' : 'visibility_off'" @click:append="() => hidepass = !hidepass" :type="hidepass ? 'password' : 'text'" :rules="passwordRules" counter required></v-text-field>
                    
                    <v-switch label="Remember me" v-model="remember">
          </v-switch> 
                    <v-layout justify-space-between>
                       <v-spacer></v-spacer>
                        <v-btn @click="submit" :class=" { 'blue darken-4 white--text' : valid, disabled: !valid }">Login</v-btn>
                       
                    </v-layout>
          </v-form>
          </v-card-actions>
          <v-card-actions>
	     <a href>Forgot Password</a>
	     <v-alert color="error" v-bind:value="showMessage">
            {{message}}
          </v-alert>
          </v-card-actions>
	   
	</v-card>
</v-container>
 `,
      
    data () {
      return {
        valid: false,
        password: '',
        passwordRules: [
          (v) => !!v || 'Password is required',
        ],
        name: '',
        nameRules: [
          (v) => !!v || 'Name is required'
        ],
        hidepass: true,
        remember: false,
        redirect: this.$route.query.redirect,
        message:"",
        showMessage:false
      }
    },
    methods:{
      submit () {
        if (this.$refs.form.validate()) {
          this.go()
        }
      },
      clear () {
        this.$refs.form.reset()
      },
      go () {
       this.hidepass=true
       this.showMessage=false
       var data={
             username: this.name, //gave the values directly for testing
             password: this.password,
             remember: this.remember,
             redirect: this.redirect
             }
       HTTP.post("login-check",Qs.stringify( data))
      .then(r=>{
        console.log("login",r.data)
        if(r.data.status){
          this.$auth.role="admin";
          this.$auth.user=this.name;
          console.log("redirect",this.redirect);
          this.$router.replace({path: this.redirect});
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/map.vue
const Leaflet=Vue.extend({template:` 
<v-container>
  <v-card hover raised> 
  <v-toolbar> 
    <v-card-title> 
      map
     </v-card-title>
	<v-spacer></v-spacer>
	 Center: {{ center }}, zoom is: {{ zoom }}
	</v-toolbar> 
	<v-card-text>
	 <v-row>
      <v-col style="height: calc(100vh - 210px);">  
  
     <l-map :zoom="zoom" :center="center" @update:center="centerUpdate" @update:zoom="zoomUpdate" style="height:100%;">
      <l-tilelayer :url="url" :attribution="attribution"></l-tilelayer>
      <l-marker :lat-lng="marker"></l-marker>
    </l-map>
     </v-col>
     </v-row>
     </v-card-text>
     </v-card>
     </v-container>
 `,
      
//leaflet
 components: {
    "l-map": Vue2Leaflet.LMap,
    "l-tilelayer": Vue2Leaflet.LTileLayer,
    "l-marker": Vue2Leaflet.LMarker
   },
  
  data:  function(){
    return {
      zoom: 13,
      center: [54.320498718, -2.739663708],
      url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      marker: L.latLng(54.320498718, -2.739663708)
    }
  },
  methods: {
	  zoomUpdate(zoom) {
	      this.zoom = zoom;
	    },
	    centerUpdate(center) {
	      this.center = center;
	    },
  },
  watch:{
	 center: function(c){
		 const query = Object.assign({}, this.$route.query);
		 const isArray= Array.isArray(c)
		 query.center=isArray? c[0]+","+c[1] : c.lat + "," + c.lng 
		 this.$router.push({ query });
	 },
	 zoom: function(z){
		 const query = Object.assign({}, this.$route.query);
		 query.zoom= z 
		 this.$router.push({ query });
	 } 
  },
  created:function(){
    console.log("map")
    if(this.$route.query.center){
    	const c= this.$route.query.center.split(",").map(x=>parseFloat(x))
    	console.log("center",c)
    	this.center= c
    }
    if(this.$route.query.zoom){
    	const z= parseFloat(this.$route.query.zoom)
    	console.log("zoom",z)
    	this.zoom= z
    }
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/model/entity.vue
const Entity=Vue.extend({template:` 
<v-container fluid grid-list-md>
  
    <v-data-iterator :items="items" :items-per-page.sync="itemsPerPage" :search="q" hide-default-footer select-all :value="selected">
    
     <template v-slot:header>
       <v-toolbar>
			 <v-toolbar-title> 
			    <v-breadcrumbs :items="[{text:'Entities',to:'/entity'}]">
						     <template slot="item" slot-scope="props">
					           <v-breadcrumbs-item :to="props.item.to" :disabled="props.item.disabled" :exact="true">
					                {{ props.item.text }}
					           </v-breadcrumbs-item>
					       </template>
		     </v-breadcrumbs>
		   </v-toolbar-title>
			  <v-spacer></v-spacer> 
			 <v-text-field prepend-icon="filter_list" label="Filter..." v-model="q" type="search" hide-details single-line @keyup.enter="setfilter" clearable></v-text-field>
		   <v-spacer></v-spacer>
			 <v-btn @click="getItems" icon :loading="loading" :disabled="loading"><v-icon>refresh</v-icon></v-btn>
		   <vp-entitylink entity="entity"></vp-entitylink>
	 </v-toolbar>
	 </template>
	 
     <template v-slot:default="props">
        <v-layout wrap>
          <v-flex v-for="item in props.items" :key="item.name" xs12 sm6 md4 lg3>
     
        <v-card :hover="true" active-class="default-class qd-active" height="200px" max-height="200px">
        
          <v-toolbar color="blue lighten-3" dense>
		          <v-toolbar-title>
		           <router-link :to="{path:'entity/'+ item.name}">
		            <v-avatar>
		             <v-icon>{{ item.iconclass }}</v-icon> 
		            </v-avatar> {{ item.name }}
		            </router-link></v-toolbar-title>
		         
		         <v-spacer></v-spacer>
		         <v-badge>
			      <span slot="badge">{{ item.nfields }}</span>
			    </v-badge>
          </v-toolbar>
          <v-card-text>{{ item.description }}<!--<v-card-text-->
        </v-card-text></v-card>
      </v-flex>
      </v-layout>
      </template>
    </v-data-iterator>
  </v-container>
 `,
      
  data:  function(){
    return {
   	  itemsPerPage: 100,
      page: 1,
      items:[],
      search: '',
      filter: {},
      loading: false,
      q: '',   
      selected:[]
      }
  },
  methods:{
    getItems(){
      this.loading=true
      HTTP.get("data/entity",{params:{q:this.q}})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.items=r.data.items
        }) 
    },
    setfilter(){
      console.log("TODO",this.q);
      this.$router.push({ query: {url: this.url,
                                   q: this.q }})
    }
  },

  created:function(){
    this.getItems()
  },
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/model/entity1.vue
const Entity1=Vue.extend({template:` 
<v-card>
	<v-toolbar>
	 <v-toolbar-title> 
         <qd-breadcrumbs @todo="showmenu= ! showmenu" :crumbs="[{to: '/entity', text:'Entities'}, {text: entity, disabled: false, menu: 'todo'}]">crumbs</qd-breadcrumbs> 
         </v-toolbar-title>   
          <v-menu v-model="showmenu">
            <template v-slot:activator="{ on }">
              <v-btn dark icon v-on="on">
                <v-icon>mdi-dots-vertical</v-icon>
              </v-btn>
            </template>
            <v-list dense>
                <v-subheader>Views</v-subheader>
                <v-list-item>
                  <router-link :to="$route.path + '/data'">
                  <v-list-item-title>Data {{ $route.path }}</v-list-item-title>
                  </router-link>
                </v-list-item>
                <v-list-item @click="getxml">
                  <v-list-item-title>View XML</v-list-item-title>
                </v-list-item>
                <v-list-item>
                  <v-list-item-title><a :href="dataurl" target="data">Json</a></v-list-item-title>
                </v-list-item>             
            </v-list>         
           </v-menu> 

	 <v-spacer></v-spacer>
	 
	 <v-btn icon @click="getItem" :loading="loading" :disabled="loading"><v-icon>refresh</v-icon></v-btn>
	
	 </v-toolbar>

  <v-container fluid>
	  <v-expansion-panels>
	    <v-expansion-panel expand>
			     <v-expansion-panel-header>
			     <v-layout>
		          <v-flex xs12>
						     <v-avatar><v-icon>{{ item.iconclass }}</v-icon></v-avatar>
						     <span class="font-weight-black">{{ item.name }}</span> 
					         {{item.description}}
					 </v-flex>
			     </v-layout>        
			     </v-expansion-panel-header>
			     <v-expansion-panel-content>
			          <pre v-if="xml"><code>{{ xml }}</code></pre> 
			      </v-expansion-panel-content>
			      <v-expansion-panel>
	      </v-expansion-panel>
	       
	      <v-expansion-panel> 
           <v-expansion-panel-header><v-layout>
	          <v-flex xs12>Type: <code>{{ item.type }}</code></v-flex>
	          </v-layout>
          </v-expansion-panel-header>
		      <v-expansion-panel-content>
				  <prism language="xquery">{{ code(item) }}</prism>
		      </v-expansion-panel-content>
		</v-expansion-panel>
		
		<v-expansion-panel>
		<v-expansion-panel-header><v-layout>
          <v-flex xs12>
	               <span>Fields ({{ item.nfields }})</span>
	          </v-flex>
	          </v-layout>
	      </v-expansion-panel-header> 
	      <v-expansion-panel-content>
	           <qd-table :headers="headers" :data-uri="&quot;data/entity/&quot;+entity +&quot;/field&quot;" entity="entity.field" no-data-msg="Nothing found">
	          </qd-table>
	      </v-expansion-panel-content>
	     </v-expansion-panel>
	   </v-expansion-panel></v-expansion-panels>
  </v-container>
   </v-card>
 `,
      
  components: { 
    "prism": PrismComponent
    },
  props: ['entity'],
  data:  function(){
    return {
      item: {description:null,
             code: null
      },
      showmenu: false,
      loading: false,
      xml: null,
      selected: [],
      headers: [
        { text: 'Name', value: 'name', align: 'left'},
        { text: 'parent', value: 'parent', align: 'left' },
        {text: "type", value: "type"},
        {text: "description", value: "description"},
        {text: "xpath", value: "xpath"}
      ],
      panel: [true, false, true]
      }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/entity/"+this.entity)
      .then(r=>{
        this.loading=false
        this.item=Object.assign({}, this.item, r.data)
        }) 
    },
    code(item){
      return item.modules + " " +  item.namespaces + " " +item.code       
    },
    getxml(){
      HTTP.get("data/entity/"+this.entity,{ headers: {Accept: "text/xml"}})
      .then(r=>{
        this.xml=r.data;
            }) 
    },
    todo(){
      alert("TODO");
    }
  },
  computed: {
    dataurl(){
         return '/vue-poc/api/data/' + this.entity;
       },
       xquery(){
         return '/vue-poc/api/data/' + this.entity;
       }   
  },
  created:function(){
    this.getItem()
  },
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/model/entity1data.vue
const Entity1data=Vue.extend({template:` 
<v-card>
	<v-toolbar>
	 <v-toolbar-title> 
         <qd-breadcrumbs @todo="showmenu= ! showmenu" :crumbs="[{to: '/entity', text:'Entities'}, {text: entity, disabled: false, menu: 'todo'}]">crumbs</qd-breadcrumbs> 
         </v-toolbar-title>   
          <v-menu v-model="showmenu">
            <template v-slot:activator="{ on }">
              <v-btn dark icon v-on="on">
                <v-icon>mdi-dots-vertical</v-icon>
              </v-btn>
            </template>
            <v-list dense>
                <v-subheader>Views</v-subheader>
                <v-list-item>
                  <router-link :to="$route.path + '/data'">
                  <v-list-item-title>Data {{ $route.path }}</v-list-item-title>
                  </router-link>
                </v-list-item>
                <v-list-item>
                  <v-list-item-title>View XML</v-list-item-title>
                </v-list-item>
                
            </v-list>         
           </v-menu> 

	 <v-spacer></v-spacer>
	 
	 <v-btn icon @click="getItem" :loading="loading" :disabled="loading"><v-icon>refresh</v-icon></v-btn>
	
	 </v-toolbar>

  <v-container fluid>
	  <pre>{{ data | pretty }}</pre>
  </v-container>
   </v-card>
 `,
      
 
  props: ['entity'],
  data:  function(){
    return {
      data:  null,
      showmenu: false,
      loading: false,
    }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/"+ this.entity)
      .then(r=>{
        this.loading=false
        this.data=Object.assign({}, this.item, r.data)
        console.log("data",this.data)
        }) 
    }
  },
 
  created:function(){
    this.getItem()
  },
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/namespaces/namespace.vue
const Namespace=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 
   <v-toolbar>
   <v-toolbar-title>
    <v-breadcrumbs :items="crumbs">
         <template slot="item" slot-scope="props">
             <v-breadcrumbs-item :to="props.item.to" :disabled="props.item.disabled" :exact="true">
                  {{ props.item.text }}
              </v-breadcrumbs-item>
          </template>
     </v-breadcrumbs>
   </v-toolbar-title>
     <v-btn @click="load" icon :loading="loading" :disabled="loading"><v-icon>refresh</v-icon></v-btn>
   
   <v-spacer></v-spacer>
   
   <v-text-field prepend-icon="filter_list" label="Filter..." v-model="q" type="search" hide-details single-line @keyup.enter="setfilter" clearable></v-text-field>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="namespace"></vp-entitylink> 
   </v-toolbar>
   
   <v-card-text>
    <v-data-table :headers="headers" :items="items" :loading="loading" hide-default-footer :search="q" class="elevation-1">
  
  <template v-slot:item.xmlns="{ item }"> 
	      <td><router-link :to="{path:'namespace/item?xmlns='+ item.xmlns}">
                 {{ item.xmlns }}
                </router-link></td>
    </template>
      
    <template slot="no-results">
        No matching results.
    </template>
    
    <template slot="no-data">
        No matching items.
    </template>
  </v-data-table>
   </v-card-text>
   </v-card>
   </v-container>
 `,
      
  data:  function(){
    return {
      items: [],
      loading: false,
      q: "",
      message: 'bad route!',
     
      selected:[],
      headers: [
        
        { text: 'xmlns', value: 'xmlns' },
        
        { text: 'Description', value: 'description' },
        { text: 'Prefix', value: 'prefix' }
        ],
        crumbs:[{to:"/namespace", text:"namespaces"}]
      }
  },
  methods: {
    load(){
    
      this.loading= true
      HTTP.get("data/namespace",{params:{q:this.q}})
      .then(r=>{
        this.items= r.data.items
        this.loading= false
        })
      
    },
    setfilter(){
      console.log("TODO",this.q)
      this.$router.push({  query: {url:this.url,q:this.q }})
    },
  },
  watch:{
    $route(vnew,vold){
      console.log("ROUTE",vnew,vold)    
      var url=this.$route.query.url
      this.url=url?url:"/";
      if(vnew.query.url != vold.query.url) this.load() 
    }
  },

  created:function(){
    this.q=this.$route.query.q || this.q;
    this.load();
    console.log("namespaces")
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/namespaces/namespace1.vue
const Namespace1=Vue.extend({template:` 
<v-card>
	<v-toolbar>
	 <v-toolbar-title> 
   <v-breadcrumbs>
            <v-breadcrumbs-item to="/namespace" :exact="true">
            Namespaces
            </v-breadcrumbs-item>
            
              <v-breadcrumbs-item>
            {{ xmlns }}
            </v-breadcrumbs-item>
        </v-breadcrumbs>
   </v-toolbar-title>
	 <v-toolbar-title>

	 <v-spacer></v-spacer>
	 <v-btn @click="getItem" icon :loading="loading" :disabled="loading"><v-icon>refresh</v-icon></v-btn>
	 </v-toolbar-title></v-toolbar>

  <v-container fluid grid-list-md>
  
  
      hello
      <div>{{ item.prefix }}</div>
      <div>{{ item.xmlns }}</div>
      <div>{{ item.description }}</div>
  </v-container>
   </v-card>
 `,
      
  data:  function(){
    return {
      xmlns: '',
      item: {},
      loading: false
      }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/namespace/item",{id: this.xmlns})
      .then(r=>{
        this.loading=false;
        console.log(r.data)
        this.item= r.data
        }) 
    }
  },
  created:function(){
    this.xmlns=this.$route.query.xmlns;
    this.getItem()
  },
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/puzzle.vue
const Puzzle=Vue.extend({template:` 
 <v-container fluid>
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
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/basex.repo" entity="repo" no-data-msg="Nothing found">
    <template slot="items" slot-scope="props">
      <td>
        <v-checkbox primary hide-details v-model="props.selected"></v-checkbox>
      </td>
      <td>{{ props.item.name}}</td>
      <td>{{ props.item.type }}</td>
        <td>{{ props.item.version }}</td>
    </template>
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
        { text: 'Name', value: 'name'},
        { text: 'Type', value: 'type' },
        { text: 'Version', value: 'version' }
      ] 
      }
  },
 
created:function(){
  console.log("repo")
}
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/scratch.vue
const Scratch=Vue.extend({template:` 
 <v-container fluid>
   <v-toolbar tabs dense>
   <v-toolbar-title>Tab index {{ curIndex }}</v-toolbar-title>
   <v-btn v-if="active">{{ active.mode }}</v-btn>
   <qd-mimelist v-if="active" :mimetype="active.contentType" @selected="setmime">{{ active.mode }}</qd-mimelist>
   <v-btn v-if="active"> {{ active.name }}, id: {{ active.id }}</v-btn>
   <v-spacer></v-spacer>

   <v-btn @click="add">Add</v-btn>
    <v-btn @click="curIndex=2">set</v-btn>
  
    <v-layout slot="extension">
    <v-flex xs11>
    <v-tabs v-model="curIndex">
          <v-tab v-for="(item,index) in EditTabs.items" :key="item.id" ripple style="text-transform: none;text-align:left">
             <v-avatar>
                <v-icon size="16px">insert_drive_file</v-icon>
             </v-avatar>
             <span>{{ (item.dirty?"*":"") }}</span>
              <span>{{ item.name  }}</span>
             <v-spacer></v-spacer>
             <v-btn icon @click.stop="tabClose(item,index)">
                <v-icon size="16px">close</v-icon>
              </v-btn>
          </v-tab>
     </v-tabs>
     </v-flex>
     <v-flex xs1>
    <qd-tablist v-if="EditTabs" :edittabs="EditTabs" :current="curIndex" @selected="setItem">tab list</qd-tablist>

    </v-flex>
     </v-layout>
  </v-toolbar>
   
      <v-tabs-items v-model="curIndex">
       <v-tab-item v-for="item in EditTabs.items" :key="item.id">
          <v-card>
            <div style="height:200px" ref="ace" v-resize="onResize">
            <v-flex xs12 fill-height>
              <vue-ace :content="item.text" v-on:change-content="changeContent" :events="events" :mode="item.mode" :wrap="wrap" :settings="aceSettings" v-on:annotation="annotation" :completer="$aceExtras.basexCompleter" :snippets="$aceExtras.snippets"></vue-ace>
            </v-flex>
            </div> 
          </v-card>
        
      </v-tab-item>
   </v-tabs-items>
 </v-container>
 `,
      
  data:  function(){
    return {
      curIndex: null, //index of current
      active: null,
      showInfo: false, // showing info
      wrap: true,
      events:  new Vue({}),
      aceSettings: {},
      annotations: null,
      folded: false,
      EditTabs: EditTabs
      }
  },
  methods:{
    add(){
      var a=this.EditTabs.addItem({text:"hi "+ new Date()})
      this.curIndex=this.EditTabs.items.indexOf(a)
    },
  
    tabClose(item,index){
      if(item.dirty){
        if (!confirm("Not saved continue? "+ index))return;
      }else{
        this.EditTabs.closeItem(item)
        this.curIndex=0
      }
    },
    setItem(v){
      this.curIndex=v;
    },
    setmime(mime){
      this.$set(this.active, 'contentType', mime.name)
      this.$set(this.active, 'mode', mime.mode)
      //alert(mime.contentType+" "+mime.mode)
    },
    annotation(counts){
      this.annotations=counts
      //console.log("annotations: ",counts)
    },
    changeContent(val){
      var item=this.active;
      //console.log("change",val);
 
      if (item.text !== val) {
        item.text = val;
        item.dirty=true;
      }
    },
    onResize(){
      var el=this.$refs["ace"];
      for (e of el){
      //console.log("top",e.offsetTop)
      var h=Math.max(1,window.innerHeight - e.offsetTop -200) 
      // console.log("h",h)
      e.style.height=h +"px";
    }
    }
    
  },
  
  computed:{
    count(){
      console.log("LEN:",this.EditTabs.length)
      return this.EditTabs.length
      }
  },
  
  watch:{
    curIndex (val) {
      this.active = EditTabs.items[val];
      console.log("curIndex: ",val)
      if(this.active) this.$router.push({  query: { id: this.active.id }});
    }
  },
  
  beforeRouteEnter (to, from, next) {
    Promise.all([Settings.getItem('settings/ace')
                 ])
    .then(function(values) {
      next(vm => {
          vm.aceSettings = values[0];
          console.log("SSS",JSON.parse(JSON.stringify(EditTabs.items)))
          })
          })
    },
    created:function(){
      var url=this.$route.query.url;
      if(url){
        EditTabs.loadItem(url);
      }else{
      var tid=this.$route.query.id;
      var id=EditTabs.items.findIndex(i=>i.id ==tid)
      console.log("set tab",tid,id)
      EditTabs.restored.then(()=>{
        var id=EditTabs.items.findIndex(i=>i.id ==tid)
        console.log("set tab",tid,id)
        this.curIndex= id;
      });
      }
    }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/search/search.vue
const Search=Vue.extend({template:` 
 <v-container fluid>
 <v-alert color="warning" value="true">Not finished</v-alert>
 <v-text-field label="Search..." v-model="q" v-on:keyup="send"></v-text-field> 
  <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
  <v-layout>
    <v-flex>
    <v-list v-if="!busy" two-line subheader>
      
        <v-list-item v-for="(item,index) in results" v-bind:key="item.uri" :to="item.uri" v-model="selected[index]" avatar>
          <v-list-item-avatar @click.prevent.stop="select(index)">
            <v-icon v-text="icon(index)"></v-icon>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>{{ index }} {{ item.title }}</v-list-item-title>
            <v-list-item-subtitle>{{ item.uri }}</v-list-item-subtitle>
          </v-list-item-content>
          <v-list-item-action>
            <v-btn icon ripple>
              <v-icon class="grey--text text--lighten-1">info</v-icon>
            </v-btn>
          </v-list-item-action>
        </v-list-item>
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
 <v-container fluid>
<v-card>
    <v-toolbar class="green darken-1">
    <v-card-title>
      <span class="white--text">Selection2</span>     
    </v-card-title>
    <v-spacer></v-spacer>    
       <v-btn text icon @click="showInfo = !showInfo"><v-icon>info</v-icon></v-btn>
  </v-toolbar>

  <qd-panel :show="showInfo">
  

    <v-layout slot="body" row wrap>
     
      <v-flex xs12>
          <v-treeview v-model="tree" :open="open" :items="items" activatable item-key="name" open-on-click>
          <template slot="prepend" slot-scope="{ item, open, leaf }">
            <v-icon v-if="!item.file">
              {{ open ? 'mdi-folder-open' : 'mdi-folder' }}
            </v-icon>
            <v-icon v-else>
              {{ files[item.file] }}
            </v-icon>
          </template>
        </v-treeview> 
     </v-flex>
        
    <v-flex xs6>
    <p>some text</p>
   
  
     <v-autocomplete label="Select" v-bind:items="options" v-model="value" item-text="name" item-value="name" chips max-height="auto" clearable deletable-chips>      
           
       </v-autocomplete>
         <pre>{{$data.value }}</pre>
    </v-flex>

    <v-flex xs6>
    <p>multi select</p>
    
      <v-select label="Select" v-bind:items="options" v-model="value2" item-text="name" item-value="name" multiple chips deletable-chips max-height="auto" autocomplete>v-select</v-select>
            <pre>{{$data.value2 }}</pre>
    </v-flex>
   
   </v-layout>
   
   <v-card slot="aside" flat> 
       <v-card-actions>
      <v-toolbar-title>test aside</v-toolbar-title>
      <v-spacer></v-spacer>    
       <v-btn text icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-card-actions>
    <v-card-text> 
 todo
  </v-card-text> 
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
          showInfo:true,
          open: ['public'],
          files: {
            html: 'mdi-language-html5',
            js: 'mdi-nodejs',
            json: 'mdi-json',
            md: 'mdi-markdown',
            pdf: 'mdi-file-pdf',
            png: 'mdi-file-image',
            txt: 'mdi-file-document-outline',
            xls: 'mdi-file-excel'
          },
          tree: [],
          items: [
            {
              name: '.git'
            },
            {
              name: 'node_modules'
            },
            {
              name: 'public',
              children: [
                {
                  name: 'static',
                  children: [{
                    name: 'logo.png',
                    file: 'png'
                  }]
                },
                {
                  name: 'favicon.ico',
                  file: 'png'
                },
                {
                  name: 'index.html',
                  file: 'html'
                }
              ]
            },
            {
              name: '.gitignore',
              file: 'txt'
            },
            {
              name: 'babel.config.js',
              file: 'js'
            },
            {
              name: 'package.json',
              file: 'json'
            },
            {
              name: 'README.md',
              file: 'md'
            },
            {
              name: 'vue.config.js',
              file: 'js'
            },
            {
              name: 'yarn.lock',
              file: 'txt'
            }
          ]
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
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/server/basexsettings.vue
const Basexsettings=Vue.extend({template:` 
  <v-card>
  <v-toolbar>
  <v-toolbar-title>BaseX settings</v-toolbar-title>
  <v-spacer></v-spacer>
  <v-toolbar-items>
   <v-checkbox v-model="changed" label="Changed only"></v-checkbox>
    </v-toolbar-items>
  </v-toolbar>
  
  <v-card-text>
     <v-data-table :headers="headers" :items="filtered" class="elevation-1">
    <template slot="items" slot-scope="props">
      <td>{{ props.item.name }}</td>
      <td>{{ props.item.current }}</td>
      <td>{{ props.item.changed }}</td>
      <td class="text-xs-right">{{ props.item.default }}</td>
      <td>
        <qd-link :href="'http://docs.basex.org/wiki/Options#' + props.item.name.toUpperCase()">description</qd-link>
      </td>
    </template>
  </v-data-table>
   </v-card-text>
 
    </v-card> 
	 `,
      
  data: ()=>({
    busy: false,
    items: [],
    changed: true,
    
    headers: [
      { text: 'Name', value: 'name'},
      {text: "current", value: "current"},
      {text: "changed", value: "changed"},
      {text: "default", value: "default"},
      {text: "description"}
      ],
      pagination: {
        descending: false,
        page: 1,
        rowsPerPage: 100 ,// -1 for All
        sortBy: 'name'
      }
  }),
  
  methods:{
    get(){
      this.busy=true

      HTTP.get("server/basexsettings")
      .then(r=>{
        this.busy=false
        this.items=r.data
      
        }) 
    }
  },
  computed: {
    // a computed getter
    filtered: function () {
       return this.items.filter(item=> item.changed == this.changed)
    }
  },
  created:function(){
    console.log("reports")
    this.get()
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/server/dicetest.vue
const Dicetest=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 <v-toolbar>
 <v-toolbar-title>Dice entity list</v-toolbar-title>
 
 <v-spacer></v-spacer>
 <v-btn @click="reset()">Reset</v-btn>
 </v-toolbar>
 <v-card-text>
  <p>Read json data for 1st page for entity.</p>
   <v-flex xs12 sm6>
     <v-combobox v-model="entity" :items="entities" item-text="name" label="Select target" clearable open-on-clear></v-combobox>
      
    </v-flex>
 
  <table class="v-data-table">
      <thead> 
        <tr>
         <th xs1>url</th>
         <th xs1>Action</th>
          <th xs1>Repeat</th>
          <th xs1>Last</th>
          <th xs1>Count</th>
          <th xs1>Avg</th>
          <th xs1>min</th>
          <th xs1>max</th>
          <th xs1>Median</th>
        </tr>
      </thead>
      <tbody>

      
          <tr>
              <td>
              {{ entity &amp;&amp; entity.name  }}
               </td>
              <td>
               <v-btn @click="get()" :disabled="!entity">
                   Read <v-icon right>compare_arrows</v-icon> 
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
          
          
      </tbody>
    </table>
    
     <h3>Value: <v-chip color="amber" text-color="white">{{counter}}</v-chip></h3>
     <pre>{{ result | pretty}}</pre>
    </v-card-text>
    </v-card>
    
 </v-container>
 `,
      
  data:  function(){
    return {
      getValues: new perfStat(),
      repeat: {get:false},
      entity: null,
      counter: 0,
      result: null,
      entities: null
      }
  },
  methods:{

    get(){
     var _start = performance.now();
     console.log("entity:", this.entity)
     HTTP.get(this.entity.datalink,axios_json)
     .then(r=>{
       var elapsed=Math.floor(performance.now() - _start);
       this.counter++;
       this.result=r.data;
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
    
    reset(){
      Object.assign(this.getValues,this.getValues.clear());
      this.$forceUpdate()
    },
    getentities(){
      HTTP.get("data/entity",axios_json)
      .then(r=>{
        console.log("entities: ",r.data);
        this.entities=r.data.items
      })
    }
  },
  created(){
    console.log("GET entities: ");
    this.getentities()
  },
  beforeRouteLeave(to, from, next){
    var on=this.repeat.get 

    if (on) {
      alert("running!") //<--undefined
      return next(false)
    } else {
      return next()
    }
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/server/ping.vue
const Ping=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 <v-toolbar>
 <v-toolbar-title>Simple response counter</v-toolbar-title>
 <v-spacer></v-spacer>
 <v-btn @click="reset()">Reset</v-btn>
 </v-toolbar>
 <v-card-text>
  <p>Read or increment a database value. This measures round trip times browser-database-browser.</p>
  <h3>Value: <v-chip color="amber" text-color="white">{{counter}}</v-chip></h3>
  <table class="v-table">
      <thead> 
        <tr>
         <th class="col-md-1">Action</th>
          <th class="col-md-1">Repeat</th>
          <th class="col-md-1 text-right">Last</th>
          <th class="col-md-1 text-right">Count</th>
          <th class="col-md-1 text-right">Avg</th>
          <th class="col-md-1 text-right">min</th>
          <th class="col-md-1 text-right">max</th>
          <th class="col-md-1 text-right">Median</th>
        </tr>
      </thead>
      <tbody>

      
          <tr>
              <td>
               <v-btn @click="get()">
                   Read Db<v-icon right>compare_arrows</v-icon> 
                </v-btn>
             
               </td>
               <td>
                <v-switch v-on:change="gchange" v-model="repeat.get"></v-switch>

             </td>    
              <td>
                  <p class="text-right">{{getValues.last}}</p>
              </td>
              <td>
                  <p class="text-right">{{getValues.count}}</p>
              </td>   
            
              <td>
                  <p class="text-right">{{getValues.avg | round(2)}}</p>
              </td>
            
              <td>
                  <p class="text-right">{{getValues.min}}</p>
              </td>
              <td>
                  <p class="text-right">{{getValues.max}}</p>
              </td>
                <td>
                  <p class="text-right">{{getValues.median}}</p>
              </td>
          </tr>
          
            <tr>
          <td>
           <v-btn @click="update()">
                 Write Db<v-icon right>compare_arrows</v-icon>
            </v-btn>
          </td>
          
          <td>
           <v-switch v-on:change="pchange" v-model="repeat.post"></v-switch>
          </td>
           <td class="text-right">
                <span>{{postValues.last}}</span>
           </td>
          <td class="text-right">
            <span>{{postValues.count}}</span>
          </td>
                 
          <td class="text-right">
            <span>{{postValues.avg | round(2)}}</span>
          </td>
          
          <td class="text-right">
            <span>{{postValues.min}}</span>
          </td>
          <td class="text-right">
              <span>{{postValues.max}}</span>
          </td>
            <td class="text-right">
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
      nothingValues: new perfStat(),
      staticValues: new perfStat(),
      getValues: new perfStat(),
      postValues: new perfStat(),
      repeat: {get: false, post: false, staticx: false, nothing: false},
      counter: "(unread)"
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
    nothing () {
      var _start = performance.now();
     HTTP.post("nothing",axios_json)
     .then(r=>{
       var elapsed=Math.floor(performance.now() - _start);
       this.counter=r.data
       Object.assign(this.nothingValues,this.nothingValues.log(elapsed))
       if(this.repeat.nothing){
         this.nothing(); //does this leak??
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
  beforeRouteLeave(to, from, next){
    var on=this.repeat.get || this.repeat.post

    if (on) {
      alert("running!") //<--undefined
      return next(false)
    } else {
      return next()
    }
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/server/upload.vue
const Upload=Vue.extend({template:` 
 <v-container fluid>
 <v-snackbar v-model="snack" color="success">File upload complete</v-snackbar>
 <v-card>
 <v-card-title>File transfers</v-card-title>
 <v-card-text>
 <v-file-input v-model="file" label="File input"></v-file-input>
 <v-btn @click="post()" :disabled="!file">submit</v-btn>
 </v-card-text>
</v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      snack: false,
      file: null
      }
  },
  methods:{
    upit:function(s){
      this.snack=true;
    },
    post(){
    	let rawData = {
                name: this.name,
                gender: this.gender,
                dob: this.dob
              }
        rawData = JSON.stringify(rawData)
    	let formData = new FormData()
        formData.append('avatar', this.file, this.file.name)
        formData.append('data', rawData)
        let response = HTTP.post('upload2', formData, {
              headers: {
                'Content-Type': 'multipart/form-data'
              }
         }).then(r=>{
        	console.log("upload: ",r)	 
         })
    }
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/session.vue
const Session=Vue.extend({template:` 
 <v-container fluid>
  <v-layout>
   <v-btn v-on:click="redraw">this.$forceUpdate()</v-btn>
    <v-btn v-on:click="logout">logout</v-btn>
     <v-btn v-on:click="refresh">refresh</v-btn>
 
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
        <td>user</td><td>{{ $auth.user }}</td>
        </tr>
        <tr>
        <td>created</td><td>{{ $auth.created }}</td>
        </tr>
        <tr>
        <td>session</td><td>{{ $auth.session }}</td>
        </tr>
        <tr>
        <td>permision</td><td>{{ $auth.permission }}</td>
        </tr>
        </tbody>
        </table>
        <pre>        {{ $auth }}
        </pre>
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
    refresh(){
      HTTP.get("status")
      .then(r=>{
        console.log("status",r)
        this.$auth=Object.assign(this.$auth,r.data);
        //this.$forceUpdate()
      })  
    },
    handleSelected(){
      
    }
  }
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/settings/acesettings.vue
const Acesettings=Vue.extend({template:` 
<v-container fluid>

  <v-layout row>
    <v-flex xs12 sm8 offset-sm2>
      <v-card>
       <v-toolbar class="orange">
        <v-card-title> <qd-breadcrumbs :crumbs="[{to: '/settings', text:'Settings'}, {text: 'Common Ace editor settings.', disabled: true }]">crumbs</qd-breadcrumbs></v-card-title>
        </v-toolbar>
      <v-card-text>
      <v-container fluid>
       <v-layout row>
          <v-flex xs6 class="pa-3">
        <v-layout row>
          
          <v-flex>
            <v-select :disabled="$vuetify.theme.dark" v-bind:items="themes" v-model="ace.theme" label="Theme"></v-select>
          </v-flex>
          <v-flex>
            <v-select :disabled="!$vuetify.theme.dark" v-bind:items="themesDark" v-model="ace.themeDark" label="Dark Theme"></v-select>
          </v-flex>
        </v-layout>
       
        <v-layout row>
         
          <v-flex>
            <v-select v-bind:items="keybindings" v-model="ace.keybinding" label="Key binding"></v-select>
           
          </v-flex>
        </v-layout>
        <v-layout row>
         
          <v-flex>
            <v-text-field label="Font size (px)" v-model="ace.fontsize"></v-text-field>
          </v-flex>
        </v-layout>
         </v-flex>
        <v-flex xs6 style="height:30vh" class="grey pa-3" fill-height>
            <vue-ace mode="xquery" content="test" :settings="ace"></vue-ace>
        </v-flex>
        </v-layout>
       <v-divider></v-divider>
 
        
        <v-list two-line subheader>
          <v-subheader>Ace editor behaviour</v-subheader>
   
            <v-list-item>
              <v-list-item-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>enableSnippets</v-list-item-title>
                <v-list-item-subtitle>Allow 
                <a href="https://cloud9-sdk.readme.io/docs/snippets" target="docs">snippets</a></v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
    
            <v-list-item>
              <v-list-item-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>enableBasicAutocompletion</v-list-item-title>
                <v-list-item-subtitle>Autocompletion via control-space</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
         
            <v-list-item>
              <v-list-item-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>enableLiveAutocompletion</v-list-item-title>
                <v-list-item-subtitle>Autocompletion while typing</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
            
        </v-list>
        
       
    </v-container></v-card-text>
      </v-card>
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
			        themeDark: "twilight",
			        keybinding: "ace",
			        fontsize: "14"
			    },
			    keybindings:[  'ace',  'vim', 'emacs', 'textarea', 'sublime' ],
			    themes: [ "github","chrome" ,"tomorrow"],
			    themesDark: ["chaos","twilight"]
			    }
  },
  methods:{
    extend(obj, src) {
      Object.keys(src).forEach(function(key) { if(!obj[key]) obj[key] = src[key]; });
      return obj;
    }
  },
  
   beforeRouteLeave (to, from, next) {
     Settings.setItem('settings/ace',this.ace)
     .then(v=>{
     next()
     })
   },
  mounted: function () {
  
 // console.log("$$$",this.ace)
  Settings.getItem('settings/ace')
    .then( v =>{
              //alert("db\n"+JSON.stringify(v))
              this.ace = Object.assign({}, this.ace, v)
              //alert("op\n"+JSON.stringify(this.ace))
                  })

  }
}


      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/settings/keys.vue
const Keys=Vue.extend({template:` 
 <v-container fluid>
 
	 <v-card>
	  <v-toolbar dense>
	   <v-toolbar-title> 
         <qd-breadcrumbs :crumbs="[{to: '/settings', text:'Settings'}, {text: 'Keys', disabled: true }]">crumbs</qd-breadcrumbs> 
         </v-toolbar-title> 
         <v-btn @click="showKey" :disabled="openIndex === null">Show: {{ keys[openIndex] }} </v-btn>
           <v-btn @click="deleteKey" :disabled="openIndex === null">Delete</v-btn> 
	   <v-spacer></v-spacer>
   <v-btn @click="wipe" color="error">Delete ALL</v-btn>
	   </v-toolbar>

   <v-card-text>
   <v-expansion-panels>
    <v-expansion-panel v-for="key in keys" :key="key">
     <v-expansion-panel-header>{{key}}</v-expansion-panel-header> 
    <v-expansion-panel-content popout>

    <v-card>
        <v-card-text>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor 
        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
        ullamco laboris nisi ut aliquip ex ea commodo consequat.</v-card-text>
      </v-card>
     </v-expansion-panel-content>
     </v-expansion-panel>
     </v-expansion-panels> 
   </v-card-text>
   </v-card>
   <v-snackbar :value="true">Settings are currently only stored locally in the browser, using <code>localstorage</code></v-snackbar>
 </v-container>
 `,
      
  data(){return {
    keys: ["?"],
    openIndex: null
  }
  },
  methods:{
    wipe(){
       if(confirm("wipe localstorage? ")) Settings.clear();
    },
    
    showKey(){
      var key=this.keys[this.openIndex]
      console.log("index: ",key)
      Settings.getItem(key).then(v=>{console.log("ffff",v)})
      alert("show")
    },
    
    deleteKey(){
      var key=this.keys[this.openIndex]
      console.log("index: ",key)
      Settings.removeItem(key).then(v=>{console.log("ffff",v)})
      alert("show")
    }
  },
  
  created(){
    console.log("settings")
    Settings.keys()
    .then( v =>{
      console.log("keys: ",v)
     this.keys=v
    })
     
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/settings/settings.vue
const Showsettings=Vue.extend({template:` 
 <v-container fluid>
 <p>Settings are currently only stored locally in the browser, using <code>localstorage</code></p>
<v-switch label="Dark theme" v-model="$vuetify.theme.dark"></v-switch>
<v-switch label="Use service worker" v-model="serviceworker" @change="worker"></v-switch>
	 <v-card>
	   <v-card-title class="lime darken-1">Available settings</v-card-title>
	  
	 <v-card-text>
	   <v-list dense>
		   <v-list-item>
		      <router-link to="settings/ace">Editor</router-link>
		   </v-list-item>
		    <v-list-item>
		      <router-link to="settings/keys">Keys</router-link>
		   </v-list-item>
	   </v-list>
   </v-card-text>
   </v-card>
   
 </v-container>
 `,
      
  data(){return {
    keys: ["?"],
    showDev: false,
    serviceworker: true
  }
  },
  methods:{
    worker(){
      Settings.setItem('features/serviceworker',this.serviceworker)
      .then(v=>{
        console.log("worker",this.serviceworker)
      })
    }
  },
  
  created(){
    console.log("settings")
    Settings.keys()
    .then( v =>{
     this.keys=v
    })
   },
   
   beforeRouteEnter (to, from, next) {
     Promise.all([
      Settings.getItem('features/serviceworker'),
      Settings.getItem('settings/dark')
      ])
      .then( v =>{
        next(vm => {
                   console.log("got ",v)
                   vm.serviceworker = v[0];
                   vm.dark = v[1];
        })
          })
          
   }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/model.build/model.vue
const Model=Vue.extend({template:` 
 <v-container fluid>
    <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
      <span class="white--text">Generate <code>model.gen.xqm</code></span>      
    </v-card-title>
    <v-spacer></v-spacer>
     <v-btn color="primary" @click="submit()" :loading="waiting" :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid>
        <v-layout row wrap>
          
          <v-flex xs12>
            <v-text-field v-model="params.efolder" label="Folder containing model  definitions as xml"></v-text-field>
          </v-flex>
        
          <v-flex xs12>
            <v-text-field v-model="params.target" label="Path to xqm file to generate"></v-text-field>
          </v-flex>
           <v-flex xs12>
            <code>{{code}}</code>
          </v-flex>
        </v-layout>
  
      </v-container>
    </v-card-text>
 
      <v-snackbar v-model="snackbar.show" :timeout="6000" :success="snackbar.context === 'success'" :error="snackbar.context === 'error'">
      {{ snackbar.msg }}
      <v-btn dark text @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      params:{
			      efolder:"C:/Users/andy/git/vue-poc/src/vue-poc/models/entities",
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
  },
  created:function(){
    var task=this.task
    HTTP.get("tasks/model")
    .then(r=>{
      console.log(r.data.values);
      this.params=r.data.values;
      })
   },
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/runtask.vue
const Runtask=Vue.extend({template:` 
 <v-container fluid>
    <v-card>
    <v-toolbar>
    <v-toolbar-title>
       <v-breadcrumbs :items="crumbs">
		      <template slot="item" slot-scope="props">
		            <v-breadcrumbs-item :to="props.item.to" :disabled="props.item.disabled" :exact="true">
		            {{ props.item.text }}
		            </v-breadcrumbs-item>
		      </template>
      </v-breadcrumbs>
 
      </v-toolbar-title>  
    <v-spacer></v-spacer>
       <router-link :to="{name:'taskhistory', query:{task: task}}"><v-icon>history</v-icon></router-link>
   
     <v-btn color="primary" @click="submit()" :loading="loading" :disabled="loading">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
     </v-toolbar>
     
     <v-card-text v-if="id">
       {{ id }}
     </v-card-text>
     
    <v-card-text>
      <v-container fluid>
          <vp-paramform v-if="!loading" ref="params" :endpoint="'tasks/'+task"></vp-paramform>
      </v-container>
    </v-card-text>
      <v-snackbar v-model="snackbar.show" :timeout="6000" :success="snackbar.context === 'success'" :error="snackbar.context === 'error'">
      {{ snackbar.msg }}
      <v-btn dark text @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-card>
 </v-container>
 `,
      
  props:["task"],
  data:  function(){
    return {
			loading: false,
			snackbar: {show:false,msg:"",context:"success"},
			valid: false,
			id: null,
			crumbs: [{to:"/tasks", text:"Tasks"},{text: this.task, disabled: true}]
		  
    }
  },
  methods:{
    submit(){
      this.loading=true;
      this.$refs.params.submit()
      .then(r=>{
        this.loading= false
        this.id=r.data.id;
        this.snackbar= {show:true,
                        msg: r.data && r.data.msg, 
                        context:"success"
                        };
        console.log(r)
      })
      .catch(error=>{
        this.loading= false
        this.snackbar= {show:true,msg:"Problem",context:"error"}
        console.log(error);
      });
   }
  },
  watch:{
    id(v){
      this.$router.push({  query: { id: this.id }})
      },
      
      $route(vnew,vold){
         console.log("ROUTE",vnew,vold)    
         var id=this.$route.query.id
         this.id=id?id:null;
         if(vnew.query.url != vold.query.url) alert("gg")
      }
  },
  
  created:function(){
    if(this.$route.query.id) this.id=this.$route.query.id
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/taskhistory.vue
const Taskhistory=Vue.extend({template:` 
 <v-container fluid>
 <v-progress-linear v-if="loading" v-bind:indeterminate="true"></v-progress-linear>
 <v-card>
  <v-toolbar>
  <v-toolbar-title>
     <v-breadcrumbs>
            <v-breadcrumbs-item to="/tasks" :exact="true">
            Tasks
            </v-breadcrumbs-item>
        </v-breadcrumbs>
       </v-toolbar-title>  
     <v-spacer></v-spacer>
   
   <v-text-field prepend-icon="filter_list" label="Filter..." v-model="q" type="search" hide-details single-line @keyup.enter="setfilter" clearable></v-text-field>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="quodatum.task"></vp-entitylink>    
   </v-toolbar>
   
   <v-card-text>
    <v-data-table :headers="headers" :items="items" hide-default-footer :search="q" class="elevation-1">
    <template slot="items" slot-scope="props">
      <td>AA: <router-link :to="'tasks/' + props.item.to" v-text="props.item.title"></router-link></td>
      <td>{{ props.item.description }}</td>
    </template>
    <template slot="no-data">
      <v-alert :value="true" icon="warning">
        No matching items.
      </v-alert>
    </template>
  </v-data-table>
   </v-card-text>
    
    </v-card>
  
 </v-container>
 `,
      
  data(){
    return {
      items: [],
      loading: false,
      q: null,
      headers: [   
        { text: 'Task', value: 'title' },
        { text: 'Description', value: 'description' },
        ]
      }
  },
  methods:{
    getTasks(){
        this.loading= true;
        HTTP.get("tasks")
        .then(r=>{
		   this.items=r.data;
		   this.loading= false;
       })
    }
   },
  created(){
    this.getTasks()
   }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/tasks.vue
const Tasks=Vue.extend({template:` 
 <v-container fluid>
 <v-progress-linear v-if="loading" v-bind:indeterminate="true"></v-progress-linear>
 <v-card>
  <v-toolbar>
  <v-toolbar-title>
     <v-breadcrumbs :items="crumbs">
      <template slot="item" slot-scope="props">
            <v-breadcrumbs-item to="/tasks" :exact="true">
            Tasks
            </v-breadcrumbs-item>
        </template>
        </v-breadcrumbs>
       </v-toolbar-title>  
     <v-spacer></v-spacer>
   
   <v-text-field prepend-icon="filter_list" label="Filter..." v-model="q" type="search" hide-details single-line @keyup.enter="setfilter" clearable></v-text-field>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="quodatum.task"></vp-entitylink>    
   </v-toolbar>
   
   <v-card-text>
    <v-data-table :headers="headers" :items="items" hide-default-footer :search="q" class="elevation-1">
    <template v-slot:item.to="{ item }"> 
	      <td><router-link :to="item.to" :append="true" v-text="item.to"></router-link></td>
    </template>
    
    <template slot="no-data">
      <v-alert :value="true" icon="warning">
        No matching items.
      </v-alert>
    </template>
  </v-data-table>
   </v-card-text>
    
    </v-card>
  
 </v-container>
 `,
      
  data(){
    return {
      crumbs: [{to: "/tasks", text: "Tasks"}],
 
      items: [],
      loading: false,
      q: null,
      headers: [
    	{ text: 'Task', value: 'to' }, 
        { text: 'Title', value: 'title' },
        { text: 'Url', value: 'url' },
        { text: 'Description', value: 'description' },
        ]
      }
  },
  methods:{
    getTasks(){
        this.loading= true;
        HTTP.get("tasks")
        .then(r=>{
		   this.items=r.data;
		   this.loading= false;
       })
    }
   },
  created(){
    this.getTasks()
   }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/tasks/tasks1.vue
const Tasks1=Vue.extend({template:` 
 <v-container fluid>
 <v-progress-linear v-if="loading" v-bind:indeterminate="true"></v-progress-linear>
 <v-card>
  <v-toolbar>
  <v-toolbar-title>
    <qd-breadcrumbs :crumbs="[{to: '/tasks', text:'Tasks'}, {text: task, disabled: true} ]">crumbs</qd-breadcrumbs> 
       </v-toolbar-title>  
     <v-spacer></v-spacer>
   
   <v-spacer></v-spacer>
   <vp-entitylink entity="quodatum.task"></vp-entitylink>    
   </v-toolbar>
   
   <v-card-text>
  
   <h1>{{ task }} </h1>
   <ul><li>
   <router-link :to="{path: 'run', append:true }"> <v-icon>folder</v-icon>Run</router-link>
   </li>
   <li>
   <router-link :to="{name: 'edit',  query:{apple: task} }"> <v-icon>folder</v-icon>Edit</router-link>
   </li>
   <li>
      <router-link :to="{name:'taskhistory', query:{task: task}}"><v-icon>history</v-icon>History</router-link>
     </li>
     </ul>
   </v-card-text>
    
    </v-card>
  
 </v-container>
 `,
      
	 props:["task"],
  data(){
    return {
      crumbs: [{to: "/tasks", text: "Tasks"},
    	       { text: this.task}],
 
      items: [],
      loading: false,
      q: null,
      headers: [
    	{ text: 'Task', value: 'to' }, 
        { text: 'Title', value: 'title' },
        { text: 'Description', value: 'description' },
        ]
      }
  },
  methods:{
    getTasks(){
        this.loading= true;
        HTTP.get("tasks")
        .then(r=>{
		   this.items=r.data;
		   this.loading= false;
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
 <v-container fluid>
    <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
      <span class="white--text">compile</span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn color="primary" @click="submit()" :loading="waiting" :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid>
        <v-layout row wrap>   
          <v-flex xs12>
            <v-text-field v-model="params.proj" label="vue project to compile"></v-text-field>
          </v-flex>
        </v-layout>
         <v-layout row wrap>
           <v-flex xs12>
            <code>{{code}}</code>
          </v-flex>
        </v-layout>
  
      </v-container>
    </v-card-text>
   
      <v-snackbar v-model="snackbar.show" :timeout="6000" :success="snackbar.context === 'success'" :error="snackbar.context === 'error'">
      {{ snackbar.msg }}
      <v-btn dark text @click="snackbar.show = false">Close</v-btn>
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
         Settings.setItem('tasks/vuecompile',this.params)
      })
      .catch(error=>{
        this.waiting=false
        this.snackbar={show:true,msg:"Problem",context:"error"}
        console.log(error);
      });
   }
  },
   created: function () {
    Settings.getItem('tasks/vuecompile')
    .then((v)=>{
      if(v)this.params=v
    })
  },
  computed:{
    code(){return 'code here'}
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/test-html.vue
const Testhtml=Vue.extend({template:` 
  <v-container fluid>
  <v-card>
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title>
     <v-chip>todo</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  
    </v-toolbar>
     <v-progress-linear v-if="busy" v-bind:indeterminate="true"></v-progress-linear>
    <v-card-text v-if="!busy" v-html="report" @click.capture="onClick($event)"></v-card-text>
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
      HTTP.get("test/html")
      .then(r=>{
        this.busy=false
        this.report=r.data
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    },
    onClick(event){
      console.log("event",event);
      var isA= "a"== event.originalTarget.localName
     
      if(isA) {
       // alert("stop this"+ event.originalTarget.hash);
        console.log("tar",event.originalTarget.hash,document.querySelector(event.originalTarget.hash));
        event.preventDefault();
          this.$router.push({"hash":event.originalTarget.hash});
        //  this.$vuetify.goTo(event.originalTarget.hash, { duration: 600,   offset: -200, easing: 'easeInOutCubic'});

      }
    }
  },
  created:function(){
    console.log("reports")
    this.get()
  }
    }

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/thumbnail/thumbnail.vue
const Thumbnail=Vue.extend({template:` 
 <v-container fluid>
 <v-stepper v-model="step" non-linear>
  <v-stepper-header>
      <v-stepper-step step="1" :complete="step > 1" editable>Image source</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="2" :complete="step > 2" editable>Thumbnail parameters</v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="3" editable>Thumbnail</v-stepper-step>
    </v-stepper-header>
  <v-stepper-items>
  <v-stepper-content step="1" non-linear>
    <v-card class="lime lighten-1 z-depth-1 mb-5" height="200px">
    <v-card-text>
	    <v-text-field name="url" label="Image Url" hint="http:...??" v-model="image" required></v-text-field>
     </v-card-text>
    <v-card-actions>
    <v-spacer></v-spacer>
        <v-btn color="primary" @click="step = 2">Next</v-btn>
        </v-card-actions>
          </v-card>
  </v-stepper-content>
  
  <v-stepper-content step="2" non-linear>
  
    <v-card class="lime lighten-1 z-depth-1 mb-5">
    <v-toolbar dense>
		<v-btn text @click="step -= 1">Back</v-btn>
		<v-spacer></v-spacer>
	    <v-btn color="primary" @click="validate()">Validate</v-btn>
	    <v-spacer></v-spacer>
	     <v-btn color="primary" @click="step = 3">Next</v-btn>  
		</v-toolbar>
		<v-flex xs12 style="height:400px" fill-height>
	    <vue-ace editor-id="editorA" :content="taskxml" mode="xml" wrap="true" v-on:change-content="onChange" min-lines="7"></vue-ace>
        </v-flex>
		</v-card>
  
    
  </v-stepper-content>

  <v-stepper-content step="3" non-linear>
    <v-card :loading="loading" class="lime lighten-1 z-depth-1 mb-5">
     <v-card-actions>
    <v-btn text @click="step -= 1">Back</v-btn>
    <v-spacer></v-spacer>
     <v-btn color="primary" @click="go()">refresh</v-btn>
     <div v-if="elapsed"> (took {{ elapsed }}ms.)</div>
     <v-spacer></v-spacer>
     </v-card-actions>
    <v-card-text>
    <v-layout style="height:300px" fill-height>
    <v-flex xs6>
    <div>Source</div>
    <img :src="image" class="contain" style="width:100%; height:100%;">
    </v-flex>
    <v-flex xs6>
    <div>Thumbnail</div>
    <img ref="imgResult" class="contain" style="width:100%; height:100%;object-position: 50% 50%;">
    </v-flex>
    </v-layout>
    </v-card-text>
   
    </v-card>
    
     
  </v-stepper-content>
  </v-stepper-items>
</v-stepper>
 </v-container>
 `,
      
  data(){
    return {
      image:"https://picsum.photos/id/123/500/700",
      step: 1,
      elapsed: null,
      taskxml:"<task></task>",
      items:[
        { src: 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Lycidae-Kadavoor-2017-05-22-001.jpg'},
        { src: 'https://picsum.photos/id/123/500/700' }
        ],
        loading: false
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
    	  var target= this.$refs.imgResult;
    	  var _start = performance.now();
    	  this.loading = true
    	  fetch("/vue-poc/api/thumbnail",
        		  {
    		      method: 'POST',
    		      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    		      body:  Qs.stringify({task: this.taskxml,url:this.image})
        		  }
        		  ).then(function(response) {
    		  return response.blob();
    		}).then(myBlob=> { 			
    		      target.src = URL.createObjectURL(myBlob);
    		      this.elapsed=Math.floor(performance.now() - _start);
    		      this.loading = false
    		});	  
      }
  },
  
  beforeRouteEnter (to, from, next) {
    Promise.all([Settings.getItem('images/thumbtask')
                 ])
    .then(function(values) {
      next(vm => {
          vm.taskxml = values[0];
          })
          })
    },
     
  beforeRouteLeave (to, from, next) {
    // called when the route that renders this component is about to
    // be navigated away from.
    // has access to `this` component instance.
    Settings.setItem('images/thumbtask',this.taskxml);
    next(true);
  },

}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/users/users.vue
const Users=Vue.extend({template:` 
 <v-container fluid>
   <qd-table :headers="headers" data-uri="data/basex.user" entity="user" no-data-msg="Nothing found">
    <template slot="items" slot-scope="props">
      <td>
        <v-checkbox primary hide-details v-model="props.selected"></v-checkbox>
      </td>
      <td>{{ props.item.name}}</td>
      <td>{{ props.item.permission }}</td>
    </template>
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
        { text: 'Name', value: 'name'},
        { text: 'Permission', value: 'permission' }
      ] 
      }
  },
 
created:function(){
  console.log("users")
}
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/validate/validate.vue
const Validate=Vue.extend({template:` 
  <v-container fluid>
    <v-card>
     <v-toolbar class="orange">
        
          
           <v-btn @click="submit" :loading="loading" :disabled="false"><v-icon>play_circle_outline</v-icon>validate</v-btn>
             <span v-text="elapsed">?</span>ms.
            <v-spacer></v-spacer>
            
              <v-menu offset-y left>
               <template v-slot:activator="{ on }">
                       <v-btn icon v-on="on"><v-icon>settings</v-icon></v-btn>         
               </template>
              <v-card>
              <v-toolbar class="green">
                  <v-card-title>@TODO.......</v-card-title>
                  </v-toolbar>
                <v-card-text>
                stuff
                </v-card-text>
                </v-card>
              </v-menu>
          </v-toolbar>
    <v-card-text v-resize="onResize" style="height:100px" ref="auto">
      <v-container fluid>
        
          <v-layout row wrap> 
          <v-flex>
          <vp-paramform ref="params" endpoint="validate"></vp-paramform>
          </v-flex>
         
          <v-flex green fill-height>
          <vp-validationreport :report="result"></vp-validationreport>
          </v-flex>
          </v-layout>
      </v-container>
    </v-card-text>

    </v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      loading: false,
      elapsed: null,
      height: null,
      result: null
    }
  },
  methods:{
    onResize(){
      //console.log("EL",this.$el);
      var el=this.$refs["auto"];
      var h=window.innerHeight - el.getBoundingClientRect().top -32;
      var h=Math.max(1,h) ;
      //console.log("resize h",h,el.style)
      el.style.height=h +"px"; 
    },
    submit () {    
      if (this.$refs.params.valid()) {
        // Native form submission is not yet supported
        this.validate()
      }
    },
    clear () {
      this.$refs.params.clear();
    },
    validate(){    
      this.loading=true
      this.start = performance.now();
      var params=this.$refs.params.submit();
      HTTP.post("validate",Qs.stringify(params))
      .then(r=>{
       console.log(r);
       this.loading=false
       if(r.data.rc==0){
         this.result=r.data
       }else{
         this.result=r.data
       }
      })
      .catch(r=> {
        console.log("error",r.response.data)
       
        this.result=r.message + ": "+ r.config.url + "\n"+ r.response.data
        this.loading=false
      });
    }
  }
}

      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/websocket/websocket.vue
const Websocket=Vue.extend({template:` 
 <v-container fluid>
 <v-card>
 <v-toolbar>
 <v-toolbar-title>Web socket <a href="https://github.com/nathantsoi/vue-native-websocket">Git</a></v-toolbar-title>
 <v-spacer></v-spacer>
 <v-btn @click="send">Sent</v-btn>
 </v-toolbar>
 <v-card-text>
     <p>web socket</p>
  </v-card-text>
    </v-card>
    
 </v-container>
 `,
      
  data:  function(){
    return {
      reply: null
      }
  },
  methods:{
   
    
    send(){
      this.$socket.send('some data');
    }
  },
  mounted: function(){
   //this.$connect();
   this.$options.sockets.onmessage = (data) => this.reply=data;
   }
  
}
      );
      
// src: file:///C:/Users/andy/git/vue-poc/src/vue-poc/features/xslt/transform.vue
const Transform=Vue.extend({template:` 
 <v-container fluid>
<v-card>
     <v-toolbar class="orange">
          <v-btn @click="transform" :loading="loading" :disabled="loading"><v-icon>play_circle_outline</v-icon>Run</v-btn>
          <span v-text="elapsed"></span>ms. Height: 
          <span v-text="height"></span>
            <v-spacer></v-spacer>
           <v-btn-toggle v-model="showOptions" multiple>
           <v-icon>visibility</v-icon>
              <v-btn text value="result">
                <span :class="resultValid?'':'red'">Result</span>
              </v-btn>
              <v-btn text value="xml">
               <span :class="xmlValid?'':'red'">XML</span>
              </v-btn>
              <v-btn text value="xslt">
                 <span :class="xslValid?'':'red'">XSLT</span>
              </v-btn>
            </v-btn-toggle>
              <v-menu offset-y left>
               <template v-slot:activator="{ on }">
                  <v-btn icon dark v-on="on"><v-icon>settings</v-icon></v-btn>
               </template>
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
          
    <v-card-text class="amber">
       <qd-autoheight>

      <v-flex v-if="showOptions.includes('result')" fill-height xs12>
        <vue-ace :content="result" mode="xml" wrap="true" :settings="aceSettings"></vue-ace>
      </v-flex>
 
      <v-flex v-if="showOptions.includes('xml')" fill-height>
	      <vue-ace :content="xml" mode="xml" wrap="true" v-on:change-content="v => this.xml=v" v-on:annotation="a => this.xmlValid=a.error===0 &amp;&amp; a.warning===0" :settings="aceSettings"></vue-ace>
     </v-flex>
     
       <v-flex v-if="showOptions.includes('xslt')" fill-height>
	       <vue-ace :content="xslt" mode="xml" wrap="true" v-on:change-content="v => this.xslt=v" v-on:annotation="a => this.xslValid=a.error===0 &amp;&amp; a.warning===0" :settings="aceSettings"></vue-ace>
      </v-flex>
      
     </qd-autoheight>
      </v-card-text>
      </v-card>
 </v-container>
 `,
      
  data:  function(){
    return {
      xml:"<foo />",
      xmlValid: true,
      xslt:'<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">\n<xsl:mode on-no-match="shallow-copy" /></xsl:stylesheet>',
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
  }, 
  beforeRouteEnter (to, from, next) {
    Settings.getItem('settings/ace')
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
      return { selector: to.hash, behavior: 'smooth',offset: {x:0, y: 80} }

    } else {
      return { x: 0, y: 0 }
    }
  },
  routes: [
    { path: '/', component: Home, meta:{title:"Home"} },
    { path: '/session', component: Session ,meta: {title:"Session"}},
 
    {path: '/images', component: { template: '<router-view/>' }, 
    	children: [
    {path: '', redirect: 'item' },		
    { path: 'item', name:'images', component: Images, meta:{title: "Images"} },
    { path: 'report', name:"image-reports", component: Report, props: true, meta:{title: "Image report"}},
    { path: 'item/:id', name:"image",component: Image, props: true, meta:{title: "Image details"}},
    { path: 'thumbnail', component: Thumbnail, meta:{title:"Thumbnail generator"} },
    { path: 'keywords', component: Keywords, meta:{title:"Image keywords"} },
    { path: 'dates', component: Dates, meta:{title:"Image dates"} },
    { path: 'people', component: People, meta:{title:"Image people"} }
    ]},
    
    
    { path: '/documentation', component: Documentation, meta:{title:"documentation"} },
    
    { path: '/logdate', component: Basexlogdate, meta:{title:"log files"} },
    { path: '/logdate/:date', component: Basexlogdate1, props:true, meta:{title:"log files"} },
    
    { path: '/entity', component: Entity, meta:{title:"Entities"} },
    { path: '/entity/:entity', component: { template: '<router-view/>' }
          ,children: [
        	  {
                  path: '',
                  component: Entity1, props: true, meta:{title:"Entity"} 
                }, 
                { 
                	path: 'data', component: Entity1data, props: true, meta:{title:"Entity data"}   
                }
          ]
    }, 
    
    { path: '/namespace', component: Namespace, meta:{title:"Namespaces"} },
    { path: '/namespace/item', component: Namespace1, meta:{title:"Namespace"} },
    
    { path: '/select', component: Select, meta:{title:"Select"} },
    { path: '/search', component: Search, meta:{title:"Search"} },
    { path: '/tabs', name: "multi-edit", component: Tabs,meta:{title:"tab test"} },
  
    { path: '/edit', name: "edit",component: Edit,meta:{title:"Ace editor"} },
 
    { path: '/files', component: Files,meta:{title:"File system"},props:{protocol:"webfile"} },
    { path: '/database', component: Files,meta:{title:"Databases"},props:{protocol:"xmldb"} },
    { path: '/login', component: Login,meta:{title:"login"} },
    { path: '/settings', component: { template: '<router-view/>' }
         ,children: [
           {
             path: '',
             component: Showsettings, meta:{title:"Settings", requiresAuth:true}
           },
          {
            path: 'keys',
            component: Keys, 
            meta:{title:"keys"} 
          },
          {
            path: 'ace',
            component: Acesettings, 
            meta:{title:"Editor settings"} 
          }
          ]
    },
    
    { path: '/server', component: { template: '<router-view/>' }
    ,children: [
      {
        path: '',
        component: Settings, 
        meta:{title:"Settings ***", requiresAuth:true }
      },
      { 
        path: 'logs', name:"logs",
        component: Log, 
        meta:{title:"Server logs"}
      },
      { 
        path: 'logs/add', name:"addlog",
        component: Logadd, 
        meta:{title:"add Server logs"}
      },
      
      { path: 'jobs', name:"jobs", component: Jobs, meta:{title:"Jobs running"} },
      { path: 'jobs/:job',  name:"jobShow", component: Job, props: true, meta:{title:"Job Status"} },
      { path: 'services',  component: Services, meta:{title:"Services"} },
      { path: 'upload', component: Upload,meta:{title:"Upload"} },
     
      { path: 'settings', component: Basexsettings,meta:{title:"BaseX settings"} },
      { path: 'ping', component: Ping,meta:{title:"Ping"} },
      { path: 'dicetest', component: Dicetest,meta:{title:"Dice test"} },
      { path: 'users', component: Users,meta:{title:"Users"} },
      { path: 'repo', component: Repo,meta:{title:"Repository"} },
     ]
    },
    { path: '/history', component: { template: '<router-view/>' }
    ,children: [
      { path: 'files', component: Filehistory, meta:{title: "File History"} },
      { path: 'tasks', name: 'taskhistory', component: Taskhistory, meta:{title: "Task History"} },
      ]
    },
    { path: '/labs', component: { template: '<router-view/>' }
    ,children: [
      { path: 'scratch', component: Scratch, meta:{title:"scratch"} },
      { path: 'svg', component: Svg, meta:{title:"SVG"} },
      { path: 'svg2', component: Svg2, meta:{title:"SVG2"} },
      { path: 'timeline', component: Timeline,meta:{title:"timeline"} },
      { path: 'tree', component: Tree, meta:{title:"tree"} },
      { path: 'tree2', component: Tree2, meta:{title:"tree2"} },
      { path: 'form', component: Brutusin, meta:{title:"Form demo"} },
      { path: 'websocket', component: Websocket,meta:{title:"Web socket"} },
      { path: 'markdown', component: Markdown,meta:{title:"Markdown"} },
      ]
    },
    
    { path: '/puzzle', component: Puzzle, meta:{title:"Jigsaw"} },
    { path: '/html', component: Testhtml, meta:{title:"HTML test"} },
    
    { path: '/transform', component: Transform, meta:{title:"XSLT2 Transform"} },
    { path: '/validate', component: Validate, meta:{title:"Validate"} },
    
    { path: '/eval', component: Eval, meta:{title:"Evaluate XQuery"} },
    { path: '/eval/:id', component: Evalid, props: true, meta:{title:"Run details"} },
    
    { path: '/logs', component: Log, meta:{title:"Server logs"} },
    
    { path: '/tasks', component: { template: '<router-view/>' } ,  children:[
		    { path: '', component: Tasks, meta:{title:"Runnable tasks"} },
		    { path: 'model', component: Model, meta:{title:"build model"} },
		    { path: 'vuecompile', component: Vuecompile, meta:{title:"vue compile"} },
		    { path: ':task',  props: true, component: { template: '<router-view/>' },
		    	children:[
		        {path:"",  props: true, component: Tasks1 },
		    	{path: "run", component: Runtask, props: true,  meta:{title:"Run task"} },
		    	]}
    ]},  
   
   
    { path: '/map', component: Leaflet,meta:{title:"map"} },     
    
    { path: '/about', component: { template: '<router-view/>' }  ,children:[
      {path: '', component: About, meta:{title:"About Vue-poc"} },
      {path: 'package', component: Package, meta:{title:"Javascript components"} },
      {path: 'routes', component: Routes, meta:{title:"Routes"} },
      {path: 'routes2', name: 'routes', component: Routes2, meta:{title:"Routes2"} },
      {path: 'vue-cmps', component: VueComps, meta:{title:"Vue components"} },
   ]},
   
   { path: '*', component: Notfound, meta:{title:"Page not found"} }
  ],
});
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

router.beforeEach((to, from, next) => {
  //console.log("before: ",to)
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    console.log("matched: ",Auth)
    if ("admin"!=Auth.role) {
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
 <v-app app id="app">
  <v-navigation-drawer stateless v-model="showNotifications" right :disable-route-watcher="true" app width="500">
    <vp-notifications :show-notifications.sync="showNotifications"></vp-notifications>
  </v-navigation-drawer>
  
 <v-navigation-drawer app :mini-variant.sync="mini" v-model="drawer" :clipped="$vuetify.breakpoint.lgAndUp">
    
  <v-list class="pa-0">

          <v-list-item tag="div">
            <v-list-item-avatar>
              <v-btn icon @click="session">
              <v-avatar size="36">
              <img src="/vue-poc/ui/quodatum.gif" alt="Vue-poc logo">
              </v-avatar>
              </v-btn>
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title>Vue PoC</v-list-item-title>
            </v-list-item-content>
            <v-list-item-action>
              <v-btn icon @click.stop="mini = !mini">
                <v-icon>chevron_left</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>

      </v-list>
    <qd-navlist2 :items="items" :mini="mini"></qd-navlist2>
    <router-view name="helper" class="view ma-3"></router-view>
 </v-navigation-drawer>
  
 <v-app-bar app :clipped-left="$vuetify.breakpoint.lgAndUp" color="blue darken-3" dense dark>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
  <v-toolbar-title class="hidden-sm-and-down">
    
  {{$route.meta.title}}</v-toolbar-title>
   
 
 
  <v-spacer></v-spacer>
  <v-toolbar-items>
    <qd-search></qd-search>
  </v-toolbar-items>
  <v-spacer></v-spacer>
  
   <v-menu left transition="v-fade-transition">
   <template v-slot:activator="{ on }">
      <v-btn dark icon v-on="on">
        {{$auth.user}}
      </v-btn>
    </template>   
          <v-list>
              <v-list-item to="/session" ripple>
                <v-list-item-title>Session</v-list-item-title>
              </v-list-item>
              <v-list-item @click="logout()">
                <v-list-item-title>logout</v-list-item-title>
              </v-list-item>
               <v-list-item>
                <v-list-item-title>permission: {{$auth.permission}}</v-list-item-title>
              </v-list-item>
            <v-list-item>
                <v-list-item-title>$route.path: {{$route.path}}</v-list-item-title>
              </v-list-item>
          </v-list>
      </v-menu>
      
       <v-btn @click.stop="showNotifications = ! showNotifications" icon text title="Notifications">
       <v-badge overlap color="orange">
      <span slot="badge" v-if=" $notification.unseen">{{ $notification.unseen }}</span>
       <v-icon>notifications</v-icon>
       </v-badge>
   </v-btn>
    <vp-favorite :frmfav.sync="frmfav"></vp-favorite>
    <v-menu bottom left min-width="300px">
	       <template v-slot:activator="{ on }">
	         <v-btn icon v-on="on">
              <v-icon>more_vert</v-icon>
            </v-btn>
           </template>
            <v-list>
              <v-list-item>
                <v-list-item-title><qd-fullscreen> Full screen</qd-fullscreen></v-list-item-title>
              </v-list-item>
              <v-list-item>
                <v-list-item-title>Dark theme</v-list-item-title>
                 <v-list-item-action><v-switch v-model="$vuetify.theme.dark"></v-switch> </v-list-item-action>
              </v-list-item>
              <v-divider></v-divider>
               <v-list-item>
               <v-list-item-title>Server hot load:</v-list-item-title> 
                <v-list-item-action><v-btn @click="init">.init</v-btn></v-list-item-action>
              </v-list-item>
            </v-list>
        </v-menu>

</v-app-bar>
 
 <v-main> 
 <v-alert color="error" value="true" dismissible v-model="alert.show">
      <pre style="overflow:auto;">{{ alert.msg }}</pre>
    </v-alert>   
    <transition name="fade" mode="out-in">
      <router-view class="view ma-3"></router-view>
      </transition>
  </v-main>

</v-app>
 `,
      
  router,
  store,
  vuetify: new Vuetify({ theme: {dark: false},
	                     icons: {iconfont: 'md'}
  					}),
  data:function(){return {

    searchItems:[],
    si: '',
    items2:["todo","set","search"],
    status: {},
    drawer: true,
    showNotifications: false,
    mini: false,
    alert: {show:false,msg:"Hello"},
    frmfav: false,
  
    items: [
      {href: '/',text: 'Dashboard', icon: 'dashboard'    },
      {
        icon: 'input',
        text: 'Actions' ,
        model: false,
        children: [
      {href: '/eval',text: 'Query',icon: 'play_circle_outline'},
      {href: '/edit',text: 'Edit',icon: 'mode_edit'},
      {href: '/tabs',text: 'Tabs',icon: 'switch_camera'},  
      {href: '/validate',text: 'Validate',icon: 'playlist_add_check'},
      {href: '/transform',text: 'XSLT Transform',icon: 'forward'},
      
      {href: '/history/tasks',text: 'history',icon: 'history'}
      ]},
      {
        icon: 'folder_open',
        text: 'Collections' ,
        model: false,
        children: [
       {href: '/database', text: 'Databases',icon: 'developer_mode' },
       {href: '/files', text: 'File system',icon: 'folder' },
   
       {href: '/tasks',text: 'Tasks',icon: 'update'},
       {href: '/logdate',text: 'XML logs',icon: 'dns'},
       {href: '/history/files',text: 'history',icon: 'history'}
      ]},
      {
        icon: 'memory',
        text: 'Models' ,
        model: false,
        children: [             
          {href: '/entity', text: 'Entities',icon: 'redeem' },
          {href: '/documentation', text: 'Documentation',icon: 'library_books' },
          {href: '/namespace', text: 'Namespaces',icon: 'label' },
      ]},
      
      {
        icon: 'cast_connected',
        text: 'Server' ,
        model: false,
        children: [
          {href: '/server/jobs',text: 'Running jobs',icon: 'dashboard'},
          {href: '/server/services',text: 'Services',icon: 'dashboard'},   
          {href: '/server/logs',text: 'Server logs',icon: 'dns'},
          {href: '/server/users',text: 'Users',icon: 'supervisor_account'},
          {href: '/server/repo',text: 'Server code repository',icon: 'local_library'},
        
          {href: '/server/upload',text: 'Upload to server',icon: 'file_upload'},
          {href: '/server/ping',text: 'Ping',icon: 'update'},
          {href: '/server/dicetest',text: 'Dice performance',icon: 'update'},
          {href: '/server/settings',text: 'Server settings',icon: 'settings_applications'}
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
      {href: '/html',text: 'HTML test',icon: 'receipt'},
      {href: '/select',text: 'Select',icon: 'extension'},
      {href: '/puzzle',text: 'Puzzle',icon: 'extension'}
      ]},
      {
        icon: 'toys',
        text: 'Labs' ,
        model: false,
        children: [
      {href: '/labs/scratch',text: 'Scratch pad',icon: 'filter_frames'},
      {href: '/labs/form',text: 'Forms',icon: 'subtitles'  },
      {href: '/labs/timeline',text: 'Time line',icon: 'timelapse'},
      {href: '/labs/svg',text: 'SVG',icon: 'extension'},
      {href: '/labs/svg2',text: 'SVG2',icon: 'extension'},
      {href: '/labs/tree',text: 'Tree',icon: 'nature'},
      {href: '/labs/tree2',text: 'Tree 2',icon: 'nature'},
      {href: '/labs/websocket',text: 'Web socket',icon: 'swap_calls'},
      {href: '/labs/markdown',text: 'Markdown',icon: 'receipt'},
      ]},
      {href: '/settings',text: 'Settings',icon: 'settings'  },
      {href: '/about',text: 'About' , icon: 'help'    }, 
    ]

  }},
  methods: {
      init(){
        HTTP.get("../../.init");
      },

      session(){
        this.$router.push({path: '/about'})
      },
      
      logout(){
        HTTP.get("logout").then(r=>{
          this.$auth.role=null;
          this.$auth.user="guest";
          this.$router.push({path: '/'});
        }) 
      },
      showAlert(msg){
        this.alert.msg=moment().format()+" "+ msg
        this.alert.show=true
      }
  },
  watch: {
	    showNotifications: function (val) {
	      console.log("showNotifications",val);
	      if(!val)this.$notification.unseen=0;
	    },
	   
    },
    
  created(){
    console.log("create-----------", this.items);
		
    var that=this
    window.addEventListener('error', function (err) {
      var msg=JSON.stringify(err)
      that.showAlert("vue error:\n"+msg);
      //alert('window.onerrora-\n' + err.message);
  });
    Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
        console.log('[Global Error Handler]: Error in ' + info + ': ' + err);
        var msg=JSON.stringify(err)
        that.showAlert("vue error:\n"+msg)
        //alert("vue error");
   };
   
// Add a response interceptor
   HTTP.interceptors.response.use(
   (response)=> {
     // Do something with response data
     return response;
   },
   (error) =>{
     // interupt restxq single
     console.log("HTTP.interceptors.response.use ",error)
     if (!error.response) {
    // network error
       this.showAlert("network error\n"+"server down")
  }else if(460 != error.response.status)this.showAlert("http error:\n"+error.response.data)
     return Promise.reject(error);
   });
   
    HTTP.get("status")
    .then(r=>{
      //console.log("status",r)
      this.$auth=Object.assign(this.$auth,r.data);
      console.log("AFTER: ",this.$auth);
      //this.$forceUpdate()
    })
    EditTabs.restore();
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
      'X-Custom-Header': 'vue-poc'
    },
    paramsSerializer: function(params) {
      return Qs.stringify(params)
    }
  };

// time requests

// Add a response interceptor
axios.interceptors.response.use(function (response) {
    // Do something with response data
  //console.log("AXIOS",response);
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
  if( response && response.config && response.config.qdStartTime){
    var s=Math.floor(performance.now() - response.config.qdStartTime);
    var c=response.config;
    var url=response.config.url + "?" + c.paramsSerializer(c.params);
    //console.log("interceptors time:",s, response.config);
    var b=`<a href="${url}" target="vp-notification" >${url}</a>`
    Notification.add({html: b, elapsed: s});
  }
  return response;
});


// errors hidden
const HTTPNE = axios.create(AXIOS_CONFIG);
const axios_json={ headers: {accept: 'application/json'}};


// Settings read and write list clear
localforage.config({
  name: 'vuepoc'
});
// https://vuejs.org/v2/guide/state-management.html
var Settings = {
    debug: false,
    defaults:{
      
      "settings/ace": {
                      theme: "github",
                      themeDark: "chaos",
                      keybinding: "ace",
                      fontsize: 16,
                      enableSnippets:true,
                      enableBasicAutocompletion:true,
                      enableLiveAutocompletion:true
                      },
       "settings/dark": false,
       "features/serviceworker": false,
       "edit/items":[
         {name:"web.txt", id:"1", mode:"text", dirty: false, 
           text:`Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi 
ut aliquip ex ea commodo consequat.`},
       
         {name:"shopping.xq", id:"2", mode: "xquery" ,dirty: false,
           text:`let $a:=1 to 5
return $a   `},
      
         {name:"videos.xml", id:"3", mode:"xml",dirty: false, uri: "xmldb:/vue-poc/aaa/bca/videos.xml",
           text:`<foo version="1.0">
  <node>hello</node>
</foo>`}
       ],
       "edit/currentId": "?",
       "images/thumbtask":`
<thumbnail>
    <size width="200" height="200"/>
    <filters>             
        <colorize color="green" alpha=".5"/>      
        <caption position="CENTER">Some Text here</caption>
        <rotate angle="15"/>
        <canvas height="300" width="300" position="TOP_LEFT" color="yellow"/> 
    </filters>
    <output format="gif"/>         
</thumbnail>
`,
      "edit/query": "todo edit/query"
    },
    
    getItem (key) {
      if (this.debug) console.log('getItem',key);
      return localforage.getItem(key)
        .then(value => {
          value=value?value:this.defaults[key];
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
   
   removeItem (key) {
     if (this.debug) console.log('deleteItem',key);
     return localforage.removeItem(key) 
     .then(value => {
        console.log('deleted ',key);
       
     }).catch(err => {
       console.log('delete failed');
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

Vue.component('treeselect', VueTreeselect.Treeselect);

var sockhost=('https:'==window.location.protocol?'wss:':'ws:')+'//'+ window.location.host +'/ws';
//Vue.use(VueNativeSock.default, sockhost);
//console.log("SOCK UP",VueNativeSock,sockhost);




//function install (Vue) {
//  Vue.component('form-schema', window["vue-json-schema"].default);
//};
//Vue.use({ install: install });
var EditTabs=new Vue(GEditTabs)
Vue.use(Vuetify);
Vue.use(VueMarkdown);
new Vuepoc().$mount('#app')

