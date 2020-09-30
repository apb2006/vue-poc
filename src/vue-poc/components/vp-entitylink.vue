<!DOCTYPE html>
<!-- 
 show a entity link
 -->
<template id="vp-entitylink">
		    <router-link :to="'/entity/'+entity">E</router-link>   
</template>

<script>{
  props: ['entity']
}
</script>
