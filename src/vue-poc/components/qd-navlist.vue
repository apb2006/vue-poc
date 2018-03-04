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
            <v-list-tile slot="activator" >
              <v-list-tile-content>
                <v-list-tile-title>{{ item.text }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            
            <v-list-tile v-if="!mini" v-for="subItem in item.children" v-bind:key="subItem.text"
             :prepend-icon="subItem.icon" 
             :to="subItem.href"  avatar ripple >
              <v-list-tile-avatar>
		             <v-icon>{{ subItem.icon }}</v-icon>
		          </v-list-tile-avatar>
            <v-list-tile-content>
                <v-list-tile-title>{{ subItem.text }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-group>
          
          <v-list-tile v-else  v-bind:key="item.text"  :to="item.href"  ripple>
              <v-list-tile-avatar>
                 <v-icon>{{ item.icon }}</v-icon>
              </v-list-tile-avatar>
          <v-list-tile-content>
                <v-list-tile-title>{{ item.text }}</v-list-tile-title>
              </v-list-tile-content>
     
          </v-list-tile>
          </template>
        </v-list>
</template>

<script>{
  props: ['items','mini']
}
</script>
