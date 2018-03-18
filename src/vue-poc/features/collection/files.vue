<!DOCTYPE html>
<template id="files">
 <v-container fluid>
 
<v-card>

<v-toolbar dense >
    <v-btn icon :to="{query: { url: '/' }}">
     <v-icon >{{icon}}</v-icon>
     </v-btn>
        
   
     
    <v-toolbar-title>
		    <v-breadcrumbs>
				    <v-breadcrumbs-item v-for="item in crumbs" :key="item.path" 
				    :to="{ query: { url:  item.path }}" :exact="true">
				    {{ item.name }}
				    </v-breadcrumbs-item>
		    </v-breadcrumbs>
    </v-toolbar-title>
     <v-btn icon @click="load()">
    <v-icon>refresh</v-icon>
    </v-btn> 
   <v-btn v-if="clipboard" @click="clipboard=null" icon><v-icon>content_paste</v-icon></v-btn>
    <v-spacer></v-spacer>
     <v-btn v-if="selection.length"  @click="selectNone">S: {{selection.length}}</v-btn>
     
 <v-text-field v-if="!selection.length" prepend-icon="search" label="Filter..." v-model="q" type="search"
   hide-details single-line  @keyup.enter="setfilter"
   :append-icon="this.q?'clear':''" :append-icon-cb="e=>this.q=''"></v-text-field>
   
 
    <v-toolbar-items v-if="!selection.length">
    
   <v-btn icon v-for="b in buttons" :key="b.icon" @click="action(b)">
      <v-avatar>
        <v-icon v-text="b.icon"></v-icon>
       </v-avatar>
    </v-btn>
</v-toolbar-items>


  
    <v-toolbar-items v-if="selection.length">
		   <v-btn icon v-for="b in selopts" :key="b.icon" @click="action(b)">
		        <v-icon v-text="b.icon"></v-icon>
		    </v-btn>
   </v-toolbar-items>
 
    
 <v-menu offset-y v-if="selection.length">
      <v-btn  icon slot="activator">
      <v-icon>more_vert</v-icon>
     </v-btn>
      <v-list>
        <v-list-tile  @click="invoke">
          <v-list-tile-title>Invoke</v-list-tile-title>
        </v-list-tile>
        <v-divider></v-divider>
        <v-list-tile  @click="invoke">
          <v-list-tile-title>todo</v-list-tile-title>
        </v-list-tile>
         <v-list-tile  @click="invoke">
          <v-list-tile-title>todo</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-menu>
 
  
 </v-toolbar>
  
  <v-layout v-if="!busy">
	  <v-flex>
	  <v-list  two-line subheader>
	    <v-subheader inset >
	         <span >Folders ({{ xfolders.length }})</span> 
	     </v-subheader>
	      <v-list-tile v-for="item in xfolders" v-bind:key="item.name" 
	      v-model="item.selected" @click="folder(item)" avatar >
	        <v-list-tile-avatar   @click.prevent.stop="item.selected =! item.selected ">
	          <v-icon v-bind:class="[itemClass(item)]">{{ itemIcon(item) }}</v-icon>
	        </v-list-tile-avatar>
	        <v-list-tile-content  >
	          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
	          <v-list-tile-sub-title>modified: {{ item.modified | formatDate}}
	                                 size: {{ item.size | readablizeBytes}}
	                                  mimetype: {{ item.mime}}
	                                 </v-list-tile-sub-title>
	        </v-list-tile-content>
	        <v-list-tile-action>
	          <v-btn icon @click.stop="info(item)">
	            <v-icon class="grey--text text--lighten-1">info</v-icon>
	          </v-btn>
	        </v-list-tile-action>
	      </v-list-tile>
	    
	    <v-divider inset></v-divider>
	    <v-subheader inset>
	       <span >Files ({{ xfiles.length }})</span> 
	        </v-subheader> 
	      <v-list-tile v-for="item in xfiles" v-bind:key="item.name" >
	        <v-list-tile-avatar avatar  @click.prevent.stop="item.selected =! item.selected ">
	          <v-icon v-bind:class="[itemClass(item)]">{{ itemIcon(item) }}</v-icon>
	        </v-list-tile-avatar>
	        <v-list-tile-content @click="file(item.name)">
	          <v-list-tile-title >{{ item.name }}</v-list-tile-title>
	           <v-list-tile-sub-title>modified:  {{item.modified | formatDate}},
												            size:  {{item.size|readablizeBytes }},
												            mimetype: {{ item.mime}}
	            </v-list-tile-sub-title>
	        </v-list-tile-content>
	        <v-list-tile-action>
	          <v-btn icon ripple @click.stop="info(item)">
	            <v-icon class="grey--text text--lighten-1">info</v-icon>
	          </v-btn>
	        </v-list-tile-action>
	      </v-list-tile>
	  </v-list>
	  </v-flex>
	
  </v-layout>
  
  
   
