<!DOCTYPE html>
<template id="map">
 <v-container fluid>
     <v-layout row wrap>
      <v-flex xs12 ref="page" v-resize="onResize" style="height:400px">
     <v-map :zoom="zoom" :center="center" >
      <v-tilelayer :url="url" :attribution="attribution"></v-tilelayer>
      <v-marker :lat-lng="marker"></v-marker>
    </v-map>
    </v-flex>
    </v-layout>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      zoom: 13,
      center: [54.320498718, -2.739663708],
      url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      marker: L.latLng(54.320498718, -2.739663708)
    }
  },
  methods:{
    onResize(){
      var el=this.$refs["page"]
      console.log("top",el.offsetTop)
      var h=Math.max(1,window.innerHeight - el.offsetTop)-60
       console.log("h",h)
      el.style.height=h +"px"
    }
  },
  created:function(){
    console.log("map")
  }
}
</script>
