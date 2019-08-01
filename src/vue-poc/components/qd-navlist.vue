<!DOCTYPE html>
<!-- 
for nav drawer
 -->
<template id="qd-navlist">
 <v-list dense>
    <template v-for="(item, i) in items">
          <v-list-group v-if="item.children"
            v-bind:key="item.text"
            :prepend-icon="item.icon"
            no-action
          >
         <template v-slot:activator="{ on }">
            <v-list-item v-on="on" >
              <v-list-item-content>
                <v-list-item-title>{{ item.text }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
         </template>
             
            <v-list-item v-if="!mini" v-for="subItem in item.children" v-bind:key="subItem.text"
             :prepend-icon="subItem.icon" 
             :to="subItem.href"  ripple >
              <v-list-item-avatar>
		             <v-icon>{{ subItem.icon }}</v-icon>
		          </v-list-item-avatar>
            <v-list-item-content>
                <v-list-item-title>{{ subItem.text }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-group>
          
          <v-list-item v-else  v-bind:key="item.text"  :to="item.href"  ripple>
              <v-list-item-avatar>
                 <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-avatar>
          <v-list-item-content>
                <v-list-item-title>{{ item.text }}</v-list-item-title>
              </v-list-item-content>
     
          </v-list-item>
          </template>
        </v-list>
</template>

<script>{
  props: ['items','mini']
}
</script>