</v-card>
<v-progress-linear v-if="busy" v-bind:indeterminate="true" height="2"></v-progress-linear>
<!--
 <v-navigation-drawer left app v-model="showInfo" :disable-route-watcher="true">
   <v-card flat tile> 
       <v-toolbar >
      <v-card-title >{{ selection[0] && selection[0].name }}</v-card-title>
      <v-spacer></v-spacer>    
       <v-btn flat icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-toolbar>
    <v-card-text> Things to do with  </v-card-text>
    <v-card-actions> 
           <v-btn flat @click="invoke()"><v-icon>run</v-icon>run</v-btn>
           </v-card-actions>
    </v-card>
   </v-navigation-drawer>
   -->   
 </v-container>
  
</template>

<script>{
  
  props:["protocol"],
  data(){
    return { 
            url: "", 
            items: [],
            q: null,
            busy: false,
            showInfo: false,
            clipboard: null,
          
						buttons: [ 
						    {method: this.todo, icon: "view_quilt"},
			          {method: this.add, icon: "add"},
						    {method: this.todo, icon: "sort"},
						    {method: this.selectAll, icon: "select_all"}     
						],
						selopts: [
						    {method: this.todo, icon: "delete"},
						    {method: this.clip, icon: "content_copy"},
						    {method: this.clip, icon: "content_cut"},
						    {method: this.todo, icon: "text_format"},
						    {method: this.todo, icon: "info"},
						    {method: this.todo, icon: "share"}
						 ]
    }
  },
  methods:{
    file (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/"+val,protocol:this.protocol  }})
    },
    folder (item) {
      this.url=this.url+item.name+"/"
    },
    load(){
      var url=this.url
      this.busy=true
      HTTP.get("collection",{params:{url:url,protocol:this.protocol}})
      .then(r=>{
        this.items=r.data.items
        this.q=null
        this.busy=false
        })
        .catch(error=> {
          console.log(error);
          this.busy=false
          alert("Get query error"+url)
        });
      
    },
    clearq(){
      this.q=null
    },
	  action(b){
	      b.method(b.icon)
	  },
	  clip(icon){
	    this.clipboard=icon
	  },
    add(){
      alert("add")
    },
    setfilter(){
      console.log("TODO",this.q)
      this.$router.push({  query: {url:this.url,q:this.q }})
    },
    info(item){
      this.showInfo=true
    },
    invoke(){
      HTTP.post("eval/invoke",Qs.stringify({path:this.url+this.selection[0].name}))
      .then(r=>{
        var job=r.data.job
        console.log(r.data)
         this.$router.push({ name: 'jobShow', params: {job:job }})
      })
    },
   todo(icon){
      alert("todo: " + icon)
     },
   itemClass(item){
       return (item.selected)?"blue--text text--darken-2":""
     }, 
   itemIcon(item){
       if(item.selected) return "check_circle"
       else return (item.type=="folder")?"folder":"insert_drive_file"
     },
    selectAll(){
       this.items.forEach(item=>{item.selected=true})
     },
    selectNone(){
       this.items.forEach(item=>{item.selected=false})
     }
  },
  computed: {
   icon(){
        return (this.protocol=="xmldb")?"developer_mode":"folder"
      },
   xfiles(){
        return this.items.filter(item=>{return item.type!="folder" &&((!this.q) || item.name.includes(this.q))})
      },
   xfolders(){
        return this.items.filter(item=>{return item.type=="folder" &&((!this.q) || item.name.includes(this.q))})
      },   
   // array of {name:"that", path:"/this/that/"} for url
   crumbs(){
        var parts=this.url.split("/").filter((a)=>a.length>0)
        var a=parts.map(
            function(v,i,a){return {name:v,  path:"/"+a.slice(0,i+1).join("/")+"/"}}
            )
        return a  
      },
   selection(){
        return this.items.filter(item=>{return item.selected} ) 
      }
  },
  watch:{
    url(v){
      this.$router.push({  query: { url: this.url }})
      },
      $route(vnew,vold){
        //console.log("ROUTE",vnew,vold)    
        var url=this.$route.query.url
        this.url=url?url:"/";
        if(vnew.query.url != vold.query.url) this.load() 
      }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:"/";
    this.q=this.$route.query.q || this.q
    this.load()
  }
}
</script>
