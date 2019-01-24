<!DOCTYPE html>
<template id="documentation">
 <v-container fluid>
    <h1>TODO</h1>
    <a href="/vue-poc/api/xqdoc" target="doc">list</a>
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
      HTTP.get('xqdoc')
      .then((res) => {
        this.items = res.data.items;
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
