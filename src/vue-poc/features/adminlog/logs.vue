<!DOCTYPE html>
<!-- 
 log as data table
 -->
<template id="log">
 <v-container fluid>
  <v-card >
   <v-toolbar >
    <v-toolbar-title>Logs
    </v-toolbar-title>
    <v-spacer></v-spacer>
      <v-text-field
        prepend-icon="filter_list"
        label="Filter logs"
        single-line
        hide-details
        clearable
        v-model="search"
      ></v-text-field>
     
        <v-btn
       icon :color="autorefresh?'green':''"
      :loading="loading"
      :disabled="loading"      
      @click="getItems"
      @dblclick="toggle"

    >
    <v-icon>refresh</v-icon>
    </v-btn>
    
      <v-btn
               to="add" append
              small
              absolute
              bottom
              right
              fab
            >
              <v-icon>add</v-icon>
       </v-btn>
     <v-spacer></v-spacer>
      <v-menu bottom left min-width="300px">
      
       <template v-slot:activator="{ on }">
            <v-btn icon v-on="on" >
              <v-icon>settings</v-icon>
            </v-btn>
         </template>
         
         <v-list subheader>
          <v-subheader>Settings</v-subheader>
              
              <v-list-item  >
                <v-list-item-title><v-switch label="Auto Refresh" v-model="autorefresh"></v-switch></v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
    </v-toolbar>
  <v-data-table
      :headers="headers"
      :items="items"
      :search="search"
      class="elevation-1"
      no-data-text="No logs found"
      sort-by= "time"
      v-bind:options.sync="pagination"
    >
    <template slot="items" slot-scope="props">
      <td   :title="props.item.time">{{ props.item.time  }}</td>
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
      pagination:{ rowsPerPage:25},
      selected:[],
      search:"",
      loading:false,
      timer:null,
      autorefresh: true
      }
  },
  methods:{
    address(text){
      return "%" + text;
    },
    getItems(){
      this.loading=true
      HTTP.get("basex.log",{params:this.q})
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
