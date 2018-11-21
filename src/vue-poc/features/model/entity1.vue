<!DOCTYPE html>
<template id="entity1">
<v-card >
	<v-toolbar>
	 <v-toolbar-title> 
         <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/entity', text:'Entities'}, {text: entity, disabled: false, menu: 'todo'}]"
         >crumbs</qd-breadcrumbs> 
         </v-toolbar-title>   
          <v-menu offset-y v-model="showmenu" activator=".todo">
            <v-list dense>
                <v-subheader >Actions</v-subheader>
                      <v-list-tile @click="getxml" >
                      <v-list-tile-title  >View XML</v-list-tile-title>
                    </v-list-tile>
                     <v-list-tile  >
                      <v-list-tile-title ><a :href="dataurl" target="data">Json</a></v-list-tile-title>
                </v-list-tile>             
            </v-list>         
           </v-menu> 

	 <v-spacer></v-spacer>
	 
	 <v-btn icon @click="getItem"
	  :loading="loading"
      :disabled="loading"
	 ><v-icon>refresh</v-icon></v-btn>
	
	 </v-toolbar>

  <v-container fluid grid-list-md>
  
    <v-expansion-panel v-model="panel" expand >
    <v-expansion-panel-content>
          <div slot="header" class="title">Description: </div>
         {{item.description}}
          <pre v-if="xml"><code>{{ xml }}</code></pre> 
      </v-expansion-panel-content>
      <v-expansion-panel-content>
		      <div slot="header" class="title">Type: <code>{{ item.type }}</code></div>
		       <prism language="xquery">{{ code(item) }}</prism>
      </v-expansion-panel-content>
      
      <v-expansion-panel-content>
          <div slot="header" class="title">
          <v-badge >
               <span slot="badge">{{ item.nfields }}</span>Fields
          </v-badge>
           </div>
           <qd-table :headers="headers" :data-uri='"data/entity/"+entity +"/field"' entity="entity.field" no-data-msg="Nothing found">

       </qd-table>
      </v-expansion-panel-content>
     </v-expansion-panel>
   
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
      panel: [true, false, true]
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
