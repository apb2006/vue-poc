<!DOCTYPE html>
<template id="tree">
 <v-container fluid>
 TREE
<div id="canvasqPWKOg" class="canvas"></div>
<button id="resetButtonqPWKOg">Reset</button>
<div>
    <svg width="500" height="300"></svg>
    <br>
    <input
      type="range"
      v-model="circleSize"
      min="1"
      max="100"
      step="1"
    >
</div>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'bad route!',
      circleSize: 50
      }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  },
  mounted: function(createElement) {
    var svg = d3.select(this.$el).select('svg');
    this.circle = svg
      .append('circle')
      .attr('cx', '250')
      .attr('cy', '150')
      .attr('r', this.circleSize)
  },
  watch: {
    circleSize: function(newValue) {
      this.circle
        .attr('r', newValue)
    }
  }

}
</script>
