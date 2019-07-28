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
		             <v-list-item-action>
		                 <v-btn icon :to="item.value">
		                  <v-icon>pages</v-icon>
		                 </v-btn>
		            </v-list-item-action>
                       
					      <v-list-item-title>
					          {{ item.text }}
					      </v-list-item-title>
					      <v-spacer></v-spacer>
					      <v-list-item-action @click.stop>
					        <v-btn
					          icon
					          :to="item.value"
					        >
                        <v-icon>arrow_forward</v-icon>					         
					        </v-btn>
					      </v-list-item-action>
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
        this.items2 = this.si?this.matchItems(this.si.toLowerCase()):[],
        this.loading = false
      }, 500)
    },
    
    goSearch(){
        this.$router.push({path: '/search',query: { q: this.q }})
      },
      
    matchItems(typed){
        var hits=this.$router.options.routes;
        console.log(hits.length,hits);
         hits=hits.filter(item=>{
           if (!item.meta) return false;
          var i=item.meta.title.toString().toLowerCase();
          console.log(i);
          return i.indexOf(typed) !== -1});
         
         console.log("pages",typed," r:",hits);
        return hits.map(r=>{return {text:r.meta.title,
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
  }
}</script>
