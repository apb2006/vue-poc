<!DOCTYPE html>
<!-- 
 search
 -->
<template id="qd-search">
  <v-combobox
              placeholder="Search..." prepend-icon="search"
              autocomplete
              :loading="loading"
              clearable
              :items="items2"
              @keyup.enter="goSearch"
              :search-input.sync="si" 
              v-model="q"
            ></v-combobox>
</template>

<script>{
  data:function(){return {
    q: "",
    loading: false,
    searchItems:[],
    si: '',
    items2:[{text:"todo", value:"TODO"},
            {text:"set", value:"SET"},
            {"text":"search",value:"SEARCH"}
            ]
  }
  },
  methods: {
    querySelections (v) {
      this.loading = true
      // Simulated ajax query
      setTimeout(() => {
        this.items2 = this.si?this.pages(this.si.toLowerCase()):[],
        this.loading = false
      }, 500)
    },
    
    goSearch(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
    pages(typed){
        var hits=this.$router.options.routes;
        console.log(hits.length,hits);
         hits=hits.filter(item=>{
           if (!item.meta) return false;
          var i=item.meta.title.toString().toLowerCase();
          console.log(i);
          return i.indexOf(typed) !== -1});
         
         console.log("pages",typed," r:",hits);
        return hits.map(r=>{return {text:r.meta.title,value:r.path}});
      }
  },
  watch: {
    si:function(val){
      console.log("si: ",val);
      this.querySelections();
    }
  }
}</script>
