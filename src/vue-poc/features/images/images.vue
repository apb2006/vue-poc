<!DOCTYPE html>
<!-- 
 image list ui
 
 -->
<template id="images">

      <v-card>
        <v-card-actions>
        
          <v-select
              v-bind:items="keywords"
              v-model="query.keyword"
              label="Keyword"
              autocomplete
            ></v-select>
            <v-dialog
          persistent
          v-model="modal"
          lazy
          full-width
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
                <v-btn flat primary @click.native="cancel()">Cancel</v-btn>
                <v-btn flat primary @click.native="save()">Save</v-btn>
              </v-card-actions>
            </template>
          </v-date-picker>
        </v-dialog>
        <v-btn @click.native="clear()">Clear</v-btn>
           <v-spacer></v-spacer>
            <v-btn @click.native="query.page+=1">next</v-btn>
         {{query.page}}
          <v-btn @click.native="query.page-=1">back</v-btn>
        </v-card-actions>
        <v-container fluid grid-list-md>
          <v-layout row wrap>
            <v-flex height="80px"
              xs2
              v-for="image in images"
              :key="image.name"
            >
              <v-card   @click="selected(image)" class="grey lighten-2 pt-1">
                <v-card-media :src="src(image)"  height="80px" :contain="true"></v-card-media>
                 <v-card-actions  v-tooltip:top="{ html: image.id + ' '+image.name }">
              
                <v-btn icon small>
                  <v-icon>favorite</v-icon>
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn icon  small>
                  <v-icon>bookmark</v-icon>
                </v-btn>
                <v-btn icon  small>
                  <v-icon>share</v-icon>
                </v-btn>
              </v-card-actions>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
          <v-navigation-drawer left light temporary v-model="showInfo">
					     <v-card> 
					       <v-toolbar class="green white--text">
					      <v-toolbar-title >{{selitem.name}}</v-toolbar-title>
					      <v-spacer></v-spacer>    
					       <v-btn flat icon @click.native="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
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
           keyword:null
    }, 
    modal:false, // showing datepicker
    
    keywords:[],
    showInfo:false,
    selitem:"TODO"
  }),
  methods:{
    src(item){
        return "data:image/jpeg;base64,"+item.data
    },
    getImages(){
      HTTP.get("images/list",{params:this.query})
      .then(r=>{
        this.images=r.data.items
        }) 
    },
    clear(){
      this.query.from=null;
      this.query.keyword=null;
    },
    selected(image){
      this.selitem=image;
      this.showInfo=true;
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
    this.query.page=Number(this.$route.query.page) || this.query.page
    this.query.keyword=this.$route.query.keyword || this.query.keyword
    this.query.from=this.$route.query.from || this.query.from
    this.getImages()
    HTTP.get("images/keywords")
    .then(r=>{
      this.keywords=r.data.items
      }) 
  }
    }
</script>
