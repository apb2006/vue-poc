<!DOCTYPE html>
<!-- 
 show list of available files
 -->
<template id="basexlogdate">
 <v-container fluid>
 <v-card>
 
   <v-toolbar >
   <v-toolbar-title>
    <v-breadcrumbs :items="crumbs" >
         <template slot="item" slot-scope="props">
             <v-breadcrumbs-item  :to="props.item.to" :disabled="props.item.disabled" :exact="true">
                  {{ props.item.text }}
              </v-breadcrumbs-item>
          </template>
     </v-breadcrumbs>
   </v-toolbar-title>
   <v-spacer></v-spacer>
   
   <v-text-field  prepend-icon="filter_list" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   clearable></v-text-field>
   
   <v-spacer></v-spacer>
      <v-btn @click="load" icon :loading="loading"
      :disabled="loading"
   ><v-icon>refresh</v-icon></v-btn>
   <vp-entitylink entity="basexlogfile"></vp-entitylink> 
   </v-toolbar>
   
   <v-card-text>
    <v-data-table
    :headers="headers"
    :items="items"
    :loading="loading"
    hide-default-footer
     :search="q"
    class="elevation-1"
  >
  
  <template v-slot:item.date="{ item }" > 
	      <td ><router-link :to="{path:'logdate/'+ item.date}">
                 {{ item.date }}
                </router-link></td>
    </template>
    
   <template v-slot:item.perhr="{ item }" > 
	      <td >
               <v-sparkline
    :value="points(item.perhr)"  :labels="labels" :fill="true"  height="30px" type="bar"
    :gradient="['red', 'orange', 'yellow','green','blue']"
    
  ></v-sparkline>  
          </td>
    </template> 
      
    <template slot="no-results">
        No matching results.
    </template>

  </v-data-table>
   </v-card-text>
   </v-card>
   </v-container>
</template>

<script>{
  data:  function(){
    return {
      items: [],
      loading: false,
      q: "",
      message: 'bad route!',
     
      selected:[],
      headers: [
        { text: 'Date', value: 'date' },
        {text: 'Entries', value: 'entries', align:"end" },
        {text: 'Max (secs)', value: 'max', align:"end" },
        {text: 'Rate', value: 'perhr' },
        { text: 'File name', value: 'name' }
        ],
      crumbs:[{to:"/logdate", text:"Log files"}],
      labels: [
          '.','.','.',
          '3am','.','.',
          '6am','.','.',
          '9am','.','.',
          'noon','.','.',
          '3pm','.','.',
          '6pm','.','.',
          '9pm','.','.'
        ],
      }
  },
  methods: {
    load(){
    
      this.loading= true
      HTTP.get("data/basexlogfile",{params:{q:this.q}})
      .then(r=>{
        this.items= r.data.items
        this.loading= false
        })
      
    },
    points(perhr){
      return perhr.split(' ').map(Number);
    },
    setfilter(){
      console.log("TODO",this.q)
      this.$router.push({  query: {url:this.url,q:this.q }})
    },
  },
  watch:{
    $route(vnew,vold){
      console.log("ROUTE",vnew,vold)    
      var url=this.$route.query.url
      this.url=url?url:"/";
      if(vnew.query.url != vold.query.url) this.load() 
    }
  },

  created:function(){
    this.q=this.$route.query.q || this.q;
    this.load();
    console.log("logfiles")
  }
}
</script>
