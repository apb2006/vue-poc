<!DOCTYPE html>
<template id="session">
 <v-container fluid>
  <v-layout >
   <v-btn   v-on:click="redraw">this.$forceUpdate()</v-btn>
    <v-btn  v-on:click="logout">logout</v-btn>
     <v-btn  v-on:click="refresh">refresh</v-btn>
 
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
        <td>user</td><td>{{ $auth.user }}</td>
        </tr>
        <tr>
        <td>created</td><td>{{ $auth.created }}</td>
        </tr>
        <tr>
        <td>session</td><td>{{ $auth.session }}</td>
        </tr>
        <tr>
        <td>permision</td><td>{{ $auth.role }}</td>
        </tr>
        </tbody>
        </table>
        <pre>
        {{ $auth }}
        </pre>
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
    refresh(){
      HTTP.get("status")
      .then(r=>{
        console.log("status",r)
        this.$auth.update(r.data);
        //this.$forceUpdate()
      })  
    },
    handleSelected(){
      
    }
  }
}</script>
