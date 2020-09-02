<!DOCTYPE html>
<template id="entity1data">
<v-card >
	<v-toolbar>
	 <v-toolbar-title> 
         <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/entity', text:'Entities'}, {text: entity, disabled: false, menu: 'todo'}]"
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
                <v-list-item  >
                  <v-list-item-title  >View XML</v-list-item-title>
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
	  <pre>{{ data | pretty }}</pre>
  </v-container>
   </v-card>
</template>

<script>{
 
  props: ['entity'],
  data:  function(){
    return {
      data:  null,
      showmenu: false,
      loading: false,
    }
  },
  methods:{
    getItem(){
      this.loading=true
      HTTP.get("data/"+ this.entity)
      .then(r=>{
        this.loading=false
        this.data=Object.assign({}, this.item, r.data)
        console.log("data",this.data)
        }) 
    }
  },
 
  created:function(){
    this.getItem()
  },
}
</script>
