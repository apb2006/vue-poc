<!DOCTYPE html>
<template id="tabs">
<div>
  <v-toolbar   tabs>
      <v-toolbar-side-icon></v-toolbar-side-icon>
      <v-toolbar-title>{{ currentItem }}</v-toolbar-title>
      <v-spacer></v-spacer>
        <qd-fullscreen></qd-fullscreen>
      <v-btn icon>
        <v-icon>search</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>more_vert</v-icon>
      </v-btn>
  <v-tabs fixed-tabs  
        v-model="currentItem"

        slot="extension">
        
      <v-tab
        v-for="i in items"
        :key="i"
        :href="'#tab-' + i"
      >
       <v-avatar 
               size="20px">
       <v-icon>favorite</v-icon>
       </v-avatar>
       <span>{{ i }}</span>
       <v-spacer></v-spacer>
       <v-btn icon>
          <v-icon>close</v-icon>
        </v-btn>
      </v-tab>
      
     <v-menu left bottom class="tabs__div" >
          <a class="tabs__item" slot="activator">
          More
            <v-icon>arrow_drop_down</v-icon>
          </a>
          <v-list   class="grey lighten-3">
            <v-list-tile avatar
              v-for="item in items"
              :key="item"
              @click="currentItem = 'tab-' +item"
            >
             <v-list-tile-avatar>
               <v-icon v-if="currentItem === ('tab-' + item)">close</v-icon>
              </v-list-tile-avatar>
              <v-list-tile-content>
              {{ item }}
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-menu>
     </v-tabs>
  </v-toolbar>
        
 <v-tabs-items v-model="currentItem">
       <v-tab-item
        v-for="item in items"
        :key="item"
        :id="'tab-' + item"
      >
      <v-card flat  >
        <v-card-text>{{ item }} - {{ text }}</v-card-text>
      </v-card>
      </v-tab-item>
 </v-tabs-items>
</div>
</template>

<script>{
    data () {
      return {
        currentItem: 'tab-News',
        items: [
          'Web', 'Shopping', 'Videos', 'Images', 'News', 'Maps', 'Books', 'Flights', 'Apps'
        ],
       
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
    }
  }
}</script>
