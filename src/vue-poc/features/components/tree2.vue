<!DOCTYPE html>
<template id="tree2">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
   <v-card-title ><qd-link href="https://github.com/riophae/vue-treeselect">vue-treeselect@0.0.29</qd-link> </v-card-title>
   <v-spacer></v-spacer>
   <v-btn>todo</v-btn>
   </v-toolbar>
   <v-card-text>
     <v-layout row wrap>
     <v-flex xs4 >
     Select some things:
     </v-flex>
      <v-flex xs4 >
		    <treeselect
		    v-model="value"
		    :multiple="true"
		    :options="source"
		    />
    </v-flex>
    
    <v-flex xs4>
       <pre>{{ value }}</pre>
    </v-flex>
   </v-layout>
   </v-card-text>

 </v-card>
 </v-container>
</template>

<script>{
  //components: { Treeselect },
  
  data:function(){
    return {
      value: [
        "DITA",
        "CSS",
        "Linking",
        "Hardware-basedProcessing"
      ],
      source: []
    }
  },
methods: {
  itemClick (node) {
    console.log(node.model.text + ' clicked !')
  },
  load(){
    HTTP.get("components/tree")
    .then(r=>{
      console.log(r);
      this.source=r.data
      })
      .catch(error=> {
        console.log(error);
       
        alert("Get query error"+url)
      });
    
  },
},
created:function(){
  this.load()
}

}
</script>
