<!DOCTYPE html>
<template id="tree">
 <v-container fluid>
 <v-card>
   <v-toolbar  card color="grey lighten-3"> 
		   <v-card-title >Taxonomy test</v-card-title>
		   <v-spacer></v-spacer>
		   <v-btn>todo</v-btn>
   </v-toolbar>

     <v-card-text>
       <v-layout >
      
       <v-flex xs6 >
       <v-sheet class="pa-3 primary lighten-2">
      <v-text-field
        v-model="search"
        label="Filter tag"
        flat
        solo-inverted
        hide-details
        clearable
      ></v-text-field>
      <v-checkbox
        v-model="caseSensitive"
        dark
        hide-details
        label="Case sensitive search"
      ></v-checkbox>
    </v-sheet>
        <v-treeview :items="items" item-text="label"
            v-model="tree"  :search="search"
            :open.sync="open" activatable
            active-class="grey lighten-4 indigo--text"
            selected-color="indigo"
            open-on-click
            selectable>
           <template slot="prepend" slot-scope="{ item, open }">
				      <v-icon v-if="item.children">
				        {{ open ? 'folder_open' : 'folder' }}
				      </v-icon>
				      <v-icon v-else>
				        {{ 'label' }}
				      </v-icon>
				    </template>
         </v-treeview>
        </v-flex>
        <v-divider vertical></v-divider>
        <v-flex xs6>
          <div
            v-if="tree.length === 0"
            key="title"
            class="title font-weight-light grey--text pa-3 text-xs-center"
          >
            Select some tags
          </div>

          <v-scroll-x-transition
            group
            hide-on-leave
          >
            <v-chip
              v-for="leaf, i) in tree"
              :key="i"
              color="grey"
              dark
              small
            >
              <v-icon left small>label</v-icon>
              {{ leaf }}
            </v-chip>
          </v-scroll-x-transition>
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
		  items: [],
		  tree: [],
	    search: null,
	    open: [1, 2],
	    caseSensitive: false
	  }
  },
  
methods: {

},

computed:{

},

created:function(){
  HTTP.get("components/tree")
  .then(r=>{
    console.log("loaded tree:",r);
    this.items= r.data;
    })
}

}
</script>
