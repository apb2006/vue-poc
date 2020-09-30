<!DOCTYPE html>
<!-- 
 search box.
 dropdown shows matching pages
 press return for server search
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
            >
            
            <template  slot="item"  slot-scope="{ index, item, parent }" >
                      <v-list-item-content>
                 
					      <v-list-item-title>Search "{{ item.text }}"</v-list-item-title>
					      <v-list-item-subtitle>or goto 
					          <router-link :to="item.value">
					          {{ item.value }} 		                  
		                      <v-icon>launch</v-icon>	
		                     </router-link>
		                 </v-list-item-subtitle>
					   </v-list-item-content>
					   
             </template>
              
     </v-combobox>
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
        this.items2 = this.si?this.matchItems(this.si.toLowerCase()):[] 
        this.loading = false
      }, 500)
    },
    
    goSearch(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
      
    matchItems(typed){
        var hits=this.titles;
        typed=typed.toLowerCase();
        hits=hits.filter(item=>item.title.indexOf(typed) !== -1)
        return hits.map(r=>{return {text:r.title,
                                    value:r.path}
                      });
      },
      
      gopage(){
        alert("GO")
      }
  },
  watch: {
    si:function(val){
      console.log("si: ",val);
      this.querySelections();
    }
  },
  created:function(){
	  var hits=this.$router.options.routes;  
	  var res=[];
	  const extract = function(item,path) {if(item.hasOwnProperty("meta")) 
		                                     return {title: item.meta.title.toLowerCase(), 
		                                             path: path + item.path}
	                                     else if(item.hasOwnProperty("children"))
	                                    	 return item.children.map(item=>extract(item, path  +"/"))
	                                     else
	                                    	 return []
	                                      };
	  res=hits.map(item=>extract(item,item.path))
	  res=res.flat(Infinity);
	 //console.log("extract",res)
	  this.titles=res;
  }
}</script>
