<!DOCTYPE html>
<!-- 
 image  keywords
 
 -->
<template id="keywords">
 <v-container fluid>
  <v-card >
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
     <v-chip >click to show</v-chip>   
    </v-card-title>
   
    <v-spacer></v-spacer> 
  <v-text-field   prepend-icon="search" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   :append-icon="this.q?'clear':''" :append-icon-cb="e=>this.q=''"></v-text-field>
    </v-toolbar>
    <v-card-text>
    <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
        <v-container v-if="!busy" fluid grid-list-md>
          <v-layout row wrap v-touch="{ left: () => pageNext(), right: () => pageBack()}">
            <v-flex height="80px" @click="show(keyword)"
              xs3
              v-for="keyword in items"
              :key="keyword.text"
            >
              <v-card   class="grey lighten-2 pt-1" >
                       <v-toolbar>
                 <v-card-title v-text="keyword.text"></v-card-title>
                <v-spacer></v-spacer>
                <v-chip>{{keyword.count}}</v-chip>
              </v-toolbar>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
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
    q:""
  }),

  methods:{
    getKeywords(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("images/keywords2")
      .then(r=>{
        this.busy=false
        this.total=r.data.total
        this.items=r.data.items
        var t1 = performance.now();
        this.elapsed= 0.001 *(t1 - t0) 
        }) 
    },
    show(keyword){
      this.$router.push({ name: 'images', query: { keyword: keyword.text }})
    },
    setfilter(){
      alert("not yet")
    }
  },
  created:function(){
    console.log("create keywords")
    this.getKeywords()
  }
}</script>
