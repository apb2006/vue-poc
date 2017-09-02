<!DOCTYPE html>
<template id="vuepoc">
 <v-app  >
 <v-navigation-drawer persistent light :mini-variant.sync="mini" v-model="drawer"  
 :disable-route-watcher="true" height="100%"  class="grey lighten-4 pb-0">
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
  
 <v-toolbar class="indigo" dark >
  <v-toolbar-side-icon @click.stop="drawer = !drawer"  ></v-toolbar-side-icon>  
  <v-toolbar-title class="hidden-sm-and-down" >{{$route.meta.title}}</v-toolbar-title>
  <v-spacer></v-spacer>
   <v-text-field prepend-icon="search" label="Search..." v-model="q"
   hide-details single-line dark @keyup.enter="search"></v-text-field>
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
      <v-btn  icon @click="fullscreen" :disabled="!fullscreenEnabled">
        <v-icon>{{ fullscreenIcon }}</v-icon>
      </v-btn>
      <qd-fullscreen></qd-fullscreen>
</v-toolbar>
 <main> 
 <v-alert error value="true" dismissible v-model="alert.show">
      <pre style="overflow:auto;">{{ alert.msg }}</pre>
    </v-alert>   
      <transition name="fade" mode="out-in">
        <router-view class="view ma-3"></router-view>
        </transition>
     </main>
</v-app>

</template>

<script>{
   // router,
    data:function(){return {
      q:"",
      status:{},
      drawer:true,
      mini: false,
      alert:{show:false,msg:"Hello"},
      items:[
        {href: '/',text: 'Home', icon: 'home'    }, 
        {
          icon: 'folder_open',
          text: 'Collections' ,
          model: false,
          children: [
         {href: '/database', text: 'Databases',icon: 'developer_mode' },
         {href: '/files', text: 'File system',icon: 'folder' },
        {href: '/edit',text: 'Edit',icon: 'mode_edit'},
        {href: '/history',text: 'history',icon: 'history'}
        ]},
        {
          icon: 'directions_run',
          text: 'Actions' ,
          model: false,
          children: [
        {href: '/eval',text: 'Query',icon: 'play_circle_outline'},      
        {href: '/tasks',text: 'Tasks',icon: 'history'}
        ]},
        {
          icon: 'cast_connected',
          text: 'Server' ,
          model: false,
          children: [
            {href: '/jobs',text: 'Running jobs',icon: 'dashboard'},   
            {href: '/logs',text: 'Server logs',icon: 'dns'},
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
        {href: '/tabs',text: 'Tabs',icon: 'switch_camera'}, 
        {href: '/timeline',text: 'Time line',icon: 'timelapse'}
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
        fullscreenEnabled(){
          return document.fullscreenEnabled
        },
        isInFullScreen(){
          return (document.fullscreenElement && document.fullscreenElement !== null) ||
          (document.webkitFullscreenElement && document.webkitFullscreenElement !== null) ||
          (document.mozFullScreenElement && document.mozFullScreenElement !== null) ||
          (document.msFullscreenElement && document.msFullscreenElement !== null)
        },
        fullscreen(){
          // https://stackoverflow.com/questions/36672561/how-to-exit-fullscreen-onclick-using-javascript
          var isInFullScreen = this.isInFullScreen();
          alert(isInFullScreen);
          var docElm = document.documentElement;
          if (!isInFullScreen) {
              if (docElm.requestFullscreen) {
                  docElm.requestFullscreen();
              } else if (docElm.mozRequestFullScreen) {
                  docElm.mozRequestFullScreen();
              } else if (docElm.webkitRequestFullScreen) {
                  docElm.webkitRequestFullScreen();
              } else if (docElm.msRequestFullscreen) {
                  docElm.msRequestFullscreen();
              }
          } else {
              if (document.exitFullscreen) {
                  document.exitFullscreen();
              } else if (document.webkitExitFullscreen) {
                  document.webkitExitFullscreen();
              } else if (document.mozCancelFullScreen) {
                  document.mozCancelFullScreen();
              } else if (document.msExitFullscreen) {
                  document.msExitFullscreen();
              }
          }
        }
    },
    computed:{
      fullscreenIcon(){ return this.isInFullScreen()?'fullscreen_exit':'fullscreen'}
    },

    created(){
      
      console.log("create-----------")
      Vue.config.errorHandler = function (err, vm, info) {
    // handle error
    // `info` is a Vue-specific error info, e.g. which lifecycle hook
          console.error(err, vm, info);
          this.showAlert("vue error:\n"+err)
          alert("vue error");
     };
      // Add a response interceptor

      HTTP.interceptors.response.use(
      (response)=> {
        // Do something with response data
        return response;
      },
      (error) =>{
        // interupt restxq single 
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
