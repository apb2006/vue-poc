<!DOCTYPE html>
<!-- 
 image list ui
 
 -->
<template id="images">

      <v-card>
      <v-toolbar dense >
      <v-btn  @click.stop="showFilter = true" icon><v-icon>search</v-icon></v-btn>
        <v-toolbar-title>{{ qtext }}</v-toolbar-title>
        <v-tooltip top  v-if="query.keyword || query.from || query.until">      
        <v-btn @click="clear" icon slot="activator"
       >
            <v-icon>clear</v-icon>
           </v-btn>
         <span>Clear search</span>
         </v-tooltip>
           <v-btn icon @click="getImages">
                    <v-avatar>
                      <v-icon >refresh</v-icon>
                     </v-avatar>
                  </v-btn>
           <v-spacer></v-spacer>
           <span v-if="!busy">
              <v-toolbar-items v-if="!selection.length">
							   <v-btn icon v-for="b in buttons" :key="b.icon" @click="action(b)">
							      <v-avatar>
							        <v-icon v-text="b.icon"></v-icon>
							       </v-avatar>
							    </v-btn>
          </v-toolbar-items>
          <v-toolbar-items v-if="selection.length">
                 <v-btn icon v-for="b in selopts" :key="b.icon" @click="action(b)">
                    <v-avatar>
                      <v-icon v-text="b.icon"></v-icon>
                     </v-avatar>
                  </v-btn>
          </v-toolbar-items>
          </span>
           <v-spacer></v-spacer>
          <v-toolbar-items>
          <v-btn @click.stop="pageBack()" :disabled="query.page==0" icon >
           <v-avatar>
           <v-icon>arrow_back</v-icon>
           </v-avatar>
           </v-btn>
           <v-btn @click.stop="pageNext()" icon >
            <v-avatar>
            <v-icon>arrow_forward</v-icon>
            </v-avatar>
           </v-btn>
         </v-toolbar-items>
        
        </v-toolbar>
        <v-progress-linear v-if="busy" v-bind:indeterminate="true" ></v-progress-linear>
        <v-container v-if="!busy" fluid grid-list-md>
          <v-layout row wrap v-touch="{ left: () => pageNext(), right: () => pageBack()}">
            <v-flex height="80px"
              xs2
              v-for="image in images"
              :key="image.name"
            >
              <v-card  flat tile  >
                <v-card-media :src="src(image)" v-bind:class="{ selcard: image.selected}" 
                @dblclick="go(image)" @click.prevent.stop="image.selected =! image.selected "
                height="100px" contain>
                 <span v-if="image.keywords >0 ">#{{image.keywords}}</span>
                 <v-avatar icon small v-if="image.geo">
                  <v-icon>place</v-icon>
                </v-avatar>
                </v-card-media>
                
                <div v-if="image.selected" style="position:absolute;right:0;top:0" >
                 <v-icon class="white primary--text">check_circle</v-icon>
                 </div>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>

 <v-navigation-drawer left fixed  v-model="showFilter" :disable-route-watcher="true">
         <v-card>
          <v-toolbar class="green white--text">
                <v-toolbar-title >Show images with...</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn  @click="showFilter = false" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          
        <v-card-text>    
         <v-select
              v-bind:items="keywords"
              v-model="query.keyword"
              label="Keyword" item-value="text" item-text="text"
              autocomplete clearable
            >
             <template slot="item" slot-scope="data">
                  <v-list-tile-content>
                    <v-list-tile-title v-html="data.item.text"></v-list-tile-title>
                    <v-list-tile-sub-title v-html="data.item.count"></v-list-tile-sub-title>
                  </v-list-tile-content>
              </template>
            </v-select>
            
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
        
            <v-checkbox :value="location.value" :indeterminate="location.use" @click="cyclelocation" label="With location:"></v-checkbox>
        
        </v-card-text>
        
        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn  @click="showFilter = false"  color="primary" >Apply</v-btn>
        </v-card-actions>
      </v-card>
      </v-navigation-drawer>
        <v-navigation-drawer left fixed v-model="showInfo" :disable-route-watcher="true">
               <v-card> 
                 <v-toolbar class="green white--text">
                <v-toolbar-title >{{selection.length}} selected</v-toolbar-title>
                <v-spacer></v-spacer>    
                 <v-btn flat icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
              </v-toolbar>
              <v-card-text> 
               <ul>
            <li v-for="sel in selection" :key="sel.name">
            {{sel.name}} {{sel.path}}
            </li>
          </ul>
                </v-card-text> 
             </v-card>
      </v-navigation-drawer>
      
      </v-card>
 
</template>

<script>{ 
  
  data(){ 
    return {
    images:[],
    query: {page:0,  // current page
           from:null,
           until:null,
           keyword:null
    },
    total: null,
    elapsed: null,
    showFilter: false,
    busy: false,
    menu2: false,
    showUntil: false,
    keywords: [],
    showInfo: false,
    selitem: "TODO",
    location: {use:false,value:true},
    buttons: [
     
      {method: this.selectAll, icon: "select_all"}     
  ],
  selopts: [
    {method: this.selectNone, icon: "select_all"},
    {method: ()=>{this.showInfo= ! this.showInfo}, icon: "info"},
    {method: this.share, icon: "share"}
 ]
  }
    },
  methods:{
    src(item){
        return "data:image/jpeg;base64,"+item.data
    },
    cyclelocation(){
      this.location.use=!this.location.use
    },
    getImages(){
      this.busy=true
      var t0 = performance.now();
      HTTP.get("images/list",{params:this.query})
      .then(r=>{
        this.busy=false
        this.total=r.data.total
        this.images=r.data.items
        var t1 = performance.now();
        var elapsed= 0.001 *(t1 - t0);
        var round = Vue.filter('round');
        this.$notification.add("Found " + this.total + " in : "+ round(elapsed,1) +" secs");
        }) 
    },
    slideShow(){
      alert("slideshow not yet");
    },
    clear(){
      this.query.from=null;
      this.query.until=null;
      this.query.keyword=null;
      this.query.page=0;
    },
    selectAll(){
      this.images.forEach(item=>{item.selected=true})
    },
   selectNone(){
      this.images.forEach(item=>{item.selected=false})
    },
    selected(image){
      this.selitem=image;
      this.showInfo=true;
    },
    action(b){
      b.method(b.icon)
    },
    share(){
      alert("sHARE: "+ this.selection.length);
    },
    isChanged(vnew,vold){
      if(vnew.keyword != vold.keyword) return true
      if(vnew.from != vold.from) return true
      if(vnew.until != vold.until) return true
      return false
    },
    go(image){
      this.$router.push({ name: 'image', params: { id: image.id }})
    },
    pageBack(){
      this.query.page=Math.max(0,this.query.page-1)
    },
    pageNext(){
      this.query.page+=1
    }
   
  },
  computed:{
    qtext(){
          var k=this.query.keyword,f=this.query.from, u=this.query.until
          var t= (k?" keyword:'"+k+"'":"")+ (f?" from:" + f:"")+ (u?" until:" + u:"")
          return t?t:"(All)"
    },
    selection(){
      return this.images.filter(item=>{return item.selected} ) 
    }
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
      
      $route(v){
        this.getImages()
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
    console.log("images mount")
    
  }
    }
</script>
