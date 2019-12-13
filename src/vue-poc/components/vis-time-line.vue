<!DOCTYPE html>
<!-- 
for vis-time-line http://visjs.org/docs/graph2d/
 -->
<template id="vis-time-line">
  <div></div>
</template>
<script>{ 
  props: ['items', 'groups', 'options','events'],
  data(){
    return {timeline:Object}
  },
  methods:{
    select(properties){
      this.$emit('select',properties.items);
    },
    rebuild(data){
    	var items = new vis.DataSet(data);
        //this.timeline = new vis.Timeline(this.$el, items, this.groups, this.options);
        this.timeline.setItems(items)
        this.timeline.fit(true)
    }
  },
  watch:{
	  items(newItems){
		  console.log("timeline new:" + newItems.length)
		  this.rebuild(newItems)
	  },
	  options(newOpts){
		  console.log("opts: ",newOpts)
	  }
  },
  mounted: function () {
   
    var options = this.options;
    var groups = this.groups;
    var items = new vis.DataSet(this.items);
    this.timeline = new vis.Timeline(this.$el, items, groups, options);
    this.timeline.on('select', this.select);
    if(this.events){
      this.events.$on('fit', (cmd) => {
        this.timeline.fit(true)
        })
    }
  }
}</script>
