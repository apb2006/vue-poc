<!DOCTYPE html>
<template id="namespace">
 <v-container fluid  grid-list-md>
<v-toolbar >
   <v-toolbar-title>Namespaces</v-toolbar-title>
   <v-spacer></v-spacer>
   <v-btn @click="load"
    :loading="loading"
      :disabled="loading"
   >Refresh</v-btn>
   Text
   </v-toolbar>
     <v-data-iterator
      content-tag="v-layout"
      row
      wrap
      :loading="loading"
      :items="items"
      :rows-per-page-items="rowsPerPageItems"
      :pagination.sync="pagination"
      select-all 
      :value="selected"
    >
      <v-flex
        slot="item"
        slot-scope="props"
        xs12
        sm6
        md4
        lg3
      >
        <v-card :hover="true" active-class="default-class qd-active" height="200px">
        
          <v-toolbar  color="amber">
              <v-card-title >
               <router-link :to="{path:'namespace/'+ props.item.name}">
                <h3>
                <v-icon>star</v-icon> {{ props.item.xmlns }}
                </h3>
                </router-link>
             </v-card-title>
          </v-toolbar>
          <v-card-text>{{ props.item.description }}</<v-card-text>
          <v-card-text>
           <v-badge color="red">
            <span slot="badge">{{ props.item.prefix }}</span>
            Fields
          </v-badge>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-data-iterator>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      items: [],
      loading: false,
      q: "",
      message: 'bad route!',
      rowsPerPageItems: [4, 8, 20],
      pagination: {
        rowsPerPage: 20
      },
      selected:[]
      }
  },
  methods: {
    load(){
    
      this.loading= true
      HTTP.get("data/namespace",{params:{}})
      .then(r=>{
        this.items= r.data.items
        this.q= null
        this.loading= false
        })
        .catch(error=> {
          console.log(error);
          this.loading= false
          alert("Get query error"+url)
        });
      
    },
  },
  created:function(){
    this.q=this.$route.query.q || this.q;
    this.load();
    console.log("namespaces")
  }
}
</script>
