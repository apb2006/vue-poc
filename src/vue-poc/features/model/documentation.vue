<!DOCTYPE html>
<template id="documentation">
 <v-container fluid>
    <v-toolbar dense >
        <v-toolbar-title>documentation</v-toolbar-title>
        <v-spacer></v-spacer>
        <a href="/vue-poc/api/xqdocjob" target="doc">json</a>
    </v-toolbar>

     <v-container fluid grid-list-md>
       <v-layout row wrap >
         <v-flex height="80px"
           xs2
           v-for="item in items"
           :key="item.id"
         >
           <v-card    :hover="true"  >
           <v-card-title>{{ item.id }}</v-card-title>
           <v-card-text>{{ item.name }}</v-card-text>
           </v-card>
           </v-flex>
        </v-layout>
      </v-container>
              
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      items:[]
      }
  },
  methods:{
    get() {
      HTTP.get('xqdocjob')
      .then((res) => {
        this.items = res.data;
        console.log("items",this.items)
      });
    },
    doEdit(item){
      console.log("history: ",item)
        router.push({ path: 'edit', query: { url:item.url, protocol:item.protocol  }})
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}
</script>
