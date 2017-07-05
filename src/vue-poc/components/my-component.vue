<!DOCTYPE html>
<template id="my-component">
 <a :href="href" :target="href" > {{href}}<v-icon>link</v-icon></a>
</template>

<script>{
  props: ['href'],
  created:function(){
      console.log("my-component");
    }
}
</script>
