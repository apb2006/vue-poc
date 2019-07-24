<!DOCTYPE html>
<template id="services">
  <v-card >
   <v-toolbar >
     <v-text-field
        prepend-icon="filter_list"
        label="Filter jobs"
        single-line
        hide-details
        clearable
        v-model="search"
      ></v-text-field> 
      <v-spacer></v-spacer>
     <v-btn  
      @click="stop()"
      :disabled="noSelection"
    >Stop</v-btn>
   
      <v-btn icon ><v-icon>add</v-icon></v-btn>   
      <v-spacer></v-spacer>
      
       <v-btn
       icon
      :loading="loading"
      @click="getJobs()"
      @dblclick="autorefresh = !autorefresh"
      :disabled="loading"
    >
    <v-icon>{{ autorefresh?'refresh':'arrow_downward' }}</v-icon>
    </v-btn>
    </v-toolbar>
  <v-data-table
      :headers="headers"
      :items="items"
      :search="search"
       v-model="selected"
       select-all
      class="elevation-1"
      no-data-text="No Jobs currently running"
    >
    <template slot="items" slot-scope="props">
    <td class="vtop">
        <v-checkbox
          primary
          hide-details
          v-model="props.selected"
        ></v-checkbox>
      </td>
      <td class="vtop">  <router-link :to="{name: 'jobShow', params: {job: props.item.id }}">{{props.item.id}}</router-link></td>
      <td class="vtop "><div>{{ props.item.running }}</div>
      <td class="vtop " :title="props.item.interval">{{ props.item.interval }}</td>
      <td class="vtop " :title="props.item.base-uri">{{ props.item['base-uri'] }}</td>
       <td class="vtop ">{{ props.item.query }}</td>    
    </template>
  </v-data-table>
 </v-card>
</template>

<script>{
  data:  function(){
    return {
      headers: [
        {
          text: 'Job id',
          left: true,
          value: 'id'
        },
        { text: 'Running', value: 'running' },
        { text: 'Interval', value: 'interval' },
        { text: 'Base-uri', value: 'base-uri' },
        { text: 'Query', value: 'query' },

      ],
      items:[        
      ],
      selected: [],
      search: "",
      loading: false,
      autorefresh: true,
      timer:null
      }
  },
  methods:{
    load(){    
        this.loading= true
        HTTP.get("data/service",{params:{q:this.q}})
        .then(r=>{
          this.items= r.data.items
          this.loading= false
          if(this.autorefresh) this.timer=setTimeout(()=>{ this.load() }, 10000);
          })
        
      },
    stop(){
      var s=this.selected.map((j)=>{return j.id}).join(",")
      console.log("AAA",this.selected)
      alert(s)
    }
  },
  computed: {
    // a computed getter
    noSelection: function () {
      // `this` points to the vm instance
      return this.selected.length==0
    },
  },
  created(){
    this.load()
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
  }
}
</script>
