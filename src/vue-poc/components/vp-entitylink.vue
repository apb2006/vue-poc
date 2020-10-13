<!DOCTYPE html>
<!-- 
 show a entity link
 -->
<template id="vp-entitylink">
		    <router-link :to="'/model/entity/'+entity" :title="entity">@</router-link>   
</template>

<script>{
  props: ['entity']
}
</script>
