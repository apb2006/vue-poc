<!DOCTYPE html>
<template id="entity">
<v-card>
	<v-toolbar >
	 <v-toolbar-title> 
	    <v-breadcrumbs :items="[{text:'Entities',to:'/entity'}]" >
				     <template slot="item" slot-scope="props">
			           <v-breadcrumbs-item  :to="props.item.to" :disabled="props.item.disabled" :exact="true">
			                {{ props.item.text }}
			            </v-breadcrumbs-item>
			        </template>
         </v-breadcrumbs>
       </v-toolbar-title>
	 
	 <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   :append-icon="this.q?'clear':''" @click:append="e=>this.q=''"></v-text-field>
   <v-spacer></v-spacer>
	 <v-btn @click="getItems" icon
	  :loading="loading"
      :disabled="loading"
	 ><v-icon>refresh</v-icon></v-btn>
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
        <v-card :hover="true" active-class="default-class qd-active"  max-height="200px">
        
          <v-toolbar  color="blue lighten-3"  dense>
		          <v-card-title >
		           <router-link :to="{path:'entity/'+ props.item.name}">
		            
		            <v-icon>{{ props.item.iconclass }}</v-icon> {{ props.item.name }}
		            
		            </router-link>
		         </v-card-title>
          </v-toolbar>
          <v-card-text>{{ props.item.description }}</<v-card-text>
          <v-card-text>
           <v-badge >
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
