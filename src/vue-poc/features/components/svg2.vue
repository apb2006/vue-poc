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
	
	 <div  ref="svgcanvas"  style="width:100%;height:100%;background-color:yellow;"></div>
</div>
</template>

<script>{
  data: function() {
    return {
      canvasd3:null,
      view:null,
      url:"/vue-poc/ui/resources/svg/butterfly.svg",
      svgs:["/vue-poc/ui/resources/svg/butterfly.svg",
            "/vue-poc/ui/resources/svg/tiger.svg"]
    };
  },
  methods:{
    size(){
      this.view.width(200).height(200).render();
    },
    
    load(){
      var that=this;
      d3.xml(this.url,
          function(error, xml) {
        if (error) {
          //alert("load err");
          throw error;
        }
        var d=d3.select(xml.documentElement)
        that.view.setItem(d);
    });
    },
    
    onResize(){
      var el=this.$refs["panel"];
       
      //console.log("top",e.offsetTop)
      var h=Math.max(1,window.innerHeight - el.offsetTop -10);
      var w=Math.max(1,window.innerWidth- el.offsetLeft ) 
      console.log("resize:",w,h)
      el.style.height=h +"px";
      if(this.view ){
        this.view.height(h-20);
       this.view.render();
      }
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
    this.canvasd3 = d3.select(this.$refs.svgcanvas);
    /** RUN SCRIPT **/
    var canvasWidth = 800;

    var canvas = d3.demo.canvas().width(canvasWidth).height(400);
    this.view=canvas;
    this.canvasd3.call(canvas);
    
    this.load();
   

  }

}
</script>
