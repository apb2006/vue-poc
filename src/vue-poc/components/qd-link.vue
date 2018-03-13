<!DOCTYPE html>
<!-- 
 simple link test component
 -->
<template id="qd-link">
 <a :href="href" :target="href" >
		 <v-icon>link</v-icon> 
		 <slot>{{href}}</slot>
 </a>
</template>

<script>{
  props: ['href'],
  created:function(){
      console.log("qd-link");
    }
}
</script>
