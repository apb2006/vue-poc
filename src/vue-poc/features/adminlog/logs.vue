<!DOCTYPE html>
<template id="log">
 <v-container fluid>
  <v-card >
   <v-toolbar >
       <v-btn
       icon
      :loading="loading"
      @click="getItems()"
      :disabled="loading"
    >
    <v-icon>refresh</v-icon>
    </v-btn>   
      <v-spacer></v-spacer>
      <v-text-field
        append-icon="search"
        label="Filter logs"
        single-line
        hide-details
        v-model="search"
      ></v-text-field>
     
    </v-toolbar>
  <v-data-table
      :headers="headers"
      :items="items"
      :search="search"
      class="elevation-1"
      no-data-text="No logs found"
      v-bind:pagination.sync="pagination"
    >
    <template slot="items" slot-scope="props">
      <td class="text-xs-right">{{ props.item.time }}</td>
      <td class="text-xs-right">{{ props.item.user }}</td>
      <td class="text-xs-right">{{ props.item.type }}</td>
      <td class="text-xs-right">{{ props.item.ms }}</td>
      <td ><code>{{ props.item.text }}</code></td>
       <td class="text-xs-right">{{ props.item.address }}</td>
    </template>
  </v-data-table>
 </v-card>
</template>

<script>{
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      q:this.$route.query.q,
      headers: [
        {
          text: 'time',
          left: true,
          value: 'time'
        },
        { text: 'user', value: 'user' },
        { text: 'Type', value: 'type' },
        { text: 'ms', value: 'ms' },
        { text: 'text', value: 'text' },
        { text: 'address', value: 'address' },
      ],
      items:[],
      pagination:{sortBy: 'time',descending:true,rowsPerPage:25},
      selected:[],
      search:"",
      loading:false,
      timer:null
      }
  },
  methods:{
    getItems(){
      this.loading=true
      HTTP.get("log",{params:this.q})
      .then(r=>{
        this.loading=false
        //console.log(r.data)
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        this.items=r.data.items
        this.timer=setTimeout(()=>{ this.getItems() }, 5000);
        }) 
    }
  },
  created:function(){
    this.getItems()
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
  }
}
</script>
