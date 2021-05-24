<!DOCTYPE html>
<template id="svg2" >
<div ref="panel" v-resize="onResize" >
  <v-toolbar dense>
	  <v-btn @click="view.reset()">Reset</v-btn>
	   <v-btn @click="size()">Size</v-btn>
	     <v-select
          v-model="url"
          combobox clearable open-on-clear
          :items="svgs"
        ></v-select>
	   
	    <v-btn @click="load()">set</v-btn>
  </v-toolbar>
  <div id="viewport"  style="width:600px; height:400px; background-color:yellow;">
	 <div id="map"></div>
	 <div id="minimap"  style="position: absolute;right:5px; top:5px;  border:1px solid black; background-color: lime;"></div>
  </div>	
</div>
</template>

<script>{
  data: function() {
    return {

      url:"/vue-poc/ui/resources/svg/butterfly.svg",
      svgs:["/vue-poc/ui/resources/svg/butterfly.svg",
            "/vue-poc/ui/resources/svg/tiger.svg"]
    };
  },
  methods:{
       
    onResize(){
      var el=this.$refs["panel"];
       
      //console.log("top",e.offsetTop)
      var h=Math.max(1,window.innerHeight - el.offsetTop -10);
      var w=Math.max(1,window.innerWidth- el.offsetLeft ) 
      console.log("resize:",w,h)
      el.style.height=h +"px";
    },
    
  go(){
    	d3.svg(this.url).then( (xml)=> {
    		   
    		   let width = parseInt( d3.select('#viewport').style('width') );
    		   let height = parseInt( d3.select('#viewport').style('height') );
    		   
    		   document.querySelector('#map').appendChild(xml.documentElement.cloneNode(true));
    		   document.querySelector('#minimap').appendChild(xml.documentElement.cloneNode(true));
    		   
    		   
    		   let map = d3.select('#map').select('svg')
    		   let minimap = d3.select('#minimap').select('svg')
    		                    .attr('width', 200);
    		   
    		   let transform = d3.zoomIdentity.translate(0, 0).scale(1);
    		   
    		   let zoom = d3.zoom()
    		      .scaleExtent([1, 3])
    		      .on('zoom', zoomed);
    		   
    		   map.call(zoom)
    		      .call(zoom.transform, transform);
    		   
    		   function zoomed() {
    		      let mapMainContainer = map.select('#main_container')
    		         .attr('transform', d3.event.transform);
    		      
    		      minimap.select('#minimapRect').remove();
    		      
    		      let mapWidth = parseFloat( d3.select('#map').style('width') );
    		      let mapHeight = parseFloat( d3.select('#map').style('height') );
    		      let factor = mapWidth / d3.select('#map svg').attr('viewBox').split(' ')[2]
    		      
    		      let dx = d3.event.transform.x / d3.event.transform.k;
    		      let dy = d3.event.transform.y / d3.event.transform.k;
    		      
    		      let minimapRect = minimap.append('rect')
    		          .attr('id', 'minimapRect')
    		          .attr('width', mapWidth / factor / d3.event.transform.k )
    		          .attr('height', mapHeight / factor / d3.event.transform.k )
    		          .attr('stroke', 'red')
    		          .attr('stroke-width', 10)
    		          .attr('fill', 'none')
    		          .attr('transform', `translate(${-dx},${-dy})`);
    		   }
    		})
	
    }
  },
  
  watch:{
    url(v){
      this.$router.push({  query: { url: this.url }})
      },
      $route(vnew,vold){
        //console.log("ROUTE",vnew,vold)    
        var url=this.$route.query.url
        this.url=url?url:"/vue-poc/ui/resources/svg/butterfly.svg";
        if(vnew.query.url != vold.query.url) this.load() 
      }
  },
  
  mounted: function() {
    var url=this.$route.query.url
    this.url=url?url:"/vue-poc/ui/resources/svg/butterfly.svg";
    this.go();
   

  }

}
</script>
