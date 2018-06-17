<!DOCTYPE html>
<template id="history">
 <v-container >
 <v-card>
  <v-card-title>History</v-card-title>
 <v-card-text>
    <v-list>
            <v-list-tile  v-for="item in items" v-bind:key="item.title" @click="doEdit(item)" avatar>
              <v-list-tile-action>
               <v-chip v-text="item.protocol">Example Chip</v-chip>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title v-text="item.url"></v-list-tile-title>
              </v-list-tile-content>
              <v-list-tile-action>
              <v-btn  @click="doEdit(item)" icon ripple>
                <v-icon color="grey lighten-1">info</v-icon>
              </v-btn>
              </v-list-tile-action>
              <v-list-tile-action>
              <v-btn  @click="doEdit2(item)" icon ripple>
                <v-icon color="grey lighten-1">info</v-icon>
              </v-btn>
            </v-list-tile-action>
            </v-list-tile>
   </v-list>
   </v-card-text>
   </v-card>
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
    doEdit(item){
      console.log("history: ",item)
        router.push({ path: 'edit', query: { url:item.url, protocol:item.protocol  }})
    },
    doEdit2(item){
     alert("dd")
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}
</script>
