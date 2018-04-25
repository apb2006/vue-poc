<!DOCTYPE html>
<template id="tree2">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
   <v-card-title ><qd-link href="https://github.com/riophae/vue-treeselect">vue-treeselect@0.0.19</qd-link> </v-card-title>
   <v-spacer></v-spacer>
   <v-btn>todo</v-btn>
   </v-toolbar>
   <v-card-text>
    <treeselect
    v-model="value"
    :multiple="true"
    :options="source"
    />

   </v-card-text>
 </v-card>
 </v-container>
</template>

<script>{
  data:function(){
    return {
      value: null,
      source: [
        {
          id: 'node-1',
          label: 'Node 1',
          children: [
            {
              id: 'node-1-a',
              label: 'Node 1-A',
            } 
          ],
        },
        {
          id: 'node-2',
          label: 'Node 2',
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
