<!DOCTYPE html>
<!-- card showing entity data table 
 talks to dataUri, example data-uri="data/basex.repo"
 all slots passed down from parent 
 slots:actions for selection
 @see https://stackoverflow.com/questions/50891858/vue-how-to-pass-down-slots-inside-wrapper-component
-->
<template id="qd-table">
  <v-card >
   <v-toolbar color="blue lighten-4">
    <slot name="title">
		   <vp-entitylink v-if="entity" :entity="entity"></vp-entitylink>
		   <v-toolbar-title>{{ title }}</v-toolbar-title>
    </slot>  
   <v-spacer></v-spacer>
    <v-text-field
        prepend-icon="filter_list"
        label="Filter..."
        single-line  hide-details
        v-model="queryL.filter"
        clearable
      ></v-text-field>
      
      <v-spacer></v-spacer>
       <v-menu v-if="selected.length" offset-y left>
               <template v-slot:activator="{ on }">
                       <v-btn icon  v-on="on">
	                       <v-badge  color="orange">
						       <span slot="badge">{{ selected.length  }}</span>
						       <v-icon>share</v-icon>
					       </v-badge>
                       </v-btn>         
               </template>
              <v-card >
              <v-app-bar dense color="cyan lighten-2" >
                  <v-card-title dense>Actions</v-card-title>
               </v-app-bar>
                  
               <v-card-text>
                  <v-list dense>
	                  <slot name="actions"></slot>                  
	                   <v-list-item @click="copy">
		                    <v-list-item-avatar><v-icon>content_copy</v-icon></v-list-item-avatar>
		                    <v-list-item-title>Copy selection</v-list-item-title>
	                   </v-list-item>
                  </v-list>
                 
           
                </v-card-text>
              </v-card>
         </v-menu>  
           
    <v-spacer></v-spacer>
     <v-btn
       icon 
      :loading="loading"
      :disabled="loading"      
      @click="getItems"
    >
    <v-icon>refresh</v-icon>
    </v-btn> 
     <v-menu offset-y left>
               <template v-slot:activator="{ on }">
                       <v-btn icon  v-on="on"><v-icon>settings</v-icon></v-btn>         
               </template>
              <v-card >
              <v-toolbar color="cyan lighten-1">
                  <v-card-title >Table settings</v-card-title>
                  </v-toolbar>
                  
               <v-card-text>          
               <v-list>
				  <v-list-item>
	                 <v-list-item-title>Show selection</v-list-item-title>
	                 <v-list-item-action ><v-switch  v-model="showSelectL"></v-switch> </v-list-item-action>
	              </v-list-item>
	              <v-list-item>
	                 <v-list-item-title>Multi-sort</v-list-item-title>
	                 <v-list-item-action ><v-switch  v-model="multiSortL"></v-switch> </v-list-item-action>
	              </v-list-item>
	              <v-list-item>
	                 <v-list-item-title>Auto-refresh</v-list-item-title>
	                 <v-list-item-action ><v-switch  v-model="autoRefreshL"></v-switch> </v-list-item-action>
	              </v-list-item>
               </v-list>
                </v-card-text>
                </v-card>
              </v-menu>
    </v-toolbar>
    <v-card-text>
   <v-data-table   
      :headers="headers"  :items="filtered" 
      v-model="selected" :item-key="itemKey"
      :search="queryL.filter"
      :items-per-page="10" 
      :show-select="showSelectL"
      :multi-sort="multiSortL"
      :loading="loading"
      class="elevation-1"
      :fixed-header="true"
      :no-data-text="noDataMsg"
     
    >
   <template v-for="(_, slot) of $scopedSlots" v-slot:[slot]="scope"><slot :name="slot" v-bind="scope"/></template>
   
  </v-data-table>
  </v-card-text>
  </v-card>
</template>

<script>{
  props: {
	  headers: {default: [ { text: 'Name', value: 'id'} ]},
	  dataUri:{  default: null},
	  itemKey:{ default: "id"},
	  noDataMsg:{  default: "No data found."},
	  title:{ default: "" },
	  entity:{  },
	  initItems: { default: function(){return []}},
	  query: {default: function(){return {filter:null}}},
	  showSelect: {  default: false  },
	  multiSort: {  default: false  },
	  filter: { default: function(){return []}},
	  customFilter: {default: function(value, search, item) {
	        return value != null &&
	          search != null &&
	          typeof value === 'string' &&
	          value.toString().indexOf(search) !== -1}
	  }
  },
  
  data:  function(){
    return {
      items: [],
      selected: [],
      loading: false,
      showSelectL: this.showSelect,
      multiSortL: this.multiSort,
      queryL: Object.assign({}, this.query),
      autoRefreshL: false
      }
  },
  
  methods:{
      getItems(){
        if(this.dataUri === null) {
        	 this.items= this.initItems
        } else {
	        this.loading=true;
	        HTTP.get(this.dataUri)
	        .then(r=>{
	           this.loading=false;
	           console.log("qd-table items:",r.data.items,"headers ",this.headers);
	           this.items=r.data.items;
	           if(this.autoRefreshL) this.timer=setTimeout(()=>{ this.getItems() }, 10000);
	        })
        }
     },
     
     copy(){
    	var flds=this.headers.map(h=>h.value)
    	var row=function(item){return flds.map(f=>item.hasOwnProperty(f)?item[f]:'').join(",")}
    	var txt=flds.join(",")
    	var txt=this.selected.map(item=>row(item)).join("\n")
    	txt= txt=flds.join(",") +"\n" + txt
    	navigator.clipboard.writeText(txt).then(function() {
  		  /* clipboard successfully set */
  		}, function() {
  		  alert("clipboard write failed")
  		});
    	
     }
 
  },
  
  watch:{
	  queryL:{
		  handler: function(nn){			 
				  console.log("filter new:", this.$router.path, this.queryL)
				  this.$route.addParamsToLocation(this.queryL)
				  this.getItems();
				  },
		  deep: true
	  },
	  initItems: function(n,o){
		  this.items=n
		  console.log("INIT-ITEMS: ",n)
	  }
  },
  computed:{
	  filtered:function(){
		var cons=this.filter
		console.log("filter", cons)
		var f=function(item){
			if(cons.length==0) return true
			var c=cons[0]
			return item[c.name]==c.value
		}
		return this.items.filter(f)  
	  }
  },
  created:function(){
    console.log("qd-table");
    var q= this.$route.query
    if(q){this.queryL= q}
    this.getItems();
  }
}
</script>
