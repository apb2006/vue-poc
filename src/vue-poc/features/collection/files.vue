<!DOCTYPE html>
<template id="files">
 <v-container fluid>
 
<v-card>

<v-toolbar light>
    <v-btn icon :to="{query: { url: '/' }}">
     <v-icon >{{icon}}</v-icon>
     </v-btn>  
    <v-toolbar-title>
    <v-breadcrumbs>
      <v-breadcrumbs-item v-for="item in crumbs" :key="item" :to="{ query: { url: '/' + item + '/' }}">
    {{ item }}
    </v-breadcrumbs-item>
    </v-breadcrumbs>
    </v-toolbar-title>
    <v-spacer></v-spacer>
      <v-text-field prepend-icon="search" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="filter"></v-text-field>
   
     <v-btn icon @click="alert('todo')">     
    <v-icon>view_module</v-icon>
    </v-btn>
 </v-toolbar>
 
  
  
  <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
  <v-layout>
	  <v-flex>
	  <v-list v-if="!busy" two-line subheader>
	    <v-subheader inset>Folders</v-subheader>
	      <v-list-tile v-for="item in folders" v-bind:key="item.name" @click="folder(item)" avatar >
	        <v-list-tile-avatar  >
	          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
	        </v-list-tile-avatar>
	        <v-list-tile-content  >
	          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
	          <v-list-tile-sub-title>modified: {{ item.modified | formatDate}} size: {{ item.size | readablizeBytes}}</v-list-tile-sub-title>
	        </v-list-tile-content>
	        <v-list-tile-action>
	          <v-btn icon ripple @click.stop="info(item)">
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
	          <v-btn icon ripple @click.stop="info(item)">
	            <v-icon class="grey--text text--lighten-1">info</v-icon>
	          </v-btn>
	        </v-list-tile-action>
	      </v-list-tile>
	  </v-list>
	  </v-flex>
	
  </v-layout>
  
    <v-navigation-drawer left persistent v-model="showInfo" :disable-route-watcher="true">
   <v-card flat tile> 
       <v-toolbar >
      <v-card-title >{{ selected && selected.name }}</v-card-title>
      <v-spacer></v-spacer>    
       <v-btn flat icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-toolbar>
    <v-card-text> Things to do with  </v-card-text>
    <v-card-actions> 
           <v-btn flat @click="invoke()"><v-icon>run</v-icon>run</v-btn>
           </v-card-actions>
    </v-card>
   </v-navigation-drawer> 
   
</v-card>
 </v-container>
</template>

<script>{
  
  props:["protocol"],
  data:  function(){
    return { 
            url: "", 
            folders: [],
            files: [],
            items: ["root"],
            q: "",
            busy: false,
            showInfo: false,
            selected: null
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
    load(url){
      this.busy=true
      HTTP.get("collection",{params:{url:url,protocol:this.protocol}})
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
      this.$router.push({  query: { url: this.url }})
    },
    filter(){
      console.log("TODO",this.q)
      this.$router.push({  query: {url:this.url,q:this.q }})
    },
    info(item){
      this.selected=item
      this.showInfo=true
    },
    invoke(){
      HTTP.post("eval/invoke",Qs.stringify({path:this.url+this.selected.name}))
      .then(r=>{
        var job=r.data.job
        console.log(r.data)
         alert("job: "+job)
         this.$router.push({ path: 'jobs', params: {job:job }})
      })
    }
  
  },
  computed: {
   icon(){
        return (this.protocol=="basexdb")?"developer_mode":"folder"
      },
   crumbs(){
        return this.url.split("/").filter((a)=>a.length>0) 
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
    this.q=this.$route.query.q || this.q
    this.load(this.url)
  }
}
</script>
