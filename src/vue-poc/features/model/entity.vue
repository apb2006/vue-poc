<!DOCTYPE html>
<template id="entity">
<v-container fluid grid-list-md>
  
    <v-data-iterator
       :items="items"
      :items-per-page.sync="itemsPerPage"
      :search="q"
      hide-default-footer
      select-all 
      :value="selected"
    >
    
     <template v-slot:header>
       <v-toolbar  >
			 <v-toolbar-title> 
			    <v-breadcrumbs :items="[{text:'Entities',to:'/model/entity'}]" >
						     <template slot="item" slot-scope="props">
					           <v-breadcrumbs-item  :to="props.item.to" :disabled="props.item.disabled" :exact="true">
					              <v-icon>add</v-icon>{{ props.item.text }}
					           </v-breadcrumbs-item>
					       </template>
		     </v-breadcrumbs>
		   </v-toolbar-title>
			  <v-spacer></v-spacer> 
			 <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
		   hide-details single-line  @keyup.enter="setfilter"
		   clearable></v-text-field>
		   <v-spacer></v-spacer>
			 <v-btn @click="getItems" icon
			  :loading="loading"
		      :disabled="loading"
			 ><v-icon>refresh</v-icon></v-btn>
		   <vp-entitylink entity="dice.entity"></vp-entitylink>
	 </v-toolbar>
	 </template>
	 
     <template v-slot:default="props">
        <v-layout wrap >
          <v-flex 
            v-for="item in props.items"
            :key="item.name"  align-items="flex-start"
          >
     
        <v-card :hover="true" active-class="default-class qd-active" max-width="20em" min-width="20em">
        
          <v-toolbar  color="blue lighten-3"  >
		          <v-toolbar-title>
		           <router-link :to="{path:'entity/'+ item.name}">
		            <v-avatar color="lime">
		             <v-icon  >{{ item.iconclass }}</v-icon> 
		            </v-avatar> {{ item.name }}
		            </router-link>
		            </v-toolbar-title>
		         </v-card-title>
		         <v-spacer></v-spacer>
		         <v-badge >
			      <span slot="badge">{{ item.nfields }}</span>
			    </v-badge>
          </v-toolbar>
          <v-card-text xs1 >{{ item.description }}</<v-card-text>
        </v-card>
      </v-flex>
      </v-layout>
      </template>
    </v-data-iterator>
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
