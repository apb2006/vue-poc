<!DOCTYPE html>
<template id="files">
 <v-container fluid>

<v-card>
  <v-toolbar class="green">
<v-menu offset-y>
  <v-btn primary icon dark slot="activator"><v-icon >folder</v-icon></v-btn>
  <v-list>
    <v-list-item v-for="item in items" :key="item">
      <v-list-tile>
        <v-list-tile-title @click="root()">{{ item }}</v-list-tile-title>
      </v-list-tile>
    </v-list-item>
  </v-list>
</v-menu>
    <v-toolbar-title>URL: <v-chip class="primary white--text" @click="root()">{{ url }}</v-chip></v-toolbar-title>
    <v-spacer></v-spacer>
    <v-icon class="mr-4">search</v-icon>
    <v-icon>view_module</v-icon>
  </v-toolbar>
  <v-list two-line subheader>
    <v-subheader inset>Folders</v-subheader>
    <v-list-item v-for="item in folders" v-bind:key="item.name" >
      <v-list-tile avatar>
        <v-list-tile-avatar>
          <v-icon v-bind:class="[item.iconClass]">{{ item.icon }}</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title @dblclick="folder(item.name)">{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>{{ item.subtitle }}</v-list-tile-sub-title>
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon ripple>
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
          <v-list-tile-title @dblclick="click(item.name)">{{ item.name }}</v-list-tile-title>
          <v-list-tile-sub-title>{{ item.subtitle }}</v-list-tile-sub-title>
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
  template: '#files',
  data:  function(){
    return {url: ".",
            folders:[],
            files:[],
            items:["root"]
    }
  },
  methods:{
    click (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/" +val }})
    },
    folder (val) {
      this.url+="/"+ val
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    },
    load(url){
      HTTP.get("file?url="+url,axios_json)
      .then(r=>{
        console.log(r)
        this.folders=r.data.folders
        this.files=r.data.files
        })
        .catch(error=> {
          console.log(error);
          alert("Get query error"+url)
        });
      
    },
    root(){
      this.url="."
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:".";
    console.log("files: ",this.$route.query.url)
    this.load(this.url)
  }
}
</script>
