<!DOCTYPE html>
<template id="tabs">
<div>
  <v-toolbar   tabs>
      <v-toolbar-side-icon></v-toolbar-side-icon>
      <v-toolbar-title>{{ currentItem   }}</v-toolbar-title>
        <vp-selectpath :frmfav.sync="showadd" @selectpath="addItem"> <v-icon>add_circle</v-icon></vp-selectpath>
      <v-spacer></v-spacer>

        <v-menu left bottom  >
          <a class="tabs__item" slot="activator">
          {{ items.length }}
            <v-icon>arrow_drop_down</v-icon>
          </a>
          <v-card>
	          <v-card-actions>
	           <v-select :items="sorted" v-model="a1"
	          label="File"   class="input-group--focused"
	          autocomplete @change="setItem"
	        ></v-select>
	        </v-card-actions>
	        </v-card>
        </v-menu>
        
        <v-tabs   v-model="currentItem" slot="extension">
 
		      <v-tab
		        v-for="item in items"
		        :key="item.id"
		        :href="'#tab-' + item.id" ripple
		        style="text-transform: none;text-align:left"
		      >
			       <v-avatar >
			          <v-icon  size="16px">insert_drive_file</v-icon>
			       </v-avatar>
			       <span style="text-transform: none;">{{ item.name }}</span>
			       <v-spacer></v-spacer>
			       <v-btn icon @click.stop="tabClose(item)">
			          <v-icon  size="16px">close</v-icon>
			        </v-btn>
		      </v-tab>
      
     </v-tabs>
     

  </v-toolbar>
        
 <v-tabs-items  v-model="currentItem">
       <v-tab-item
        v-for="item in items"
        :key="item.id"
        :id="'tab-' + item.id"
      >
      <v-card flat  >
        <div style="height:200px" ref="ace" v-resize="onResize" >
        <v-flex xs12  fill-height >
			    <vue-ace  :content="item.text" :mode="item.mode" :wrap="wrap"  :settings="aceSettings"></vue-ace>
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
        showadd: false,
        nextId:4,
        a1:"",
        currentItem: null,
        items: [
          {name:"web.txt", id:"1", mode:"text", 
            text:"1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."},
        
          {name:"Shopping.xq", id:"2", mode: "xquery" ,
            text:"2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."},
       
          {name:"videos.xml", id:"3", mode:"xml",
            text:"2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."},
      
        ],
      wrap: true,
      mode: "xquery",
      aceSettings: {}
      }
  },
  
  methods:{
    tabClose(item){
      alert("close:"+ item.id);
    },
    setItem(v){
      //alert(v);
      this.currentItem=v;
    },
    
    addItem(){
      var tab={name: "AA"+this.nextId, 
               id: ""+this.nextId,
               mode: "xml",
               text: "New text" +this.nextId
               };
      this.items.push (tab);
      this.currentItem="tab-" + this.nextId 
      this.nextId++;
    },
    onResize(){
      var el=this.$refs["ace"];
      for (e of el){
      console.log("top",e.offsetTop)
      var h=Math.max(1,window.innerHeight - e.offsetTop -200) 
       console.log("h",h)
      e.style.height=h +"px";
    }
    },
  },
  
  computed:{
    sorted(){
      return this.items.slice(0).sort()
      }
  },
  beforeRouteEnter (to, from, next) {
    settings.getItem('settings/ace')
    .then( v =>{
      next(vm => {vm.aceSettings = v;})
        })
     },
}</script>
