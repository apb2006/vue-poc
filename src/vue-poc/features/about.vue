<!DOCTYPE html>
<template id="about">
<v-container>
<v-parallax src="/vue-poc/ui/vue-poc.png" >
</v-parallax> 
<v-card>

  <v-card-text>
 
<p>
	This is a experiment in using
	<code>vue.js</code>
	.
</p>
<ul>
	<li><a href="https://vuetifyjs.com/vuetify/quick-start"
		target="new">vuetifyjs</a></li>
	<li><a href="https://github.com/monterail/vue-multiselect"
		target="new">vue-multiselect</a></li>
	<li><a href="https://github.com/sagalbot/vue-select" target="new"><s>vue-select</s></a></li>
	<li><a href="https://github.com/beautify-web/js-beautify"
		target="new">js-beautify</a></li>
	<li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
	<li><a href="/dba" target="new">DBA app</a></li>
	 <li> <router-link to="database?url=%2Fvue-poc%2F">DB</router-link></li>
</ul>
</v-flex> <v-btn floating="floating"> <v-icon>add</v-icon> </v-btn> <qd-link
	href="/dba">REPLACED</qd-link> 
	</v-card-text>
	</v-card>
	</v-container>
	</template>
<script>
  {
  }
</script>
