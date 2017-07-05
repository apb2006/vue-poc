<!DOCTYPE html>
<template id="history">
 <v-container fluid>
    <v-list>
            <v-list-tile  v-for="item in items" v-bind:key="item.title" @click="doEdit(item.url)" avatar>
              <v-list-tile-action>
                <v-icon v-if="item.icon" class="pink--text">star</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title @click="doEdit(item.url)" v-text="item.url"></v-list-tile-title>
              </v-list-tile-content>
              <v-list-tile-avatar>
                <img v-bind:src="item.avatar"/>
              </v-list-tile-avatar>
            </v-list-tile>
   </v-list>
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
      HTTP.get('history')
      .then((res) => {
        this.items = res.data.items;
        console.log("items",this.items)
      });
    },
    doEdit(url){
      console.log("DD"+url)
        router.push({ path: 'edit', query: { url: url  }})
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}
</script>
