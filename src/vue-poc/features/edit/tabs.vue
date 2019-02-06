<!DOCTYPE html>
<template id="tabs">
<div> 
  <v-toolbar   tabs dense>
     <v-toolbar-items>
	      <vp-selectpath :frmfav.sync="showadd" @selectpath="add"> <v-icon>add_circle</v-icon></vp-selectpath>
	      <v-btn icon @click="openUri"><v-icon>insert_drive_file</v-icon></v-btn>
      </v-toolbar-items>
      <v-toolbar-title>{{ curIndex   }} </v-toolbar-title>
      
       <v-menu v-if="active"  left  transition="v-fade-transition" >
       <v-chip label small slot="activator" >{{ active.mode }}</v-chip>
          <v-list dense>
                <v-list-tile v-for="type in $MimeTypes.list()"  :key="type.name">
                <v-list-tile-title v-text="type.name" @click="setMode(type)"></v-list-tile-title>
              </v-list-tile>         
          </v-list>         
      </v-menu>
      
       <v-menu v-if="active" left  transition="v-fade-transition" >
        <v-btn   slot="activator" >Action<v-icon>arrow_drop_down</v-icon></v-btn>
          <v-list dense>
          <v-subheader >Actions</v-subheader>
                <v-list-tile @click="format()" >
                <v-list-tile-title  >Format</v-list-tile-title>
              </v-list-tile>
               <v-list-tile  @click="validate()" >
                <v-list-tile-title >Validate</v-list-tile-title>
              </v-list-tile>             
          </v-list>         
      </v-menu>
      <v-btn @click="add">*{{  EditTabs.nextId }}</v-btn>
     
       <v-spacer></v-spacer>
       
         <v-tooltip top>
			     <v-chip   @click="acecmd('goToNextError')" slot="activator" >
			            <span   class="red " >{{annotations && annotations.error}}</span>
			            <span  class="yellow ">{{annotations && annotations.warning}}</span>   
			            <span  class="green ">{{annotations && annotations.info}}</span>
			 
			           <v-avatar>
			              <v-icon black >navigate_next</v-icon>
			           </v-avatar>
			      </v-chip>
			      <span>Annotations: Errors,Warning and Info</span>
			   </v-tooltip>
   
        <v-menu  left  transition="v-fade-transition">
      <v-btn  :disabled="!active" icon slot="activator" title="display settings">
        <v-icon>playlist_play</v-icon>
      </v-btn>
     
      <v-list dense>
           <v-subheader>Display settings</v-subheader>
         
           <v-list-tile @click="togglefold"  avatar >
             <v-list-tile-avatar>
                   <v-icon >vertical_align_center</v-icon>
              </v-list-tile-avatar>
              <v-list-tile-title  >Toggle folds</v-list-tile-title>
           </v-list-tile>
           
           <v-list-tile @click="wrap=!wrap"  avatar >
             <v-list-tile-avatar>
                   <v-icon >wrap_text</v-icon>
              </v-list-tile-avatar>
              <v-list-tile-title  >Soft wrap</v-list-tile-title>
           </v-list-tile>
             <v-divider></v-divider>
              <v-subheader>Help</v-subheader>
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
    
    <v-menu>
          <v-btn icon  slot="activator" ><v-icon>view_quilt</v-icon></v-btn>
          <v-list dense>
          <v-subheader >View</v-subheader>
           <v-list-tile @click="showInfo = false" >
		           <v-list-tile-action>
		              <v-icon >mode_edit</v-icon>
		            </v-list-tile-action>
                 <v-list-tile-content>
                <v-list-tile-title  >Source</v-list-tile-title>
                </v-list-tile-content>
           </v-list-tile>
             
           <v-list-tile  @click="showInfo = true" >
              <v-list-tile-action>
                  <v-icon >info</v-icon>
                </v-list-tile-action>
                 <v-list-tile-content>
                <v-list-tile-title >Info</v-list-tile-title>
              </v-list-tile>             
          </v-list>         
    </v-menu>
    
    <qd-tablist v-if="EditTabs" :edittabs="EditTabs" :current="curIndex" @selected="setItem">tab list</qd-tablist>
        
        <v-tabs   v-model="curIndex" slot="extension">
		      <v-tab
		        v-for="item in EditTabs.items"
		        :key="item.id"
		        ripple
		        :title="item.uri"
		        style="text-transform: none;text-align:left"
		      >
			       <v-avatar >
			          <v-icon  :title="item.mode" >{{ $MimeTypes.icon(item.mode) }}</v-icon> 
			       </v-avatar>
			        <span >{{ (item.dirty?"*":"") }}</span>
			        <span >{{ item.name  }}</span>
			       <v-spacer></v-spacer>
			       <v-btn icon @click.stop="tabClose(item)">
			          <v-icon  size="16px">close</v-icon>
			        </v-btn>
		      </v-tab>
     </v-tabs>
  </v-toolbar>
  
   
  <v-tabs-items  v-model="curIndex">
     <v-tab-item
      v-for="item in EditTabs.items"
      :key="item.id"
    >
	    <v-card >
        <div style="height:200px" ref="ace" v-resize="onResize" >
        <v-flex xs12  fill-height >
			    <vue-ace  :content="item.text"  v-on:change-content="changeContent"  :events="events"
			    :mode="item.mode" :wrap="wrap"  :settings="aceSettings" v-on:annotation="annotation"></vue-ace>
			  </v-flex>
        </div> 
      </v-card>
    </v-tab-item>
 </v-tabs-items>
 
</div>
</template>

<script>{
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
      this.curIndex=this.EditTabs.addItem({text:"hi "+ new Date()})
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
        this.curIndex=this.EditTabs.addItem({text:"validate: todo\n "+ this.curIndex +"\n" + new Date()})
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
}</script>
