<!DOCTYPE html>
<!-- 
 image  dates
 
 -->
<template id="dates">
 <v-container fluid>
  <v-card >
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
     <v-chip >Images by year and month</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  
    </v-toolbar>
    <v-card-text>
     <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
<v-container v-if="!busy" fluid>
 <v-layout v-for="year in items"
              :key="year.year">
      <v-flex v-text="year.year"></v-flex> 
      <v-flex v-for="(m,i) in year.months" 
              :key="i"><v-btn icon primary :disabled="0==m" @click="go(year.year,i)">{{m}}</v-btn></v-flex>       
  </v-layout>            
</v-container>
<v-layout>
 </v-card-text>
 </v-card>
 </v-container>
</template>

<script>{  
  data: ()=>({
    busy: false,
    total: 0,
    items: [],
    elapsed: null,
    months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  }),

  methods:{
    getDatetaken(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("images/datetaken")
      .then(r=>{
        this.busy=false
        this.total=r.data.total
        this.items=r.data.items
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    },
    go(year,month){
     
      month=("0" + (1+month)).slice(-2)
      // alert("year: "+year+" "+month)
      var from=year + "-" + month + "-01"
      var lastday=new Date(year, month, 0).getDate()
      var until=year + "-" + month + "-"+ lastday
        this.$router.push({ name: 'images', query: { from:from, until:until }})
    }
  },
  created:function(){
    console.log("create datetaken")
    this.getDatetaken()
  }
    }
</script>
