<!DOCTYPE html>
<template id="log">
 <v-container fluid>
  <v-card >
   <v-toolbar >
   
    
    
      <v-btn icon to="add" append>
          <v-icon>add_circle</v-icon>
    </v-btn>
       
     
      <v-text-field
        append-icon="search"
        label="Filter logs"
        single-line
        hide-details
        v-model="search"
      ></v-text-field>
     
        <v-btn
       icon :color="autorefresh?'red':'green'"
      :loading="loading"
      @click="getItems"
      @dblclick="toggle"
      :disabled="loading"
    >
    <v-icon>refresh</v-icon>
    </v-btn>
     <v-spacer></v-spacer>
      <v-menu offset-y left>
             <v-btn icon  slot="activator"><v-icon>settings</v-icon></v-btn>
              <v-card >
              <v-toolbar class="green">
                  <v-card-title >Settings  TODO</v-card-title>
                  </v-toolbar>
                <v-card-text>
                <v-btn @click="autorefresh= ! autorefresh">Autorefresh</v-btn>
                </v-card-text>
                </v-card>
              </v-menu>
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
      timer:null,
      autorefresh: true
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
        if(this.autorefresh){
          this.timer=setTimeout(()=>{ this.getItems() }, 5000);
        }
        }) 
    },
    toggle(){
      alert("toggle auto");
      this.autorefresh= !this.autorefresh;
    }
  },
  created:function(){
    this.getItems()
  },
  beforeRouteLeave(to, from, next){
    this.autorefresh=false;
    if(this.timer) clearTimeout(this.timer);
    return next()
  }
}
</script>
