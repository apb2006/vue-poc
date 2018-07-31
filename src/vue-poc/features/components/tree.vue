<!DOCTYPE html>
<template id="tree">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
   <v-card-title ><qd-link href="https://github.com/zdy1988/vue-jstree">vue-jstree@2.1.16</qd-link> </v-card-title>
   <v-spacer></v-spacer>
   <v-btn>todo</v-btn>
   </v-toolbar>
   
    <v-card-text>
     {{ selected }}
    </v-card-text>
    
   <v-card-text>
   <v-layout>
  
   <v-flex xs6>
    <v-jstree :data="data" text-field-name="label" ref="tree" :async="loadData"
    show-checkbox multiple allow-batch whole-row @item-click="itemClick"></v-jstree>
    </v-flex>
    <v-flex xs6>
    <pre>
    {{ JSON.stringify(data, null, '\t') }}
    </pre>
    </v-flex>
   </v-layout>
   

   </v-card-text>
 </v-card>
 </v-container>
</template>

<script>{
  data:function(){
    return {
		  data: [],
		   
		  loadData: function (oriNode, resolve) {
		    var id = oriNode.data.id ? oriNode.data.id : 0
		    console.log("LOAD DATA",id);
		    HTTP.get("components/tree")
		    .then(r=>{
		      console.log(r);
		      resolve(r.data)
		      })
		      .catch(error=> {
		        console.log(error);
		       
		        alert("Get query error"+url)
		      });
		  }
	  }
  },
  
methods: {

  itemClick (node) {
    node.model.selected= !node.model.selected;
    console.log(' clicked !',node.model)
  },
  
  load(){
    this.asyncData = [this.$refs.tree.initializeLoading()];
    this.$refs.tree.handleAsyncLoad(this.asyncData, this.$refs.tree)
  },
  
  sel1(item){
    if(item.children){
      var res=[];
      for (const node of item.children) {res.push(this.sel1(node))}
      return res;
    }else{
      return item.selected?item.label:[]
    }
  }
},

computed:{
  selected(){
    return this.sel1(this.data);
  },
},
mounted: function(){
  this.load()
}

}
</script>
