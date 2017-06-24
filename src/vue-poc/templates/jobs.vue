<!DOCTYPE html>
<template id="job">
 <v-container fluid>
 <h1>JOBS</h1>
 <nav-apb  :items="items"></nav-apb>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      q:this.$route.query.q,
      items:[
        {href: '/',text: 'Home', icon: 'home'    }, 
        
        {href: 'files', text: 'File system',icon: 'folder' },
        {href: 'edit',text: 'edit',icon: 'mode_edit'},
        {href: 'history',text: 'history',icon: 'history'},
        
        {href: 'eval',text: 'Evaluate',icon: 'cake'},      
        {href: 'tasks',text: 'Tasks',icon: 'build'}, 
        {href: 'jobs',text: 'Jobs',icon: 'print'}, 
        
        {href: 'logs',text: 'Server logs',icon: 'dns'},
        {href: 'people',text: 'People',icon: 'person'}, 
        {href: 'select',text: 'select',icon: 'extension'},
        {href: 'puzzle',text: 'Puzzle',icon: 'extension'}, 
        {href: 'options',text: 'options',icon: 'domain'}, 
        {href: 'tabs',text: 'tabs',icon: 'switch_camera'}, 
        {href: 'ping',text: 'ping',icon: 'update'},
        {href: 'thumbnail',text: 'thumbnail',icon: 'touch_app'},
        {href: 'settings',text: 'settings',icon: 'settings'  }
      ]
      }
  },
  created:function(){
    console.log("Serch",this.$route.query.q)
  }
}
</script>
