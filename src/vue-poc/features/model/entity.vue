<!DOCTYPE html>
<template id="entity">
<v-card>
	<v-toolbar >
	 <v-toolbar-title>Entities</v-toolbar-title>
	 <v-spacer></v-spacer>
	 <v-btn @click="getItems"
	  :loading="loading"
      :disabled="loading"
	 >Refresh</v-btn>
	 </v-toolbar>

  <v-container fluid grid-list-md>
  
    <v-data-iterator
      content-tag="v-layout"
      row
      wrap
      :items="items"
      :rows-per-page-items="rowsPerPageItems"
      :pagination.sync="pagination"
      select-all 
      :value="selected"
    >
      <v-flex
        slot="item"
        slot-scope="props"
        xs12
        sm6
        md4
        lg3
      >
        <v-card>
       
          <v-card-title>
           <router-link :to="{path:'entity/'+ props.item.name}">
            <h4>
            <v-icon>{{ props.item.iconclass }}</v-icon> {{ props.item.name }}
            </h4>
            </router-link>
         </v-card-title>
          
          <v-card-text>{{ props.item.description }}</<v-card-text>
          <v-card-actions>
          <v-list dense>
            <v-list-tile>
              <v-list-tile-content>Fields:</v-list-tile-content>
              <v-list-tile-content class="align-end">{{ props.item.nfields }}</v-list-tile-content>
            </v-list-tile>
          </v-list>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-data-iterator>
  </v-container>
   </v-card>
</template>

<script>{
  data:  function(){
    return {
      q: 'filter',
      items: [],
      loading: false,
      rowsPerPageItems: [4, 8, 20],
      pagination: {
        rowsPerPage: 20
      },
      selected:[]
      }
  },
  methods:{
    getItems(){
      this.loading=true
      HTTP.get("data/entity",{params:this.q})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.items=r.data.items
        }) 
    }
  },
  created:function(){
    this.getItems()
  },
}
</script>
