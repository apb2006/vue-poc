<!DOCTYPE html>
<template id="scratch">
 <v-container fluid>
   <v-toolbar tabs dense>
   <v-toolbar-title>Tab index {{ curIndex }}</v-toolbar-title>
   <v-btn v-if="active">{{ active.mode }}</v-btn>
   <qd-mimelist  v-if="active" :mimetype="active.contentType" @selected="setmime">{{ active.mode }}</qd-mimelist>
   <v-btn v-if="active"> {{ active.name }}, id: {{ active.id }}</v-btn>
   <v-spacer></v-spacer>

   <v-btn @click="add">Add</v-btn>
    <v-btn @click="curIndex=2">set</v-btn>

    <qd-tablist v-if="EditTabs" :edittabs="EditTabs" :current="curIndex" @selected="setItem">tab list</qd-tablist>
    <v-tabs   v-model="curIndex" slot="extension">
          <v-tab
            v-for="(item,index) in EditTabs.items"
            :key="item.id"
            ripple
            style="text-transform: none;text-align:left"
          >
             <v-avatar >
                <v-icon  size="16px">insert_drive_file</v-icon>
             </v-avatar>
             <span >{{ (item.dirty?"*":"") }}</span>
              <span >{{ item.name  }}</span>
             <v-spacer></v-spacer>
             <v-btn icon @click.stop="tabClose(item,index)">
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
              :mode="item.mode" :wrap="wrap"  :settings="aceSettings" 
              v-on:annotation="annotation"
              :completer="$aceExtras.basexCompleter" :snippets="$aceExtras.snippets" 
              ></vue-ace>
            </v-flex>
            </div> 
          </v-card>
        
      </v-tab-item>
   </v-tabs-items>
 </v-container>
</template>

<script>{
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
</script>
