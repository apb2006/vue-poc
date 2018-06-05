<!DOCTYPE html>
<!-- 
 size contents to fit bottom to track window
 -->
<template id="qd-autoheight">
	<div style="height:200px;overflow:hidden;" ref="auto" v-resize="onResize" class="green">
			<slot >i will auto2</slot>
	</div>
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
        //console.log("top",e.offsetTop)
        var h=Math.max(1,window.innerHeight - e.offsetTop -40) 
        // console.log("h",h)
        e.style.height=h +"px"; 
    }
    }
}
</script>
