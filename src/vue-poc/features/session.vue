<!DOCTYPE html>
<template id="session">
 <v-container fluid>
  <v-layout >
   <v-btn   v-on:click="redraw">this.$forceUpdate()</v-btn>
    <v-btn  v-on:click="logout">logout</v-btn>
   <!-- 
    <v-autocomplete :items="list" 
    v-model="fieldValue" 
    :search.sync="search"
     label="Suburb" item-text="suburb" 
    item-value="suburb" 
    @selected="handleSelected"
     strict="Unknown">
<template slot="item" slot-scope="data">
      <v-list-tile-content>
        <v-list-tile-title>{{data.item.suburb}}</v-list-tile-title>
        <template v-if="!data.item.generatedItem">
          <v-list-tile-sub-title>{{data.item.postcode}} - {{data.item.state}}</v-list-tile-sub-title>
        </template>
      </v-list-tile-content>
    </template>
</v-autocomplete>
 -->
  </v-layout>
   <table class="table">
      <thead> 
        <tr>
          <th>Name</th>
          <th >value</th>
          </tr>
        </thead>
        <tbody>
        <tr>
        <td>created</td><td>{{$auth.created}}</td>
        </tr>
        <tr>
        <td>session</td><td>{{$auth.session}}</td>
        </tr>
        <tr>
        <td>permision</td><td>{{$auth.permission}}</td>
        </tr>
        </tbody>
        </table>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      fieldValue:"",
      list:[],
      search:"",
      data:[]    }
  },
  methods: {
    logout(){
      alert("TODO")
    },
    redraw(){
      this.$forceUpdate()
    },
    handleSelected(){
      
    }
  }
}

</script>
