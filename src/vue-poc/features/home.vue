<!DOCTYPE html>
<template id="home">

<v-card hover raised> 
<v-card-title class="pa-5 indigo">
<div class="display-1 white--text text-xs-center">VUE-POC</div>
<v-spacer></v-spacer>
  <v-speed-dial  v-model="fab"  hover right direction="bottom" transition="slide-y-reverse-transition">
      <v-btn  slot="activator" class="blue darken-2"  dark  fab  hover  v-model="fab">
        <v-icon>account_circle</v-icon>
        <v-icon>close</v-icon>
      </v-btn>
      <v-btn   fab  dark  small    class="green"    >
        <v-icon>edit</v-icon>
      </v-btn>
      <v-btn fab dark small class="indigo" >
        <v-icon>add</v-icon>
      </v-btn>
      <v-btn fab dark small class="red" >
        <v-icon>delete</v-icon>
      </v-btn>
    </v-speed-dial>
 </v-card-title> 

 <v-card-text>
 
<p>
	links
</p>
<ul>

<li><router-link :to="{path:'files', query:{url:'/vue-poc/features/images/'}}">vue-poc image tasks</router-link></li>
<li><router-link :to="{path:'database', query:{url:'/vue-poc/'}}">vue-poc db</router-link></li>
	<li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
	<li><a href="/dba" target="new">DBA app</a></li>
	<li><a href="/vue-poc/ui/database?url=%2Fvue-poc%2F" target="new">db</a></li>
</ul>

<v-btn floating="floating"> <v-icon>add</v-icon> 
</v-btn> <qd-link href="/dba">REPLACED</qd-link> 
  
    </v-card-text> 
</v-card> 
	</template>
<script>
  {
    data:  function(){
      return { 
              fab: false
      }
  }
  }
</script>
