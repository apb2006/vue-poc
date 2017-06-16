<!DOCTYPE html>
<template id="files">
 <v-container fluid>

<v-card>
  <v-toolbar class="green">
<v-menu offset-y>
  <v-btn primary icon dark slot="activator"><v-icon >folder</v-icon></v-btn>
  <v-list>
    <v-list-item v-for="item in crumbs" :key="item">
      <v-list-tile>
        <v-list-tile-title @click="root()">{{ item }}</v-list-tile-title>
      </v-list-tile>
    </v-list-item>
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
    <v-list-item v-for="item in folders" v-bind:key="item.name" >
      <v-list-tile avatar >
        <v-list-tile-avatar  @click="folder(item.name)">
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content  @click="folder(item.name)">
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>modified: {{ item.modified | formatDate}} size: {{ item.size | readablizeBytes}}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon ripple @click.native="info(item.name)">
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </v-list-item>
    <v-divider inset></v-divider>
    <v-subheader inset>Files</v-subheader>
    <v-list-item v-for="item in files" v-bind:key="item.name">
      <v-list-tile>
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title @click="file(item.name)">{{ item.name }}</v-list-tile-title>
           <v-list-tile-sub-title>modified: {{ formatDate(item.modified) }} size: {{ readablizeBytes(item.size) }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon ripple>
            <v-icon class="grey--text text--lighten-1">info</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </v-list-item>
  </v-list>
</v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return { 
            crumbs:[],
            folders:[],
            files:[],
            items:["root"],
            q:"",
            busy:false
    }
  },
  methods:{
    file (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/"+val  }})
    },
    folder (val) {
      this.crumbs.push(val )
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    },
    load(url){
      this.busy=true
      HTTP.get("file?url="+url,axios_json)
      .then(r=>{
        console.log(r)
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
      this.load(this.url)
    },
    filter(){
      console.log("TODO")
    },
    info(){
      alert("info")
    },
    readablizeBytes(v){
      return Vue.filter('readablizeBytes')(v)
      },
      formatDate(v){
      return Vue.filter('formatDate')(v)
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
      }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:"/";
    console.log("files: ",this.$route.query.url)
    this.load(this.url)
  }
}
</script>
