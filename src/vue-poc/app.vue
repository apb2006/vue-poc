<!DOCTYPE html>
<template id="vuepoc">
 <v-app id="app" :dark="dark" >
  <v-navigation-drawer
     stateless 
      v-model="showNotifications"
      right
     :disable-route-watcher="true"
      app
      width="500"
    >
    <vp-notifications :show-notifications.sync="showNotifications"></vp-notifications>
  </v-navigation-drawer>
  
 <v-navigation-drawer  app :mini-variant.sync="mini" v-model="drawer"   
    :enable-resize-watcher="true">
  <v-list class="pa-0">

          <v-list-tile avatar tag="div">
            <v-list-tile-avatar >
              <v-btn icon @click="session">
              <v-avatar size="36">
              <img src="/vue-poc/ui/quodatum.gif" />
              </v-avatar>
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
    <qd-navlist  :items="items" :mini="mini"></qd-navlist>
 </v-navigation-drawer>
  
 <v-toolbar class="indigo" app dark >
  <v-toolbar-side-icon @click.stop="drawer = !drawer"  ></v-toolbar-side-icon>  
  <v-toolbar-title class="hidden-sm-and-down" >{{$route.meta.title}}</v-toolbar-title>
  <vp-favorite :frmfav.sync="frmfav"></vp-favorite>
 
  <v-spacer></v-spacer>

    <qd-search></qd-search>
     
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
       <v-btn  @click.stop="showNotifications = ! showNotifications" icon flat title="Notifications">
       <v-badge  overlap color="orange">
      <span slot="badge" v-if=" $notification.unseen" >{{ $notification.unseen }}</span>
       <v-icon>notifications</v-icon>
       </v-badge>
   </v-btn>
    <v-menu bottom left min-width="300px">
            <v-btn icon slot="activator" dark>
              <v-icon>more_vert</v-icon>
            </v-btn>
            <v-list>
              <v-list-tile  >
                <v-list-tile-title><qd-fullscreen> Full screen</qd-fullscreen></v-list-tile-title>
              </v-list-tile>
              <v-list-tile  >
                <v-list-tile-title><v-switch label="Dark theme" v-model="dark"></v-switch></v-list-tile-title>
              </v-list-tile>
            </v-list>
          </v-menu>
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

    searchItems:[],
    si: '',
    items2:["todo","set","search"],
    status: {},
    drawer: true,
    showNotifications: false,
    mini: false,
    dark: false,
    alert: {show:false,msg:"Hello"},
    frmfav: false,
  
    items: [
      {href: '/',text: 'Home', icon: 'home'    },
      {
        icon: 'input',
        text: 'Actions' ,
        model: false,
        children: [
      {href: '/eval',text: 'Query',icon: 'play_circle_outline'},
      {href: '/edit',text: 'Edit',icon: 'mode_edit'},
      {href: '/tabs',text: 'Tabs',icon: 'switch_camera'},  
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
          {href: '/documentation', text: 'Documentation',icon: 'library_books' },
          {href: '/namespace', text: 'Namespaces',icon: 'label' },
          {href: '/entity', text: 'Entities',icon: 'redeem' },
      ]},
      {
        icon: 'cast_connected',
        text: 'Server' ,
        model: false,
        children: [
          {href: '/server/jobs',text: 'Running jobs',icon: 'dashboard'},   
          {href: '/server/logs',text: 'Server logs',icon: 'dns'},
          {href: '/server/users',text: 'Users',icon: 'supervisor_account'},
          {href: '/server/repo',text: 'Server code repository',icon: 'local_library'},
          {href: '/server/ping',text: 'Ping',icon: 'update'}
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
            icon: 'format_list_bulleted',
            text: 'Forms' ,
            model: false,
            children: [
         
          {href: '/form',text: 'vue-form-generator',icon: 'format_list_bulleted'  },
          {href: '/form2',text: 'vue-json-schema',icon: 'format_list_bulleted'  },
          {href: '/form3',text: 'vue-form-json-schema',icon: 'format_list_bulleted'  }
          ]},   
      {
        icon: 'more_horiz',
        text: 'More' ,
        model: false,
        children: [
    
      {href: '/session',text: 'Session',icon: 'person'},
      {href: '/timeline',text: 'Time line',icon: 'timelapse'},
      {href: '/select',text: 'Select',icon: 'extension'},
      {href: '/puzzle',text: 'Puzzle',icon: 'extension'},
      {href: '/svg',text: 'SVG',icon: 'extension'},
      {href: '/svg2',text: 'SVG2',icon: 'extension'},
      {href: '/tree',text: 'Tree',icon: 'nature'},
      {href: '/tree2',text: 'Tree 2',icon: 'nature'}
      ]},
      
      {href: '/settings',text: 'Settings',icon: 'settings'  },
      {href: '/about',text: 'About (v0.3.1)' , icon: 'help'    }, 
    ]

  }},
  methods: {
   

      session(){
        this.$router.push({path: '/about'})
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
      }
  },
  watch: {
	    showNotifications: function (val) {
	      console.log("showNotifications",val);
	      if(!val)this.$notification.unseen=0;
	    },
	   
    },
    
  created(){
    console.log("create-----------");
		
    var that=this
    this.$on("theme",this.onDark);
    window.addEventListener('error', function (err) {
      var msg=JSON.stringify(err)
      that.showAlert("vue error:\n"+msg);
      //alert('window.onerrora-\n' + err.message);
  });
    Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
        console.log('[Global Error Handler]: Error in ' + info + ': ' + err);
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
     console.log("HTTP.interceptors.response.use ",error)
     if(460 != error.response.status)this.showAlert("http error:\n"+error.response.data)
     return Promise.reject(error);
   });
   
    HTTP.get("status")
    .then(r=>{
      console.log("status",r)
      this.$auth=Object.assign(this.$auth,r.data);
      console.log("AFTER: ",this.$auth);
      //this.$forceUpdate()
    }) 
  },
  
  beforeDestroy(){
    console.log("destory-----------")
    
  }
  }
</script>
