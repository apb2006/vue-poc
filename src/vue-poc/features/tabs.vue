<!DOCTYPE html>
<template id="tabs">
  <v-tabs  scroll-bars >
    <v-card >
      <v-card-actions>
          <v-btn icon >
            <v-icon>menu</v-icon>
          </v-btn>
          <v-card-title>Page Title</v-card-title>
          <v-spacer></v-spacer>
          <v-btn icon >
            <v-icon>search</v-icon>
          </v-btn>
          <v-btn icon >
            <v-icon>more_vert</v-icon>
          </v-btn>
        </v-card-actions>
    </v-card>
    
    <v-tabs-bar class="grey lighten-3" dense>
      <v-tabs-item
        v-for="i in 13"
        :key="i"
        :href="'#mobile-tabs-6-' + i"
      >
 
       <v-icon>favorite</v-icon>
       <span>Item {{ i }} more</span>
       <v-spacer></v-spacer>
       <v-btn small icon class="grey">
          <v-icon>close</v-icon>
        </v-btn>
      </v-tabs-item>
      <v-tabs-slider class="primary"></v-tabs-slider>
    </v-tabs-bar>
    
    <v-tabs-items>
     <v-tabs-content v-for="i in 13"
      :key="i"
      :id="'mobile-tabs-6-' + i">
      <v-card flat  >
        <v-card-text>{{i}} - {{ text }}</v-card-text>
      </v-card>
      </v-tabs-content>
    </v-tabs-items>
</v-tabs>
</template>

<script>{
    data () {
      return {
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
      }
    }
  }
</script>
