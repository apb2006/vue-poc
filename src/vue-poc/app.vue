<!DOCTYPE html>
<!-- main ui
 -->
<template id="vuepoc">
 <v-app app id="app"  >
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
  
 <v-navigation-drawer  app :mini-variant.sync="mini" v-model="drawer"   :clipped="$vuetify.breakpoint.lgAndUp">  
     <v-list class="pa-0">
          <v-list-item  tag="div">
            <v-list-item-avatar >
              <v-btn icon @click="session">
              <v-avatar size="36">
              <img src="/vue-poc/ui/quodatum.gif" alt="Vue-poc logo"/>
              </v-avatar>
              </v-btn>
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title>Vue PoC</v-list-item-title>
            </v-list-item-content>
            <v-list-item-action>
              <v-btn icon @click.stop="mini = !mini">
                <v-icon>chevron_left</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>

      </v-list>
    <qd-navlist2  :items="items" :mini="mini"></qd-navlist2>
    <router-view name="helper" class="view ma-3"></router-view>
 </v-navigation-drawer>
  
 <v-app-bar  app  :clipped-left="$vuetify.breakpoint.lgAndUp"
      color="blue darken-3" dense  
      dark >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"  ></v-app-bar-nav-icon>
  <v-toolbar-title class="hidden-sm-and-down" >    
    {{$route.meta.title}}</v-toolbar-title>
    <vp-favorite :frmfav.sync="frmfav"></vp-favorite>
  <v-spacer></v-spacer>
  <v-toolbar-items>
    <qd-search></qd-search>
  </v-toolbar-items>
  <v-spacer></v-spacer>
  
  
       <v-btn  @click.stop="showNotifications = ! showNotifications" icon text title="Notifications">
       <v-badge   overlap color="orange">
      <span slot="badge" v-if=" $notification.unseen" >{{ $notification.unseen }}</span>
       <v-icon>notifications</v-icon>
       </v-badge>
   </v-btn>
   
    <v-menu bottom  left min-width="300px">
	       <template v-slot:activator="{ on }">
	         <v-btn icon v-on="on" >
              <v-icon>more_vert</v-icon>
            </v-btn>
           </template>
            <v-list>
              <v-list-item  >
                <v-list-item-title>Full screen</v-list-item-title>
                <v-list-item-action ><qd-fullscreen></qd-fullscreen></v-list-item-action>
              </v-list-item>
              <v-list-item  >
                <v-list-item-title>Dark theme</v-list-item-title>
                 <v-list-item-action ><v-switch  v-model="$vuetify.theme.dark"></v-switch> </v-list-item-action>
              </v-list-item>
              <v-divider ></v-divider>
               <v-list-item  >
               <v-list-item-title>Server hot load:</v-list-item-title> 
                <v-list-item-action ><v-btn @click="init">.init</v-btn></v-list-item-action>
              </v-list-item>
            </v-list>
        </v-menu>
        
	 <v-menu left  transition="v-fade-transition">
	   <template v-slot:activator="{ on }">
	      <v-btn dark icon v-on="on">
	        {{$auth.user}}
	      </v-btn>
	    </template >   
        <v-list>
            <v-list-item to="/session"   ripple>
              <v-list-item-title >Session</v-list-item-title>
            </v-list-item>
            <v-list-item @click="logout()">
              <v-list-item-title >logout</v-list-item-title>
            </v-list-item>
             <v-list-item>
              <v-list-item-title >permission: {{$auth.permission}}</v-list-item-title>
            </v-list-item>
          <v-list-item>
              <v-list-item-title >$route.path: {{$route.path}}</v-list-item-title>
            </v-list-item>
        </v-list>
     </v-menu>
      
</v-app-bar>
 
 <v-main> 
 <v-alert color="error" value="true" dismissible v-model="alert.show">
      <pre style="overflow:auto;">{{ alert.msg }}</pre>
    </v-alert>   
    <transition name="fade" mode="out-in">
      <router-view class="view ma-3"></router-view>
      </transition>
  </v-main>

</v-app>
</template>

