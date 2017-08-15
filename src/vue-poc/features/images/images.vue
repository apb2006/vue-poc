<!DOCTYPE html>
<!-- 
 image list ui
 
 -->
<template id="images">

      <v-card>
      <v-toolbar class="green white--text">
      <v-btn  @click.stop="showFilter = true" icon><v-icon>search</v-icon></v-btn>
        <v-toolbar-title>{{ qtext }}</v-toolbar-title>
              
        <v-btn @click="clear" icon v-tooltip:top="{ html: 'Clear search' }"
        v-if="query.keyword || query.from || query.until">
            <v-icon>clear</v-icon>
           </v-btn>
           <v-spacer></v-spacer>
           <v-progress-circular v-if="busy" indeterminate class="primary--text"></v-progress-circular>
            Page:{{ query.page+1 }}
          <v-btn @click.stop="query.page=Math.min(0,query.page-1)" :disabled="query.page==0" icon primary>
           <v-icon>arrow_back</v-icon>
           </v-btn>
           <v-btn @click.stop="query.page+=1" icon primary>
            <v-icon>arrow_forward</v-icon>
           </v-btn>
        </v-toolbar>

        <v-container fluid grid-list-md>
          <v-layout row wrap>
            <v-flex height="80px"
              xs2
              v-for="image in images"
              :key="image.name"
            >
              <v-card   class="grey lighten-2 pt-1">
                <v-card-media :src="src(image)"  @click="go(image)" 
                height="80px" :contain="true"></v-card-media>
                 <v-card-actions  v-tooltip:top="{ html:  ' '+image.path }">
              
                <v-btn icon small>
                  <v-icon>favorite</v-icon>
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn icon  small>
                  <v-icon>bookmark</v-icon>
                </v-btn>
                <v-btn icon  small @click="selected(image)">
                  <v-icon>share</v-icon>
                </v-btn>
              </v-card-actions>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>

 <v-navigation-drawer left persistent v-model="showFilter" :disable-route-watcher="true">
         <v-card>
          <v-toolbar class="green white--text">
                <v-toolbar-title >Set filter...</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn  @click="showFilter = false" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          
        <v-card-text>    
         <v-select
              v-bind:items="keywords"
              v-model="query.keyword"
              label="Keyword"
              autocomplete
            ></v-select>
            <v-btn  @click="query.keyword=null" :disabled="!query.keyword">
               <v-icon>close</v-icon>Clear keyword
             </v-btn> 
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
          ></v-text-field>
         
          <v-date-picker v-model="query.from" scrollable actions>
            <template scope="{ save, cancel }">
              <v-card-actions>
                <v-btn flat primary @click="cancel()">Cancel</v-btn>
                <v-btn flat primary @click="save()">Save</v-btn>
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
          ></v-text-field>
         
          <v-date-picker v-model="query.until" scrollable actions>
            <template scope="{ save, cancel }">
              <v-card-actions>
                <v-btn flat primary @click="cancel()">Cancel</v-btn>
                <v-btn flat primary @click="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-date-picker>
          </v-menu>
        </v-card-text>
        
        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn  @click="showFilter = false" primary>Apply</v-btn>
        </v-card-actions>
      </v-card>
      </v-navigation-drawer>
        <v-navigation-drawer left persistent v-model="showInfo" :disable-route-watcher="true">
               <v-card> 
                 <v-toolbar class="green white--text">
                <v-toolbar-title >{{selitem.name}}</v-toolbar-title>
                <v-spacer></v-spacer>    
                 <v-btn flat icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
              </v-toolbar>
              <v-card-text> blah blah  </v-card-text> 
             </v-card>
      </v-navigation-drawer>
      
      </v-card>
 
</template>

<script>{  
  data: () => ({
    images:[],
    query:{page:0,  // current page
           from:null,
           until:null,
           keyword:null
    }, 
    showFilter:false,
    busy:false,
    menu2:false,
    showUntil:false,
    keywords:[],
    showInfo:false,
    selitem:"TODO"
  }),
  methods:{
    src(item){
        return "data:image/jpeg;base64,"+item.data
    },
    getImages(){
      this.busy=true
      HTTP.get("images/list",{params:this.query})
      .then(r=>{
        this.busy=false
        this.images=r.data.items
        }) 
    },
    clear(){
      this.query.from=null;
      this.query.until=null;
      this.query.keyword=null;
      this.query.page=0;
    },
    selected(image){
      this.selitem=image;
      this.showInfo=true;
    },
    go(image){
      this.$router.push({ name: 'image', params: { id: image.id }})
    }
   
  },
  computed:{
    qtext(){
          var k=this.query.keyword,f=this.query.from, u=this.query.until
          return (k?" keyword:'"+k+"'":"")+ (f?" from:" + f:"")+ (u?" until:" + u:"")
    }
  },
  watch:{
      "query":{
        handler:function(v){
          this.$router.push({  query: this.query })
          },
        deep:true
      },
      $route(v){
        this.getImages()
      }
  },
  created:function(){
    console.log("create images")
    this.query.page=Number(this.$route.query.page) || this.query.page
    this.query.keyword=this.$route.query.keyword || this.query.keyword
    this.query.from=this.$route.query.from || this.query.from
    this.query.until=this.$route.query.until || this.query.until
    this.getImages()
    HTTP.get("images/keywords")
    .then(r=>{
      this.keywords=r.data.items
      }) 
  },
  mounted:function(){
    console.log("images mount")
    
  }
    }
</script>
