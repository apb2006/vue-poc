<!DOCTYPE html>
<!-- 
 show panel on right
 -->
<template id="qd-panel">
 <v-layout>
		<v-flex>
		<slot name="body"></slot>
		</v-flex>
		
		<v-flex v-if="show" xs4 grey lighten-3>
		<slot name="aside"></slot>
		</v-flex>
</v-layout>
</template>

<script>{
  props: ['show'],
  created:function(){
      console.log("qd-panel");
    }
}
</script>