<script>{
  router,
  store,
  vuetify: new Vuetify({ theme: {dark: false},
	                     icons: {iconfont: 'md'}
  					}),
  data:function(){return {

    searchItems:[],
    si: '',
    items2:["todo","set","search"],
    status: {},
    drawer: true,
    showNotifications: false,
    mini: false,
    alert: {show:false,msg:"Hello"},
    frmfav: false,
  
    items: [
      {href: '/',text: 'Dashboard', icon: 'home'    },
      {
        icon: 'input',
        text: 'Actions' ,
        model: false,
        children: [
      {href: '/eval',text: 'Query',icon: 'play_circle_outline'},
   
      {href: '/edit',text: 'Edit',icon: 'mode_edit'},
      {href: '/tabs',text: 'Tabs',icon: 'switch_camera'},  
      {href: '/validate',text: 'Validate',icon: 'playlist_add_check'},
      {href: '/transform',text: 'XSLT Transform',icon: 'forward'}
      ]},
      
      {
        icon: 'add_task',
        text: 'Tasks' ,
        model: false,
        children: [
        	   {href: '/tasks',text: 'Task list',icon: 'assignment'},
        	   {href: '/history/tasks',text: 'History',icon: 'history'}
      ]},
      {
          icon: 'folder_open',
          text: 'Collections' ,
          model: false,
          children: [
         {href: '/database', text: 'Databases',icon: 'developer_mode' },
         {href: '/files', text: 'File system',icon: 'folder' },
         {href: '/documentation', text: 'Documentation',icon: 'library_books' },   
         {href: '/history/files',text: 'history',icon: 'history'}
        ]},
      {
        icon: 'memory',
        text: 'Models' ,
        model: false,
        children: [             
          {href: '/model/entity', text: 'Entities',icon: 'redeem' },
          {href: '/model/namespace', text: 'Namespaces',icon: 'dns' },
          {href: '/model/schema', text: 'Schemas',icon: 'verified' },
          {href: '/model/taxonomy', text: 'Taxonomies',icon: 'local_offer' },
          {href: '/model/mimetype', text: 'Mimetypes',icon: 'assignment' },
      ]},
      
      {
        icon: 'cast_connected',
        text: 'Server' ,
        model: false,
        children: [
          {href: '/server/jobs',text: 'Running jobs',icon: 'dashboard'},
          {href: '/server/services',text: 'Services',icon: 'dashboard'},   
          {href: '/server/logs',text: 'Server logs',icon: 'dns'},
          {href: '/server/users',text: 'Users',icon: 'supervisor_account'},
          {href: '/server/repo',text: 'Package repository',icon: 'local_library'},
        
          {href: '/server/upload',text: 'Upload to server',icon: 'file_upload'},
         
          {href: '/server/settings',text: 'Server settings',icon: 'settings_applications'}
      ]},
      
      {
          icon: 'hourglass_empty',
          text: 'Performance' ,
          model: false,
          children: [
        	  {href: '/logdate',text: 'XML logs',icon: 'dns'},
        	  {href: '/performance/ping',text: 'Ping',icon: 'update'},
              {href: '/performance/dicetest',text: 'Dice performance',icon: 'update'}
        	  ]
      },
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
      {href: '/html',text: 'HTML test',icon: 'receipt'},
      {href: '/select',text: 'Select',icon: 'extension'},
      {href: '/puzzle',text: 'Puzzle',icon: 'extension'}
      ]},
      {
        icon: 'toys',
        text: 'Labs' ,
        model: false,
        children: [
      {href: '/labs/scratch',text: 'Scratch pad',icon: 'filter_frames'},
      {href: '/labs/form',text: 'Forms',icon: 'subtitles'  },
      {href: '/labs/timeline',text: 'Time line',icon: 'event_note'},
      {href: '/labs/svg',text: 'SVG',icon: 'extension'},
      {href: '/labs/svg2',text: 'SVG2',icon: 'extension'},
      {href: '/labs/tree',text: 'Tree',icon: 'nature'},
      {href: '/labs/tree2',text: 'Tree 2',icon: 'nature'},
      {href: '/labs/websocket',text: 'Web socket',icon: 'swap_calls'},
      {href: '/labs/markdown',text: 'Markdown',icon: 'receipt'},
      ]},
      {href: '/settings',text: 'Settings',icon: 'settings'  },
      {href: '/about',text: 'About' , icon: 'help'    }, 
    ]

  }},
  methods: {
      init(){
        HTTP.get("../../.init");
      },

      session(){
        this.$router.push({path: '/about'})
      },
      
      logout(){
        HTTP.get("logout").then(r=>{
          this.$auth.role=null;
          this.$auth.user="guest";
          this.$router.push({path: '/'});
        }) 
      },
      showAlert(msg){
        this.alert.msg=moment().format()+" "+ msg
        this.alert.show=true
      }
  },
  watch: {
	    showNotifications: function (val) {
	      console.log("showNotifications",val);
	      if(!val)this.$notification.unseen=0;
	    },
	   
    },
    
  created(){
    console.log("create-----------", this.items);
		
    var that=this
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
     if (!error.response) {
    // network error
       this.showAlert("network error\n"+"server down")
  }else if(460 != error.response.status)this.showAlert("http error:\n"+error.response.data)
     return Promise.reject(error);
   });
   
    HTTP.get("status")
    .then(r=>{
      //console.log("status",r)
      this.$auth=Object.assign(this.$auth,r.data);
      console.log("AFTER: ",this.$auth);
      //this.$forceUpdate()
    })
    EditTabs.restore();
  },
  
  beforeDestroy(){
    console.log("destory-----------")
    
  }
  }
</script>
