<!DOCTYPE html>
<template id="home">

<v-card raised> 
<v-card-title>links</v-card-title>
 <v-card-text>
<v-card-text>
<v-list dense >
		<v-list-tile  @click="">
		<router-link :to="{path:'files', query:{url:'/vue-poc/'}}"> <v-icon>developer_mode</v-icon>vue-poc files</router-link>
		</v-list-tile  >
		<v-list-tile @click="">
		<router-link :to="{path:'database', query:{url:'/vue-poc/'}}"> <v-icon>folder</v-icon>vue-poc db</router-link>
		</v-list-tile >
			<v-list-tile @click="">
			<a href="/doc/#/data/app/vue-poc" target="new">doc</a>
			</v-list-tile>
			<v-list-tile @click="">
			<a href="/dba" target="new">DBA app</a>
			</v-list-tile>
			<v-list-tile @click="">
			<a href="/vue-poc/ui/database?url=%2Fvue-poc%2F" target="new">db</a>
			</v-list-tile>
		<v-list-tile @click="">
		<router-link :to="{path:'files', query:{url:'/vue-poc/features/images/'}}">vue-poc image tasks</router-link>
		</v-list-tile>
</v-list>
 </v-card-text> 
 <v-card-actions>
		<v-btn floating="floating"> <v-icon>add</v-icon> 
		</v-btn> <qd-link href="/dba">REPLACED</qd-link> 
  </v-card-actions>
   
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
