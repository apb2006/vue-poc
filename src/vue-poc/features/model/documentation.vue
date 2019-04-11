<!DOCTYPE html>
<template id="documentation">
 <v-container fluid>
    <v-toolbar dense >
        <v-toolbar-title>documentation</v-toolbar-title>
        <v-spacer></v-spacer>
          <v-btn
       icon
      :loading="loading"
      @click="get()"
      :disabled="loading"
    >  
    <v-icon>refresh</v-icon>
    </v-btn>
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
           <v-card-title color="#26c6da">{{ item.id }}</v-card-title>
           <v-card-text>{{ item.name }}</v-card-text>
           <v-card-actions>
           <a :href="item.href" target="_new">go</a>
           </v-card-actions>
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
      items:[],
      loading: false
      }
  },
  methods:{
    get() {
      HTTP.get('xqdocjob')
      .then((res) => {
        this.items = res.data;
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
