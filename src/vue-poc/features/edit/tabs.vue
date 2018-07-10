<!DOCTYPE html>
<template id="tabs">
<div> 
  <v-toolbar   tabs dense>
     <v-toolbar-items>
	      <vp-selectpath :frmfav.sync="showadd" @selectpath="addItem"> <v-icon>add_circle</v-icon></vp-selectpath>
	      <v-btn icon @click="openUri"><v-icon>insert_drive_file</v-icon></v-btn>
      </v-toolbar-items>
      <v-toolbar-title>{{ currentId   }} </v-toolbar-title>
      
       <v-menu v-if="active"  left  transition="v-fade-transition" >
       <v-chip label small slot="activator" >{{ active.mode }}</v-chip>
          <v-list dense>
                <v-list-tile v-for="type in $MimeTypes.toMode"  :key="type.name">
                <v-list-tile-title v-text="type.name" @click="setMode(type)"></v-list-tile-title>
              </v-list-tile>         
          </v-list>         
      </v-menu>
      
       <v-menu v-if="active" left  transition="v-fade-transition" >
        <v-btn icon  slot="activator" ><v-icon>subscriptions</v-icon></v-btn>
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
    
       <v-btn @click="showInfo = !showInfo" icon>
              <v-icon v-if="showInfo">info</v-icon>
              <v-icon v-else>mode_edit</v-icon>
        </v-btn>
        <v-menu left bottom  :close-on-content-click="false" >
          <a class="tabs__item" slot="activator">
          {{ items.length }}
            <v-icon>arrow_drop_down</v-icon>
          </a>
          <v-card>
            <v-card-title>Select Tab</v-card-title>
	          <v-card-actions>
	           <v-select :items="sorted" v-model="a1"
	          label="File"   class="input-group--focused"
	          item-text="name" item-value="id"
	          autocomplete @change="setItem"
	          clearable open-on-clear
	        ></v-select>
	        </v-card-actions>
	        </v-card>
        </v-menu>
        
        <v-tabs   v-model="currentId" slot="extension">
		      <v-tab
		        v-for="item in items"
		        :key="item.id"
		        :href="'#T' + item.id" ripple
		        style="text-transform: none;text-align:left"
		      >
			       <v-avatar >
			          <v-icon  size="16px">insert_drive_file</v-icon>
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
  
   
      <v-tabs-items slot="body" v-model="currentId">
       <v-tab-item
        v-for="item in items"
        :key="item.id"
        :id="'T' + item.id"
      >
		      <v-card flat v-if="showInfo" >
					  <v-card-actions >
				      <v-toolbar-title >Metadata for tab id: '{{ currentId }}'</v-toolbar-title>
				      <v-spacer></v-spacer>    
				       <v-btn flat > <v-icon>highlight_off</v-icon>todo</v-btn>
			      </v-card-actions>
			      
			       <v-card-text v-if="active"> 
									<v-layout row v-for="x in ['name','id','mode','contentType','dirty','location']" :key="x">
							      <v-flex xs3>
							        <v-subheader>{{ x}}</v-subheader>
							      </v-flex>
							      <v-flex xs9>
							        <v-text-field
							          :name="x"
							          label="Hint Text"
							          :value="active[x]"
							          single-line
							        ></v-text-field>
							      </v-flex>
							    </v-layout>
				    </v-card-text>
			    </v-card>
			    
			    <v-card v-else>
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
        nextId:4,
        a1:"",
        currentId: null, //href of current
        active: null,
        items: [],
      wrap: true,
      aceSettings: {},
      events:  new Vue({}),
      annotations: null,
      folded:false
      }
  },
  
  methods:{
    tabClose(item){
      if(item.dirty){
        alert("save first")
      }else{
	      var index=this.items.indexOf(item);
	      if (index > -1) {
	        this.items.splice(index, 1);
	        index=(index==0)?0:index-1;
	        this.currentId=(this.items.length)?"T"+this.items[index].id : null;
	         }
      }
    },
    
    setItem(v){
      if(v) this.currentId="T"+v;
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
        alert("no validate yet");
    },
    
    addItem(tab){
      console.log("new: ",tab);
      var def={name: "AA"+this.nextId, 
               id: ""+this.nextId,
               contentType: "text/xml",
               mode: "xml",
               text: "New text" +this.nextId
               };
      var etab = Object.assign(def,tab);
      this.items.push (etab);
      this.currentId="T" + this.nextId 
      this.nextId++;
    },
    
    loadItem(url){
      HTTP.get("get2",{params: {url:url}})
      .then(r=>{
          console.log(r)
          var tab={
            text: ""+ r.data.data,
            location: url,
            name: url.split(/.*[\/|\\]/)[1]
          };
          this.addItem(tab);
        })
        .catch(error=> {
          console.log(error);
          alert("Get query error:\n"+url)
        });
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
    currentId (val) {
      this.active = this.items.find(e=> val=="T"+e.id);
      this.$router.push({  query: { id: val }});
      console.log("current",val)
    }
  },
  
  computed:{
    sorted(){
      return this.items.slice(0).sort((a,b) => a.name.localeCompare(b.name)) ;
      },
    dirty(){
        return this.active && this.active.dirty
      }
  },
  
  beforeRouteEnter (to, from, next) {
    Promise.all([settings.getItem('settings/ace'), 
                 settings.getItem('edit/items'),
                 settings.getItem('edit/currentId'),
                 ])
    .then(function(values) {
      next(vm => {
          vm.aceSettings = values[0];
          vm.items = values[1];
          vm.currentId = values[2];
          //console.log("done all",values);
          })
          })
    },
     
  beforeRouteLeave (to, from, next) {
    // called when the route that renders this component is about to
    // be navigated away from.
    // has access to `this` component instance.
    settings.setItem('edit/items',this.items);
    settings.setItem('edit/currentId',this.currentId);
    next(true);
  },

    created:function(){
      var url=this.$route.query.url;
      if(url)this.loadItem(url);
      var id=this.$route.query.id;
      this.currentId=id?id:null;
    }
}</script>
