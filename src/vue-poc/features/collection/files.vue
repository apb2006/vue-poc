<!DOCTYPE html>
<template id="files">
 <v-container fluid>
 
<v-card>
<v-toolbar>
      <v-menu bottom right>
           <v-btn  icon  slot="activator"><v-icon >{{icon}}</v-icon></v-btn>
      <v-list>
          <v-list-tile v-for="item in crumbs" :key="item">
            <v-list-tile-title @click="root()">{{ item }}</v-list-tile-title>
          </v-list-tile>
      </v-list>
    </v-menu>
    <v-toolbar-title>{{ url }}</v-toolbar-title>
   
    <v-spacer></v-spacer>
      <v-text-field prepend-icon="search" label="Filter..." v-model="q" type="search"
   hide-details single-line dark @keyup.native.enter="filter"></v-text-field>
    <v-icon>view_module</v-icon>
 </v-toolbar>

  
  <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
  <v-list v-if="!busy" two-line subheader>
    <v-subheader inset>Folders</v-subheader>
      <v-list-tile v-for="item in folders" v-bind:key="item.name" @click="folder(item.name)" avatar >
        <v-list-tile-avatar  >
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content  @click="folder(item.name)">
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>modified: {{ item.modified | formatDate}} size: {{ item.size | readablizeBytes}}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon ripple @click.native.stop="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    
    <v-divider inset></v-divider>
    <v-subheader inset>Files</v-subheader> 
      <v-list-tile v-for="item in files" v-bind:key="item.name" >
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content @click="file(item.name)">
          <v-list-tile-title >{{ item.name }}</v-list-tile-title>
           <v-list-tile-sub-title>modified:  {{item.modified | formatDate}} size:  {{item.size|readablizeBytes }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon ripple @click.native.stop="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>

  </v-list>
    <v-navigation-drawer right light temporary v-model="showInfo">
     <v-card> 
       <v-toolbar class="green white--text">
      <v-toolbar-title >{{selected}}</v-toolbar-title>
      <v-spacer></v-spacer>    
       <v-btn flat icon @click.native="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-toolbar>
    <v-card-text> blah blah protocol: {{protocol}} </v-card-text> 
</v-card>
      </v-navigation-drawer>
</v-card>
 </v-container>
</template>

<script>{
  
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
</script>
