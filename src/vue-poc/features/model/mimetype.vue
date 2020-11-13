<!DOCTYPE html>
<template id="mimetype">
<v-container fluid grid-list-md>
  <qd-table :headers="$MimeTypes.headers" :init-items="items" item-key="name" 
   :show-select="false" >
   <template v-slot:item.name="{ item }">
     <span>{{ item.name }} </span>
   </template>
   <template v-slot:item.icon="{ item }">
    <v-chip label>
      <v-icon left>
       {{item.icon }}
      </v-icon>
       {{item.icon }}
    </v-chip>
   </template>
   <template v-slot:actions>
         <v-list-item @click="remove">
           <v-list-item-avatar><v-icon>delete</v-icon></v-list-item-avatar>
           <v-list-item-title>Delete todo</v-list-item-title>
         </v-list-item>
   </template>
   </qd-table>
   
   
  </v-container>
</template>

<script>{
  data:  function(){
    return {
   	
   	  itemsPerPage: 100,
      page: 1,
      items:[],
      search: '',
      filter: {},
      loading: false,
      q: '',   
      selected:[]
      }
  },
  methods:{
    getItems(){
        this.items=this.$MimeTypes.list()
    },
    
    setfilter(){
      console.log("TODO",this.q);
      this.$router.push({ query: {url: this.url,
                                   q: this.q }})
    }
  },

  created:function(){
    this.getItems()
  },
}
</script>
