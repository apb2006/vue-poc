<!DOCTYPE html>
<template id="images">

      <v-card>
        <v-card-actions>
         <v-btn @click.native="page+=1">next</v-btn>
         {{page}}
          <v-btn @click.native="page-=1">back</v-btn>
          
          <v-spacer></v-spacer>
        </v-card-actions>
        <v-container fluid grid-list-md>
          <v-layout row wrap>
            <v-flex height="80px"
              xs2
              v-for="image in images"
              :key="image.name"
            >
              <v-card   @click="selected()" class="grey lighten-2 pt-1">
                <v-card-media :src="src(image)"  height="80px" :contain="true"></v-card-media>
                 <v-card-actions  v-tooltip:top="{ html: image.name }">
              
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
      </v-card>

</template>

<script>{  
  data: () => ({
    images:[],
    page:0
  }),
  methods:{
    src(item){
     //return "https://unsplash.it/150/300?image="+Math.floor(Math.random() * 100) + 1
        return "data:image/jpeg;base64,"+item.data
    },
    getImages(){
      HTTP.get("images/list?page="+this.page)
      .then(r=>{
        this.images=r.data.items
        })
      
    },
    selected(){
      alert("not yet")
    }
  },
  watch:{
    page(v){
      this.$router.push({  query: { page: this.page }})
      },
      $route(v){
        this.getImages()
      }
  },
  created:function(){
    this.page=this.$route.query.page || this.page
    this.getImages()
  }
    }
</script>
