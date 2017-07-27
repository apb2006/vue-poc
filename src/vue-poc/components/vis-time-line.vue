<!DOCTYPE html>
<!-- 
for vis-time-line
 -->
<template id="vis-time-line">
  <div></div>
</template>
<script>{ 
  props: ['items', 'groups', 'options'],
  methods:{
    select(properties){
      //alert('selected items: ' + properties.items);
    }
  },
  mounted: function () {
    var items = new vis.DataSet(this.items);
    var options = this.options;
    var groups = this.groups;
    var timeline = new vis.Timeline(this.$el, items, groups, options);
    timeline.on('select', this.select);
  }
}</script>
