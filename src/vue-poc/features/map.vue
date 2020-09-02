<!DOCTYPE html>
<template id="leaflet">
<v-container >
  <v-card hover raised> 
  <v-toolbar> 
    <v-card-title> 
      map
     </v-card-title>
	<v-spacer></v-spacer>
	 Center: {{ center }}, zoom is: {{ zoom }}
	</v-toolbar> 
	<v-card-text>
	 <v-row>
      <v-col style="height: calc(100vh - 210px);">  
  
     <l-map :zoom="zoom" :center="center" 
       @update:center="centerUpdate"
      @update:zoom="zoomUpdate"
     style="height:100%;">
      <l-tilelayer :url="url" :attribution="attribution"></l-tilelayer>
      <l-marker :lat-lng="marker"></l-marker>
    </l-map>
     </v-col>
     </v-row>
     </v-card-text>
     </v-card>
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
  methods: {
	  zoomUpdate(zoom) {
	      this.zoom = zoom;
	    },
	    centerUpdate(center) {
	      this.center = center;
	    },
  },
  watch:{
	 center: function(c){
		 const query = Object.assign({}, this.$route.query);
		 const isArray= Array.isArray(c)
		 query.center=isArray? c[0]+","+c[1] : c.lat + "," + c.lng 
		 this.$router.push({ query });
	 },
	 zoom: function(z){
		 const query = Object.assign({}, this.$route.query);
		 query.zoom= z 
		 this.$router.push({ query });
	 } 
  },
  created:function(){
    console.log("map")
    if(this.$route.query.center){
    	const c= this.$route.query.center.split(",").map(x=>parseFloat(x))
    	console.log("center",c)
    	this.center= c
    }
    if(this.$route.query.zoom){
    	const z= parseFloat(this.$route.query.zoom)
    	console.log("zoom",z)
    	this.zoom= z
    }
  }
}
</script>
