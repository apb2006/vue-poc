<!DOCTYPE html>
<template id="search">
 <v-container fluid>
 <v-alert warning value="true">Not finished</v-alert>
 <v-text-field  label="Search..." v-model="q" v-on:keyup="send"></v-text-field> 
  <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
  <v-layout>
    <v-flex>
    <v-list v-if="!busy" two-line subheader>
      
        <v-list-tile v-for="(item,index) in results" v-bind:key="item.uri" 
        :to="item.uri" v-model="selected[index]" avatar >
          <v-list-tile-avatar  @click.prevent.stop="select(index)">
            <v-icon v-text="icon(index)"></v-icon>
          </v-list-tile-avatar>
          <v-list-tile-content  >
            <v-list-tile-title>{{ index }} {{ item.title }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ item.uri }}</v-list-tile-sub-title>
          </v-list-tile-content>
          <v-list-tile-action>
            <v-btn icon ripple >
              <v-icon class="grey--text text--lighten-1">info</v-icon>
            </v-btn>
          </v-list-tile-action>
        </v-list-tile>
     </v-list>
     </v-flex>
     </v-layout>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      q: this.$route.query.q,
      results: [],
      busy: false,
      selected: []
      }
  },
  methods:{
    get() {
      this.busy= true
      console.log("q",this.q)
      HTTP.get('search',{params:{q:this.q}})
      .then((res) => {
        this.busy=false
        this.results = res.data.items;
        this.selected=[false,true]
      });
    },
    send(e){
      if(e.keyCode==13){
        this.get()
      }
    },
    icon(index){
      return this.selected[index]?"check_circle":"search"
    },
    search(item){
      alert(item.title)
    },
    select(index){
      this.$set(this.selected,index,!this.selected[index])
      //alert(index)
    }
  },
  created:function(){
    console.log("Serch",this.$route.query.q)
    this.get()
  }
}
</script>
