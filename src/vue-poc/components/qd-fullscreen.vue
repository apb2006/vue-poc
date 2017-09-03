<!DOCTYPE html>
<!-- 
 simple full screen toggle icon
 -->
<template id="qd-fullscreen">
<a @click="toggle()" href="javascript:void(0);" title="Fullscreen toggle">
  <v-icon>{{ fullscreenIcon }}</v-icon>
  </a>
</template>

<script>{
  data(){
    return {fullscreenIcon:"fullscreen"}
  },
  methods:{
    toggle(){
      this.$fullscreen.toggle()
      setTimeout(()=>{
        var state=this.$fullscreen.isInFullScreen()
        //console.log("FS",state);
        this.fullscreenIcon=state?"fullscreen_exit":"fullscreen"
        }, 1000);
    }
  }
}
</script>
