<!DOCTYPE html>
<template id="documentation">
 <v-container fluid >
 <v-card>
<v-toolbar dense >
    <v-toolbar-title>
		    <v-breadcrumbs :items="crumbs">
		        <span slot="divider" style="padding:0;"></span>
		         <template slot="item" slot-scope="props">
						    <v-breadcrumbs-item  
						    :to="{ query: { url:  props.item.path }}" :exact="true">
						    <v-icon v-if="props.item.icon">{{ props.item.icon }}</v-icon>
						    {{ props.item.name }}
						    </v-breadcrumbs-item>
				    </template>
		    </v-breadcrumbs>
    </v-toolbar-title>
    </v-toolbar>
    <v-card-text>
    <ul>
    <li>
    <router-link to="documentation/xqdoc"><v-icon>Q</v-icon>XQdoc</router-link>
    </li>
    <li>
    <router-link to="documentation/xqdoc"><v-icon>Q</v-icon>XQdoc</router-link>
    </li>
    </ul>
    </v-card-text>
    </v-card>
  </v-container>
</template>

<script>{
 
}
</script>
