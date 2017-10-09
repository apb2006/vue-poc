<!DOCTYPE html>
<template id="repo">
 <v-container fluid>
  <v-card >
   <v-toolbar >
    <v-text-field
        append-icon="search"
        label="Filter repo"
        single-line
        hide-details
        v-model="search"
      ></v-text-field>   
      <v-spacer></v-spacer>     
    </v-toolbar>
<v-data-table
      :headers="headers"
      :items="items"
      :search="search"
       v-model="selected"
       select-all
      class="elevation-1"
      no-data-text="No repo found @todo"
    >
    <template slot="items" scope="props">
    <td class="vtop">
        <v-checkbox
          primary
          hide-details
          v-model="props.selected"
        ></v-checkbox>
      </td>
      <td class="vtop">{{ props.item.name }}</td>
      <td class="vtop "><div>{{ props.item.permission }}</div>
    </template>
  </v-data-table>
  </v-card>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      loading: false,
      items: [],
      search: null,
      selected: [],
      headers: [
        {
          text: 'Name',
          left: true,
          value: 'id'
        },
        { text: 'Permission', value: 'state' }
      ] 
      }
  },
  methods:{
      getUsers(){
        this.loading=true;
        HTTP.get("repo")
        .then(r=>{
           this.loading=false
           this.items=r.data
        })
     }
  },
  created:function(){
    console.log("notfound",this.$route.query.q)
  }
}
</script>

