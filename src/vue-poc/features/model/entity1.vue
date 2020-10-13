<!DOCTYPE html>
<template id="entity1">
<v-card >
	<v-toolbar>
	 <v-toolbar-title> 
         <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/model/entity', text:'Entities'}, {text: entity, disabled: false, menu: 'todo'}]"
         >crumbs</qd-breadcrumbs> 
         </v-toolbar-title>   
          <v-menu  v-model="showmenu" >
            <template v-slot:activator="{ on }">
              <v-btn
                dark
                icon
                v-on="on"
              >
                <v-icon>mdi-dots-vertical</v-icon>
              </v-btn>
            </template>
            <v-list dense>
                <v-subheader >Views</v-subheader>
                <v-list-item >
                  <router-link :to="$route.path + '/data'">
                  <v-list-item-title  >Data {{ $route.path }}</v-list-item-title>
                  </router-link>
                </v-list-item>
                <v-list-item @click="getxml" >
                  <v-list-item-title  >View XML</v-list-item-title>
                </v-list-item>
                <v-list-item  >
                  <v-list-item-title ><a :href="dataurl" target="data">Json</a></v-list-item-title>
                </v-list-item>             
            </v-list>         
           </v-menu> 

	 <v-spacer></v-spacer>
	 
	 <v-btn icon @click="getItem"
	  :loading="loading"
      :disabled="loading"
	 ><v-icon>refresh</v-icon></v-btn>
	
	 </v-toolbar>

  <v-container fluid >
	  <v-expansion-panels  v-model="panel" multiple>
	    <v-expansion-panel  expand >
			     <v-expansion-panel-header>
			     <v-layout>
		          <v-flex xs12>
						     <v-avatar><v-icon>{{ item.iconclass }}</v-icon></v-avatar>
						     <span class="font-weight-black">{{ item.name }}</span> 
					         {{item.description}}
					 </v-flex>
			     </v-layout>        
			     </v-expansion-panel-header>
			     <v-expansion-panel-content>
			          <pre v-if="xml"><code>{{ xml }}</code></pre> 
			      </v-expansion-panel-content>
			      <v-expansion-panel>
	      </v-expansion-panel>
	       
	      <v-expansion-panel> 
           <v-expansion-panel-header><v-layout>
	          <v-flex xs12>Type: <code>{{ item.type }}</code></v-flex>
	          </v-layout>
          </v-expansion-panel-header>
		      <v-expansion-panel-content>
				  <prism language="xquery">{{ code(item) }}</prism>
		      </v-expansion-panel-content>
		</v-expansion-panel>
		
		<v-expansion-panel>
		<v-expansion-panel-header><v-layout>
          <v-flex xs12>
	               <span >Fields ({{ item.nfields }})</span>
	          </v-flex>
	          </v-layout>
	      </v-expansion-panel-header> 
	      <v-expansion-panel-content>
	           <qd-table :headers="headers" :data-uri='"data/entity/"+entity +"/field"' 
	           entity="dice.field" item-key="name" :show-select="false">
	          </qd-table>
	      </v-expansion-panel-content>
	     </v-expansion-panel>
	   </v-expansion-panels>
  </v-container>
   </v-card>
</template>

<script>{
  components: { 
    "prism": PrismComponent
    },
  props: ['entity'],
  data:  function(){
    return {
      item: {description:null,
             code: null
      },
      showmenu: false,
      loading: false,
      xml: null,
      selected: [],
      headers: [
        { text: 'Name', value: 'name', align: 'left'},
        { text: 'parent', value: 'parent', align: 'left' },
        {text: "type", value: "type"},
        {text: "description", value: "description"},
        {text: "xpath", value: "xpath"}
      ],
      panel: [1,2]
      }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/entity/"+this.entity)
      .then(r=>{
        this.loading=false
        this.item=Object.assign({}, this.item, r.data)
        }) 
    },
    code(item){
      return item.modules + " " +  item.namespaces + " " +item.code       
    },
    getxml(){
      HTTP.get("data/entity/"+this.entity,{ headers: {Accept: "text/xml"}})
      .then(r=>{
        this.xml=r.data;
            }) 
    },
    todo(){
      alert("TODO");
    }
  },
  computed: {
    dataurl(){
         return '/vue-poc/api/data/' + this.entity;
       },
       xquery(){
         return '/vue-poc/api/data/' + this.entity;
       }   
  },
  created:function(){
    this.getItem()
  },
}
</script>
