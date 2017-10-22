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
    }
  },
  mounted: function () {
    var items = new vis.DataSet(this.items);
    var options = this.options;
    var groups = this.groups;
    this.timeline = new vis.Timeline(this.$el, items, groups, options);
    this.timeline.on('select', this.select);
    if(this.events){
      this.events.$on('fit', (cmd) => {
        this.timeline.fit(true)
        })
    }
  }
}</script>
