<!DOCTYPE html>
<template id="tree">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
   <v-card-title ><qd-link href="https://github.com/zdy1988/vue-jstree">vue-jstree@1.0.11</qd-link> </v-card-title>
   <v-spacer></v-spacer>
   <v-btn>todo</v-btn>
   </v-toolbar>
   <v-card-text>
    <v-jstree :data="data" show-checkbox multiple allow-batch whole-row @item-click="itemClick"></v-jstree>

   </v-card-text>
 </v-card>
 </v-container>
</template>

<script>{
  data:function(){
    return {
  data: [
    {
      "text": "Same but with checkboxes",
      "children": [
        {
          "text": "initially selected",
          "selected": true
        },
        {
          "text": "custom icon",
          "icon": "fa fa-warning icon-state-danger"
        },
        {
          "text": "initially open",
          "icon": "fa fa-folder icon-state-default",
          "opened": true,
          "children": [
            {
              "text": "Another node"
            }
          ]
        },
        {
          "text": "custom icon",
          "icon": "fa fa-warning icon-state-warning"
        },
        {
          "text": "disabled node",
          "icon": "fa fa-check icon-state-success",
          "disabled": true
        }
      ]
    },
    {
      "text": "Same but with checkboxes",
      "opened": true,
      "children": [
        {
          "text": "initially selected",
          "selected": true
        },
        {
          "text": "custom icon",
          "icon": "fa fa-warning icon-state-danger"
        },
        {
          "text": "initially open",
          "icon": "fa fa-folder icon-state-default",
          "opened": true,
          "children": [
            {
              "text": "Another node"
            }
          ]
        },
        {
          "text": "custom icon",
          "icon": "fa fa-warning icon-state-warning"
        },
        {
          "text": "disabled node",
          "icon": "fa fa-check icon-state-success",
          "disabled": true
        }
      ]
    },
    {
      "text": "And wholerow selection"
    }
  ]
}
  },
methods: {
  itemClick (node) {
    console.log(node.model.text + ' clicked !')
  }
}

}
</script>
