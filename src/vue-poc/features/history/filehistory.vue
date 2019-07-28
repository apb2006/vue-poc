<!DOCTYPE html>
<template id="filehistory">
 <v-container >
 <v-card>
  <v-card-title>File History</v-card-title>
 <v-card-text>
    <v-list>
            <v-list-item  v-for="item in items" v-bind:key="item.title" avatar>
              <v-list-item-action>
               <v-chip v-text="item.protocol">Example Chip</v-chip>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title v-text="item.url"></v-list-item-title>
              </v-list-item-content>
              
              <v-list-item-action>
              <v-btn  :to="{name:'edit', query:{ url:item.url, protocol:item.protocol}}" icon ripple>
                <v-icon color="grey lighten-1">info</v-icon>
              </v-btn>
              </v-list-item-action>
              <v-list-item-action>
              <v-btn   :to="{name:'multi-edit', query:{  url:item.protocol + ':' +item.url }}" icon ripple>
                <v-icon color="grey lighten-1">switch_camera</v-icon>
              </v-btn>
            </v-list-item-action>
            </v-list-item>
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
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}
</script>
