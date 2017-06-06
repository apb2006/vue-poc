<!DOCTYPE html>
<template id="home">
<v-layout class="ma-5">
<v-flex xs4>
<v-card hover raised>
  <v-card-row height="200px" class="pa-5 green lighten-1">
    <div class="display-1 white--text text-xs-center">VUE-POC</div>
    v0.0.1
  </v-card-row>
</v-card>
</v-flex>
<v-flex xs4>
  <p>This is a experiment in using <code>vue.js</code>.</p>
  <ul>
  <li><a href="https://vuetifyjs.com/" target="new">vuetifyjs</a></li>
  <li><a href="https://github.com/monterail/vue-multiselect">vue-multiselect</a></li>
<li><a href="https://github.com/sagalbot/vue-select"><s>vue-select</s></a></li>
<li><a href="https://github.com/beautify-web/js-beautify">js-beautify</a></li>

  </ul>
</v-flex>
<v-btn floating="floating">
  <v-icon>add</v-icon>
</v-btn>
 <my-component>REPLACED</my-component>
</v-layout>
</template>
<script>{
}
</script>
