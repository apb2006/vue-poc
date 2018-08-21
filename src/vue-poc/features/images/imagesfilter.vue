<!DOCTYPE html>
<!-- 
 image filter ui
 
 -->
<template id="imagesfilter">
         <v-card>
          <v-toolbar class="green white--text">
                <v-toolbar-title >Show images with...</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn  @click="showFilter = false" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          
        <v-card-text>    
         <v-autocomplete
              v-bind:items="keywords"
              v-model="query.keyword"
              label="Keyword" item-value="text" item-text="text"
               clearable
            >
             <template slot="item" slot-scope="data">
                  <v-list-tile-content>
                    <v-list-tile-title v-html="data.item.text"></v-list-tile-title>
                    <v-list-tile-sub-title v-html="data.item.count"></v-list-tile-sub-title>
                  </v-list-tile-content>
              </template>
            </v-autocomplete>
            
          <v-menu
          lazy
          :close-on-content-click="false"
          v-model="menu2"
          transition="scale-transition"
          offset-y
          full-width
          :nudge-left="40"
          max-width="290px"
        >
             <v-text-field
            slot="activator"
            label="Earliest date"
            v-model="query.from"
            prepend-icon="event"
            readonly
            clearable
          ></v-text-field>
         
          <v-date-picker v-model="query.from" scrollable actions>
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn flat color="primary" @click="cancel()">Cancel</v-btn>
                <v-btn flat  color="primary"  @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-menu>
          
           <v-menu
          lazy
          :close-on-content-click="false"
          v-model="showUntil"
          transition="scale-transition"
          offset-y
          full-width
          :nudge-left="40"
          max-width="290px"
        >
           </v-date-picker>
            <v-text-field
            slot="activator"
            label="Latest date"
            v-model="query.until"
            prepend-icon="event"
            readonly
            clearable
          ></v-text-field>
         
          <v-date-picker v-model="query.until" scrollable actions>
            <template slot-scope="{ save, cancel }">
              <v-card-actions>
                <v-btn flat  color="primary"  @click="cancel()">Cancel</v-btn>
                <v-btn flat  color="primary"  @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-date-picker>
          </v-menu>
        
            <v-checkbox :value="location.value" :indeterminate="location.use" @click="cyclelocation" label="With location"></v-checkbox>
        
        </v-card-text>
        
        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn  @click="showFilter = false"  color="primary" >Apply</v-btn>
        </v-card-actions>
      </v-card>
     
 
</template>

<script>{ 
  
  data(){ 
    return {
    query: {page:0,  // current page
           from:null,
           until:null,
           keyword:null
    },
    showFilter: false,
    busy: false,
    menu2: false,
    showUntil: false,
    keywords: [],
    showInfo: false,
    selitem: "TODO",
    location: {use:false,value:true},
   
  }
    },
  methods:{
    
    cyclelocation(){
      this.location.use=!this.location.use
    },
  
    clear(){
      this.query.from=null;
      this.query.until=null;
      this.query.keyword=null;
      this.query.page=0;
    },
   
    isChanged(vnew,vold){
      if(vnew.keyword != vold.keyword) return true
      if(vnew.from != vold.from) return true
      if(vnew.until != vold.until) return true
      return false
    },
   
   
  },
 
  watch:{
      "query":{
        handler:function(vnew,vold){
          var b=this.isChanged(vnew,vold)
          console.log("watch",b,vnew,vold)
          if(b) this.query.page=0
          this.$router.push({  query: this.query })
          },
        deep:true
      },
      

      showFilter(){
        if(this.keywords.length==0){
          HTTP.get("images/keywords2")
          .then(r=>{
            this.keywords=r.data.items
            }) 
        }
      }
  },
  created:function(){
    console.log("create images")
    this.query.page=Number(this.$route.query.page) || this.query.page
    this.query.keyword=this.$route.query.keyword || this.query.keyword
    this.query.from=this.$route.query.from || this.query.from
    this.query.until=this.$route.query.until || this.query.until
    this.getImages()
    
  },
  mounted:function(){
    console.log("image filter mount")
    
  }
    }
</script>
