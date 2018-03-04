<!DOCTYPE html>
<template id="svg2">
 <v-container fluid>
<!-- UI controls that can are used to manipulate the display of the chart -->
    
    <div class="controls">
      
      <div>
        <label>Chart width</label>
        <input type="range" v-model="settings.width" min="0" max="1000" />
      </div>
     
      <div>
        <label>Stroke color</label>
        <input type="color" v-model="settings.strokeColor" />
      </div>
      
      <div>
        <label>Search…</label>
        <input type="text" v-model="search" />
      </div>
      
      <button v-on:click="add">Add node</button>
       
      <div>
        Selected: {{ selected }}
      </div>
    </div>

    <!-- SVG that renders the chart based on the "width" and "height" setting from the Vue instance’s data object -->
    
    <svg v-bind:width="settings.width" v-bind:height="settings.height">
    
    <!-- In contrast to D3’s "select" methods, we define the graphical elements explicitely here and use the template syntax to loop through collections and bind properties such as "d" or "r" to those elements. -->
    
      <transition-group tag="g" name="line" >

        <!-- Links are represented as paths -->
        
        <path v-for="link in links" class="link" v-bind:key="link.id" v-bind:d="link.d" v-bind:style="link.style"></path>
        
      </transition-group>


      <!-- We can now also use events to elements that will call respective methods on the Vue instance --> 
      
      <transition-group tag="g" name="list">
        <g class="node" v-on:click="select(index, node)" v-for="(node, index) in nodes" v-bind:key="node.id" v-bind:style="node.style" v-bind:class="[node.className, {'highlight': node.highlight}]">

          <!-- Circles for each node -->  

          <circle v-bind:r="node.r" v-bind:style="{'fill': index == selected ? '#ff0000' : '#bfbfbf'}"></circle>

          <!-- Finally, text labels -->

          <text v-bind:dx="node.textpos.x" v-bind:dy="node.textpos.y" v-bind:style="node.textStyle">{{ node.text }}</text>

        </g>
      </transition-group>
    </svg>
 </v-container>
</template>

<script>{
  data: function() {
    return {
      csv: null,
      selected: null,
      search: "force",
      settings: {
        strokeColor: "#19B5FF",
        width: 960,
        height: 2000
      }
    };
  },
  mounted: function() {
    var that = this;

    d3.csv("flare.csv",
      function(error, data) {
        if (error) throw error;

        // Load the CSV data
        // After the CSV has been loaded, the computed properties will automatically re-compute (root, tree, and then nodes & links…)
      
        that.csv = data;
      }
    );
  },

  computed: {
    
    
    // once we have the CSV loaded, the "root" will be calculated
    
    root: function() {
      
      var that = this;

      if (this.csv) {
        var stratify = d3.stratify().parentId(function(d) {
          return d.id.substring(0, d.id.lastIndexOf("."));
        });

        // attach the tree to the Vue data object
        return this.tree(
          stratify(that.csv).sort(function(a, b) {
            return a.height - b.height || a.id.localeCompare(b.id);
          })
        );
      }
    },
    
    // the "tree" is also a computed property so that it is always up to date when the width and height settings change
    
    tree: function() {
      return d3
        .cluster()
        .size([this.settings.height, this.settings.width - 160]);
    },
    
      // Instead of enter, update, exit, we mainly use computed properties and instead of "d3.data()" we can use array.map to create objects that hold class names, styles, and other attributes for each datum
    
    nodes: function() {
      var that = this;
      if (this.root) {
        return this.root.descendants().map(function(d) {
          return {
            id: d.id,
            r: 2.5,
            className: "node" +
              (d.children ? " node--internal" : " node--leaf"),
            text: d.id.substring(d.id.lastIndexOf(".") + 1),
            highlight: d.id.toLowerCase().indexOf(that.search.toLowerCase()) != -1 && that.search != "",
            style: {
              transform: "translate(" + d.y + "px," + d.x + "px)"
            },
            textpos: {
              x: d.children ? -8 : 8,
              y: 3
            },
            textStyle: {
              textAnchor: d.children ? "end" : "start"
            }
          };
        });
      }
    },
    
      // Instead of enter, update, exit, we mainly use computed properties and instead of "d3.data()" we can use array.map to create objects that hold class names, styles, and other attributes for each datum
    
    links: function() {
      var that = this;

      if (this.root) {

        // here we’ll calculate the "d" attribute for each path that is then used in the template where we use "v-for" to loop through all of the links to create <path> elements

        return this.root.descendants().slice(1).map(function(d) {
          return {
            id: d.id,
            d: "M" + d.y + "," + d.x + "C" + (d.parent.y + 100) + "," + d.x + " " + (d.parent.y + 100) + "," + d.parent.x + " " + d.parent.y + "," + d.parent.x,
           
            // here we could of course calculate colors depending on data but for now all links share the same color from the settings object that we can manipulate using UI controls and v-model
            
            style: {
              stroke: that.settings.strokeColor
            }
          };
        });
      }
    }
  },
  methods: {
    add: function () {
     this.csv.push({
       id: "flare.physics.Dummy",
       value: 0
     })
    },
    select: function(index, node) {
      this.selected = index;
    }
  }

}
</script>
