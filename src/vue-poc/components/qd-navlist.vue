<!DOCTYPE html>
<!-- 
for nav drawer
 -->
<template id="qd-navlist">
 <v-list dense>
<template v-for="(item, i) in items">
  <v-layout
    row
    v-if="item.heading"
    align-center
    :key="i"
  > 
    <v-flex xs6>
      <v-subheader v-if="item.heading">
        {{ item.heading }}
      </v-subheader>
    </v-flex>
    <v-flex xs6 class="text-xs-center">
      <a href="#!" class="body-2 black--text">EDIT</a>
    </v-flex>
  </v-layout>
  <v-list-group v-else-if="item.children" v-model="item.model" no-action>

      <v-list-tile :to="item.href"  ripple slot="item">
       <v-list-tile-action>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-tile-action>
          <v-list-tile-title>
            {{ item.text }}
          </v-list-tile-title>
          <v-spacer></v-spacer>
        <v-list-tile-action>
          <v-icon>{{ item.model ? 'keyboard_arrow_up' : 'keyboard_arrow_down' }}</v-icon>
        </v-list-tile-action>
       
      </v-list-tile>
    <template v-for="(child, i) in item.children"     >
      <v-list-tile :to="child.href"  :key="i" ripple>
        <v-list-tile-action v-if="child.icon">
          <v-icon>{{ child.icon }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>
            &nbsp;{{ child.text }}
          </v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </template>
  </v-list-group>
 
    <v-list-tile v-else :to="item.href"  ripple>
      <v-list-tile-action>
        <v-icon>{{ item.icon }}</v-icon>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title>
          {{ item.text }}
        </v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>

</template>
</v-list>
</template>

<script>{
  props: ['items']
}
</script>
