<!DOCTYPE html>
<template id="leaflet">
 <v-container fluid>
     <v-layout row wrap>
      <v-flex xs12 style="height:400px">
     <l-map :zoom="zoom" :center="center" >
      <l-tilelayer :url="url" :attribution="attribution"></l-tilelayer>
      <l-marker :lat-lng="marker"></l-marker>
    </l-map>
    </v-flex>
    </v-layout>
 </v-container>
</template>

<script>{
//leaflet
 components: {
    "l-map": Vue2Leaflet.LMap,
    "l-tilelayer": Vue2Leaflet.LTileLayer,
    "l-marker": Vue2Leaflet.LMarker
   },
  
  data:  function(){
    return {
      zoom: 13,
      center: [54.320498718, -2.739663708],
      url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      marker: L.latLng(54.320498718, -2.739663708)
    }
  },
  created:function(){
    console.log("map")
  }
}
</script>
