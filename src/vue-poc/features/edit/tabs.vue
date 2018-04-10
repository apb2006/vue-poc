<!DOCTYPE html>
<template id="tabs">
<div>
  <v-toolbar   tabs>
      <vp-selectpath :frmfav.sync="showadd" @selectpath="addItem"> <v-icon>add_circle</v-icon></vp-selectpath>
      <v-toolbar-title>{{ currentItem   }} : {{ active && active.name }}{{ dirty?'*':'' }}</v-toolbar-title>
       <v-btn @click="showInfo = !showInfo" icon><v-icon>info</v-icon></v-btn>
          <v-spacer></v-spacer>
     
       <v-btn>{{ active && active.mode }}</v-btn>
       
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
        
        <v-tabs   v-model="currentItem" slot="extension">
 
		      <v-tab
		        v-for="item in items"
		        :key="item.id"
		        :href="'#T' + item.id" ripple
		        style="text-transform: none;text-align:left"
		      >
			       <v-avatar >
			          <v-icon  size="16px">insert_drive_file</v-icon>
			       </v-avatar>
			       <span >{{ item.name + (item.dirty?"*":"") }}</span>
			       <v-spacer></v-spacer>
			       <v-btn icon @click.stop="tabClose(item)">
			          <v-icon  size="16px">close</v-icon>
			        </v-btn>
		      </v-tab>
      
     </v-tabs>
     

  </v-toolbar>
    <qd-panel :show="showInfo">
      
 <v-tabs-items slot="body" v-model="currentItem">
       <v-tab-item
        v-for="item in items"
        :key="item.id"
        :id="'T' + item.id"
      >
      <v-card flat  >
        <div style="height:200px" ref="ace" v-resize="onResize" >
        <v-flex xs12  fill-height >
			    <vue-ace  :content="item.text"  v-on:change-content="changeContent"
			    :mode="item.mode" :wrap="wrap"  :settings="aceSettings"></vue-ace>
			  </v-flex>
        </div> 
      </v-card>
      </v-tab-item>
 </v-tabs-items>
  <v-card slot="aside" flat> 
       <v-card-actions >
      <v-toolbar-title >test</v-toolbar-title>
      <v-spacer></v-spacer>    
       <v-btn flat icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-card-actions>
    <v-card-text> blah blah protocol:  </v-card-text> 
    </v-card>
 </qd-panel>
</div>
</template>

<script>{
    data () {
      return {
        showadd: false,
        showInfo: false,
        nextId:4,
        a1:"",
        currentItem: null, //href of current
        active: null,
        items: [
          {name:"web.txt", id:"1", mode:"text", dirty: false, 
            text:"1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."},
        
          {name:"Shopping.xq", id:"2", mode: "xquery" ,dirty: false,
            text:"2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."},
       
          {name:"videos.xml", id:"3", mode:"xml",dirty: false,
            text:"2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."},
      
        ],
      wrap: true,
      aceSettings: {}
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
        this.currentItem=(this.items.length)?"T"+this.items[index].id : null;
    }
      }
    },
    setItem(v){
      if(v) this.currentItem="T"+v;
    },
    
    addItem(tab){
      console.log("TABS: ",tab);
      var def={name: "AA"+this.nextId, 
               id: ""+this.nextId,
               contentType: "text/xml",
               mode: "xml",
               text: "New text" +this.nextId
               };
      var etab = Object.assign(def,tab);
      this.items.push (etab);
      this.currentItem="T" + this.nextId 
      this.nextId++;
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
    },
  },
  watch:{
    currentItem: function (val) {
      this.active = this.items.find(e=> val=="T"+e.id)
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
    settings.getItem('settings/ace')
    .then( v =>{
      next(vm => {vm.aceSettings = v;})
        })
     },
}</script>
