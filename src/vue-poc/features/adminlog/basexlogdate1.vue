<!DOCTYPE html>
<!-- 
 show log file data in vis-time-line 
 -->
<template id="basexlogdate1">
 <v-container fluid>
 <v-card>
 <v-toolbar >
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
            class="mt-3"
          ></v-text-field>
        </template>
        <v-time-picker
          v-if="showFrom"
          v-model="query.from"
          use-seconds 
          @click:second="$refs.menu.save(query.from)"       
        ></v-time-picker>
      </v-menu>
   <v-toolbar-items>
	   <v-btn @click="pageBack()"  icon> 
		<v-avatar><v-icon>skip_previous</v-icon> </v-avatar> 
	  </v-btn> 
	   <v-btn @click="pageNext()" icon title="increment From by window">
		  <v-avatar> <v-icon>skip_next</v-icon> </v-avatar> 
		</v-btn>
		</v-toolbar-items>	 
	 <v-spacer></v-spacer>
	  <qd-range :query="query"></qd-range>     
	 <v-toolbar-items>
	 <v-btn @click="fit">fit</v-btn> 
	<v-btn @click="getItems">
	     <v-avatar><v-icon>refresh</v-icon></v-avatar>
	     </v-btn> 
	
   </v-toolbar-items>
    <v-menu bottom  left >
	       <template v-slot:activator="{ on }">
	         <v-btn icon v-on="on" >
              <v-icon>more_vert</v-icon>
            </v-btn>
           </template>
             <v-list>
              <v-list-item  >
                <v-list-item-title> <qd-range :query="query"></qd-range></v-list-item-title>
              </v-list-item>
            </v-list>
      </v-menu>
                
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
    query:{date: this.date, start: 1, limit:30, from:"00:00:00", window:600},
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
	 this.query.from= this.addtime(this.query.from,this.query.window)
	 this.getItems()
  },
  
  pageBack(){
	  this.query.from = this.addtime(this.query.from,-this.query.window)
	  this.getItems()
  },
  
  addtime(time,secs){
	  var result= moment(time,moment.HTML5_FMT.TIME_SECONDS).add(secs,"s")
	  var result= moment.max(result,moment("00:00:00",moment.HTML5_FMT.TIME_SECONDS))       
	  return  result.format(moment.HTML5_FMT.TIME_SECONDS) 
  },
  
  getItems(){
      this.loading=true
      HTTP.get("logxml", {params:this.query})
      .then(r=>{
        //var items=r.data.items.filter(item=>{return item.text!="[GET] http://localhost:8984/vue-poc/api/log"})
        var items=r.data.items
        //console.log("logxml",items)
        // {id: 4, content: 'item 4', start: '2014-04-16', end: '2014-04-19', type: 'point'}
        this.data=items.map(x=>Object.assign({}, x, 
        		{
        	      content: x.text.split(";",1)[0],
        	      title: x.text,
        	      style: x.text.startsWith("[POST] ")?"background-color: red;": "background-color: yellow;",
        	      group: x.user}
               ))
        this.loading=false
        return;
        //https://stackoverflow.com/a/39637877/3210344 round(date, moment.duration(15, "minutes"), "ceil")
        var roundDate= function (date, duration, method) {
                  return moment(Math[method]((+date) / (+duration)) * (+duration)); 
        }
        var start=moment(this.date + "T" + this.query.from)
        var first=this.data[0]  
        if(first){     	
        	first=moment(first.time)
        	start=roundDate(first,moment.duration(this.query.window, "seconds"), "floor")
        	//console.log(r.format(moment.HTML5_FMT.TIME_SECONDS))
        	this.query.from=start.format(moment.HTML5_FMT.TIME_SECONDS)
        }
        this.options.start=start.toDate()
        this.options.end=start.add(this.query.window,"s").toDate()
        //console.log("data",this.data)
        
        }) 
    }
},
watch:{
	"query":{
	    handler:function(vnew,vold){
	      //console.log("watch",this.query)
	     
	      this.$router.push({  query: this.query })
	      if(!this.loading)  this.getItems()
	      },
	    deep:true
	  }
},
created(){
  
  this.query=Object.assign(this.query,this.$route.query)
  this.query.start=Number(this.query.start)
  this.query.limit=Number(this.query.limit)
  console.log("basexlogdate1 query: ",this.$route.query)
  var v= this.query.from.match(/^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$/)
  this.query.from= v? this.query.from : "00:00:00"
  this.getItems();
}
}</script>
