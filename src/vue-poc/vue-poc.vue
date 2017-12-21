<!DOCTYPE html>
<template id="vuepoc">
 <v-app id="app" :dark="dark" >
  <v-navigation-drawer
     absolute 
      v-model="showNotifications"
      right
      clipped
     :disable-route-watcher="true"
      app
    >
    <v-card>
         <v-toolbar class="teal white--text">
                <v-toolbar-title >Notifications </v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn  @click="showNotifications = false" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          <v-card-text>
          <ul>
            <li v-for="msg in $notification.messages" :key="msg.index">
            {{msg.text}}
            </li>
          </ul>
      </v-card-text>
      </v-card>
</v-navigation-drawer>
 <v-navigation-drawer  app :mini-variant.sync="mini" v-model="drawer"  absolute 
 :disable-route-watcher="true"  :enable-resize-watcher="true">
  <v-list class="pa-0">

          <v-list-tile avatar tag="div">
            <v-list-tile-avatar >
              <v-btn icon @click="session">
              <img src="/vue-poc/ui/quodatum.gif" />
              </v-btn>
            </v-list-tile-avatar>
            <v-list-tile-content>
              <v-list-tile-title>Vue PoC</v-list-tile-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-btn icon @click.stop="mini = !mini">
                <v-icon>chevron_left</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>

      </v-list>
    <qd-navlist  :items="items"></qd-navlist>
 </v-navigation-drawer>
  
 <v-toolbar class="indigo" app dark >
  <v-toolbar-side-icon @click.stop="drawer = !drawer"  ></v-toolbar-side-icon>  
  <v-toolbar-title class="hidden-sm-and-down" >{{$route.meta.title}}</v-toolbar-title>
   <v-menu
      offset-x
      :close-on-content-click="false"
      :nudge-width="200"
      v-model="frmFav"
    >
      <v-btn slot="activator" @click="frmFav = !frmFav" icon flat title="Bookmark this page">
       <v-icon>star_border</v-icon>
       </v-btn>

            <v-card style="width:400px;">
            <v-toolbar class="amber"> 
        <v-card-title>
            Bookmark this page
          </v-card-title>
          </v-toolbar>
         <v-card-text>
         <h6>{{$route.meta.title}}</h6>
            <v-select
              v-model="tags"
              label="tags"
              chips
              tags
              :items="taglist"
            ></v-select>
           </v-card-text>
        <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" flat @click.stop="frmFav=false">Cancel</v-btn>
            <v-btn color="primary" flat @click.stop="favorite();frmFav=false">Save</v-btn>
          </v-card-actions>
        </v-card>
   </v-menu>
  <v-spacer></v-spacer>
  <v-text-field prepend-icon="search" label="Search..." v-model="q"
   hide-details single-line dark @keyup.enter="search"></v-text-field>
  <v-spacer></v-spacer>
  
   <v-menu left  transition="v-fade-transition">
      <v-btn dark icon slot="activator">
        {{$auth.user}}
      </v-btn>
     
          <v-list>
        
              <v-list-tile @click="logout()">
                <v-list-tile-title >logout</v-list-tile-title>
              </v-list-tile>
               <v-list-tile>
                <v-list-tile-title >permission: {{$auth.permission}}</v-list-tile-title>
              </v-list-tile>
            
          </v-list>
      </v-menu>
      <qd-fullscreen></qd-fullscreen>
       <v-btn  @click="showNotifications = ! showNotifications" icon flat title="Notifications">
       <v-icon>notifications</v-icon>
   </v-btn>
</v-toolbar>
 
 <v-content> 
 <v-alert color="error" value="true" dismissible v-model="alert.show">
      <pre style="overflow:auto;">{{ alert.msg }}</pre>
    </v-alert>   
    <transition name="fade" mode="out-in">
      <router-view class="view ma-3"></router-view>
      </transition>
  </v-content>

</v-app>
</template>

<script>{
  router,
  data:function(){return {
    q: "",
    status: {},
    drawer: true,
    showNotifications: false,
    mini: false,
    dark: false,
    alert: {show:false,msg:"Hello"},
    frmFav: false,
    tags: [],
    taglist: [
      'todo',
      'find',
      'some',
      'good',
      'tags'
    ],
    items: [
      {href: '/',text: 'Home', icon: 'home'    },
      {
        icon: 'input',
        text: 'Actions' ,
        model: false,
        children: [
      {href: '/eval',text: 'Query',icon: 'play_circle_outline'},
      {href: '/edit',text: 'Edit',icon: 'mode_edit'},
      {href: '/validate',text: 'Validate',icon: 'playlist_add_check'},
      {href: '/transform',text: 'XSLT Transform',icon: 'forward'},
      {href: '/tasks',text: 'Tasks',icon: 'update'}
      ]},
      {
        icon: 'folder_open',
        text: 'Collections' ,
        model: false,
        children: [
       {href: '/database', text: 'Databases',icon: 'developer_mode' },
       {href: '/files', text: 'File system',icon: 'folder' },
      {href: '/history',text: 'history',icon: 'history'}
      ]},
      {
        icon: 'memory',
        text: 'Models' ,
        model: false,
        children: [
          {href: '/namespace', text: 'Namespaces',icon: 'label' },
          {href: '/entity', text: 'Entities',icon: 'redeem' },
      ]},
      {
        icon: 'cast_connected',
        text: 'Server' ,
        model: false,
        children: [
          {href: '/jobs',text: 'Running jobs',icon: 'dashboard'},   
          {href: '/logs',text: 'Server logs',icon: 'dns'},
          {href: '/timeline',text: 'Time line',icon: 'timelapse'},
          {href: '/server/users',text: 'Users',icon: 'supervisor_account'},
          {href: '/server/repo',text: 'Server code repository',icon: 'local_library'},
          {href: '/ping',text: 'Ping',icon: 'update'}
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
      {href: '/session',text: 'Session',icon: 'person'}, 
      {href: '/select',text: 'Select',icon: 'extension'},
      {href: '/puzzle',text: 'Puzzle',icon: 'extension'},
      {href: '/svg',text: 'SVG',icon: 'extension'},
      {href: '/form',text: 'Forms',icon: 'format_list_bulleted'  },
      {href: '/tabs',text: 'Tabs',icon: 'switch_camera'}
      ]},
      
      {href: '/settings',text: 'Settings',icon: 'settings'  },
      {href: '/about',text: 'About', icon: 'help'    }, 
    ]

  }},
  methods: {
      session(){
        this.$router.push({path: '/session'})
      },
      search(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
      logout(){
        HTTP.get("logout").then(r=>{
          alert("logout")
        }) 
      },
      showAlert(msg){
        this.alert.msg=moment().format()+" "+ msg
        this.alert.show=true
      },
      onDark(dark){
        this.dark=dark
      },
      favorite(){
        alert("@TODO")
      }
  },

  created(){
    
    console.log("create-----------")
    var that=this
    this.$on("theme",this.onDark)
    Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
        console.error(err, vm, info);
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
      console.log("$$$$$$$$$$$",error)
      if(460 != error.response.status)this.showAlert("http error:\n"+error.response.data)
      return Promise.reject(error);
    });
    
    HTTP.get("status")
    .then(r=>{
      console.log("status",r.data)
      Object.assign(Auth,r.data)
      this.$forceUpdate()
    }) 
  },
  beforeDestroy(){
    console.log("destory-----------")
    
  }
  }
</script>
