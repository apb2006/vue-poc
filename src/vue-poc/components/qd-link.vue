<!DOCTYPE html>
<!-- 
 simple link test component
 -->
<template id="qd-link">
 <a :href="href" :target="href" > {{href}}<v-icon>link</v-icon></a>
</template>

<script>{
  props: ['href'],
  created:function(){
      console.log("qd-link");
    }
}
</script>
