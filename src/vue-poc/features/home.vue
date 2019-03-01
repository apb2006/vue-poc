<!DOCTYPE html>
<template id="home">

<v-card hover raised> 

 <v-card-text>
 
<p>
	links
</p>
<ul>

<li><router-link :to="{path:'files', query:{url:'/vue-poc/'}}"> <v-icon>developer_mode</v-icon>vue-poc files</router-link></li>
<li><router-link :to="{path:'database', query:{url:'/vue-poc/'}}"> <v-icon>folder</v-icon>vue-poc db</router-link></li>
	<li><a href="/doc/#/data/app/vue-poc" target="new">doc</a></li>
	<li><a href="/dba" target="new">DBA app</a></li>
	<li><a href="/vue-poc/ui/database?url=%2Fvue-poc%2F" target="new">db</a></li>
<li><router-link :to="{path:'files', query:{url:'/vue-poc/features/images/'}}">vue-poc image tasks</router-link></li>
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
