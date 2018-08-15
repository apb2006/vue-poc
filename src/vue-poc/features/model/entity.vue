<!DOCTYPE html>
<template id="entity">
<v-card>
	<v-toolbar >
	 <v-toolbar-title> 
	    <v-breadcrumbs >
            <v-breadcrumbs-item  to="/entity" :exact="true">
            Entities
            </v-breadcrumbs-item>
       </v-toolbar-title>
	 <v-spacer></v-spacer>
	 <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   :append-icon="this.q?'clear':''" @click:append="e=>this.q=''"></v-text-field>
	 <v-btn @click="getItems"
	  :loading="loading"
      :disabled="loading"
	 >Refresh</v-btn>
   <vp-entitylink entity="entity"></vp-entitylink>
	 </v-toolbar>

  <v-container fluid grid-list-md>
  
    <v-data-iterator
      content-tag="v-layout"
      row
      wrap
      :loading="loading"
      :items="items"
      :search="q"
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
        <v-card :hover="true" active-class="default-class qd-active" >
        
          <v-toolbar  color="amber">
		          <v-card-title >
		           <router-link :to="{path:'entity/'+ props.item.name}">
		            <h3>
		            <v-icon>{{ props.item.iconclass }}</v-icon> {{ props.item.name }}
		            </h3>
		            </router-link>
		         </v-card-title>
          </v-toolbar>
          <v-card-text>{{ props.item.description }}</<v-card-text>
          <v-card-text>
           <v-badge color="red">
			      <span slot="badge">{{ props.item.nfields }}</span>
			      Fields
			    </v-badge>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-data-iterator>
  </v-container>
   </v-card>
</template>

<script>{
  data:  function(){
    return {
      q: '',
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
      HTTP.get("data/entity",{params:{q:this.q}})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.items=r.data.items
        }) 
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
