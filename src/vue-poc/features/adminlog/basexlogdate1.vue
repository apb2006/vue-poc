<!DOCTYPE html>
<!-- 
 show log file data in vis-time-line 
 -->
<template id="basexlogdate1">
 <v-container fluid>
 <v-card>
 <v-toolbar class="lime darken-1">
	 <v-card-title >
	 <qd-breadcrumbs @todo="showmenu= ! showmenu" 
         :crumbs="[{to: '/logdate', text:'log files'}, {text: date, disabled: false, menu: 'todo'}]"
         >crumbs</qd-breadcrumbs> 
	 </v-card-title>
	
	  <v-menu
        ref="menu"
        v-model="showFrom"
        :close-on-content-click="false"
        :nudge-right="40"
        :return-value.sync="query.from"
        transition="scale-transition"
        offset-y
        max-width="290px"
        min-width="100px"
      >
        <template v-slot:activator="{ on }">
          <v-text-field
            v-model="query.from"
            label="Start time"
            prepend-icon="access_time"
            readonly
            v-on="on"
          ></v-text-field>
        </template>
        <v-time-picker
          v-if="showFrom"
          v-model="query.from"
          full-width use-seconds 
          @click:second="$refs.menu.save(query.from)"
        ></v-time-picker>
      </v-menu>
	  <v-toolbar-items>
		  <v-text-field  type="number" v-model.number="query.start"  label="start" > </v-text-field>
		   <v-text-field  type="number" v-model.number="query.limit"  label="limit" > </v-text-field> 
      </v-toolbar-items>
     
	 <v-spacer></v-spacer> 
	 <v-toolbar-items> 
	 <v-btn @click="fit">fit</v-btn> 
	<v-btn @click="getItems">
	     <v-avatar><v-icon>refresh</v-icon></v-avatar>
	     </v-btn> 
	<v-btn @click="pageBack()" :disabled="query.start==1" icon> 
		<v-avatar><v-icon>arrow_back</v-icon> </v-avatar> 
	</v-btn> 
   <v-btn @click="pageNext()" icon>
	  <v-avatar> <v-icon>arrow_forward</v-icon> </v-avatar> 
	</v-btn> 
   </v-toolbar-items>
	 </v-toolbar>
	 
	 <v-card-text>
	   <vis-time-line :items="data" :events="Events" 
	                  :options="options" @select="select"></vis-time-line>
	 </v-card-text>
 </v-card>
 
 <v-card>
 <v-card-text>
 <pre>{{msg}}</pre>
 </v-card-text>
</v-card>
 </v-container>
</template>

<script>{
  data:function(){
    return {

      loading: false,
      options: {editable: false, clickToUse: false,
    	  timeAxis: {scale: 'minute', step: 1}
      },
      data:[],
    query:{name: "2019-09-23", start: 1, limit:30, from:"00:00:00", mins:10},
    showmenu: false,
    Events: new Vue({}),
    msg:"Select an entry",
    showFrom: false
    }
},
props: ['date'],
methods:{
  fit(){
    this.Events.$emit('fit');
  },
  select(sel){
   
    var hit=this.data.find(item => item.id==sel )
    var h=JSON.stringify(hit,null,2)
    this.msg= h
  },
  pageNext(){
	 this.query.start+= this.query.limit
	 this.query.from= this.addtime(this.query.from,this.query.mins)
	 this.getItems()
  },
  pageBack(){
	  this.query.start-= this.query.limit
	  this.query.from = this.addtime(this.query.from,-this.query.mins)
	  this.getItems()
  },
  addtime(time,mins){
	  return moment(time,moment.HTML5_FMT.TIME_SECONDS).add(mins,"m").format(moment.HTML5_FMT.TIME_SECONDS) 
  },
  getItems(){
      this.loading=true
      HTTP.get("logxml", {params:this.query})
      .then(r=>{
        this.loading=false
       
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        var items=r.data.items
        //console.log("logxml",items)
        // {id: 4, content: 'item 4', start: '2014-04-16', end: '2014-04-19', type: 'point'}
        this.data=items.map(x=>Object.assign({}, x, 
        		{ start: x.time,
        	      content: x.text.split(";",1)[0],
        	      title: x.text,
        	      style: x.text.startsWith("[POST] ")?"background-color: red;": "background-color: yellow;",
        	      group: x.user}
               ))
        //console.log("data",this.data)
        }) 
    }
},
watch:{
	"query":{
	    handler:function(vnew,vold){
	      console.log("watch",vnew,vold)
	      this.$router.push({  query: this.query })
	      },
	    deep:true
	  }
},
created(){
  console.log("logxml: ",this.$route.query)
  this.query=Object.assign(this.query,this.$route.query)
  this.query.start=Number(this.query.start)
  this.query.limit=Number(this.query.limit)
  this.getItems();
}
}</script>
