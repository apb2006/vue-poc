<!DOCTYPE html>
<template id="svg2">
 <v-container fluid>
   <h5 class="title">Svg.</h5>
	<div  ref="svgcanvas" class="canvas"></div>
	<v-btn @click="view.reset()">Reset</v-btn>
 </v-container>
</template>

<script>{
  data: function() {
    return {
      canvasd3:null,
      view:null,
      url:"https://gist.githubusercontent.com/billdwhite/496a140e7ab26cef02635449b3563e54/raw/50a49bfbcafbe1005cba39a118e8b609c4d4ca29/butterfly.svg"
    };
  },
  methods:{
    
  },
  mounted: function() {
    this.canvasd3 = d3.select(this.$refs.svgcanvas);
    /** RUN SCRIPT **/
    var canvasWidth = 800;

    var canvas = d3.demo.canvas().width(435).height(400);
    this.view=canvas;
    this.canvasd3.call(canvas);
    function addItem(item) {
      canvas.addItem(d3.select(item));
    };

    d3.xml(this.url,
          function(error, xml) {
        if (error) throw error;
        addItem(xml.documentElement);
    });

  }

}
</script>
