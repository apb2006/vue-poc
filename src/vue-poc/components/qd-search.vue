<!DOCTYPE html>
<!-- 
 search
 -->
<template id="qd-search">
  <v-select
              placeholder="Search..." prepend-icon="search"
              autocomplete
              :loading="loading"
              combobox
              clearable
              cache-items
              :items="items2"
              @keyup.enter="goSearch"
              :search-input.sync="si" 
              v-model="q"
            ></v-select>
</template>

<script>{
  data:function(){return {
    q: "",
    loading: false,
    searchItems:[],
    si: '',
    items2:["todo","set","search"]
  }
  },
  methods: {
    querySelections (v) {
      this.loading = true
      // Simulated ajax query
      setTimeout(() => {
        this.items2 = ["aa","bb",this.si],
        this.loading = false
      }, 500)
    },
    
    goSearch(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
  },
  watch: {
    si:function(val){
      console.log("si: ",val);
      this.querySelections();
    }
  }
}</script>
