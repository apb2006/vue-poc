<!DOCTYPE html>
<template id="entity1">
<v-card>
	<v-toolbar >
	 <v-toolbar-title> 
	 <v-breadcrumbs >
            <v-breadcrumbs-item  to="/entity" :exact="true">
            Entities
            </v-breadcrumbs-item>
            
              <v-breadcrumbs-item  >
              <v-chip>
              <v-avatar>
              <v-icon>{{ item.iconclass }}</v-icon>
              </v-avatar> 
            {{ entity }}
            </v-chip>
            </v-breadcrumbs-item>
        </v-breadcrumbs>
	 </v-toolbar-title>
	 <v-spacer></v-spacer>
	 <v-btn icon @click="getItem"
	  :loading="loading"
      :disabled="loading"
	 ><v-icon>refresh</v-icon></v-btn>
	 
	  <v-btn @click="getxml"
    :loading="loading"
      :disabled="loading"
   >XML</v-btn>
   
   <a :href="dataurl" target="data">Data</a>
	 </v-toolbar>

  <v-container fluid grid-list-md>
  <div v-if="item">
    <div>{{item.description}}</div>
   </div>
   
    <v-expansion-panel v-model="panel" expand >
    
      <v-expansion-panel-content>
		      <div slot="header" class="title">Type: <code>{{ item.type }}</code></div>
		       <prism language="xquery">{{ item.modules }}</prism>
		       <prism language="xquery">{{ item.namespaces }}</prism>
		      <prism language="xquery">{{ item.code }}</prism>
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
      panel: [false, true]
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
    getxml(){
      HTTP.get("data/entity/"+this.entity,{ headers: {Accept: "text/xml"}})
      .then(r=>{
        console.log(r.data)
        this.xml=r.data;
            }) 
    }
  },
  computed: {
    dataurl(){
         return '/vue-poc/api/data/' + this.entity;
       }
  },
  created:function(){
    this.getItem()
  },
}
</script>
