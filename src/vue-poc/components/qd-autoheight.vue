<!DOCTYPE html>
<!-- 
 size contents to fit bottom to track window
 -->
<template id="qd-autoheight">
	<v-layout style="height:200px;overflow:hidden;" row wrap
	ref="auto" v-resize="onResize" class="green">
			<slot >i will auto2</slot>
	</v-layout>
</template>

<script>{
  props: ['show'],
  created:function(){
      console.log("qd-auto");
    },
    methods:{
      onResize(){
        var el=this.$refs["auto"];
        var e=el;
       // console.log("top",e.offsetTop,e.getBoundingClientRect().top,window.innerHeight);
        var h=window.innerHeight - e.getBoundingClientRect().top -10;
        h=Math.max(1,h) ;
        // console.log("h",h)
        e.style.height=h +"px"; 
    }
    }
}
</script>
