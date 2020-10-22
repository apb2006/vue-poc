<!DOCTYPE html>
<!-- 
   perfstats 
   https://adamwathan.me/renderless-components-in-vuejs/
 -->
<template id="qd-perfstats">
   <div>
    <slot name="actions"   :add="add" :repeats="repeats" :reset="reset" :clip="clip"></slot>
    <hr/>
    <slot name="table" :items="items" :headers="headers" :run="run"></slot>
    <slot name="response" :data="response" ></slot>
    </div> 
</template>

<script>{
	props: {
		initial: {default: function(){ return []}
		}
	},
	data:  function(){
	    return {
	      items: [],
	      headers: [
	          { text: 'Action', value: 'id'},
	          { text: 'Repeat', value: 'repeat' },
	          { text: 'Count', value: 'count', align: 'right' },
	          { text: 'Max', value: 'max' , align: 'right' },
	          { text: 'Min', value: 'min' , align: 'right'},
	          { text: 'Median', value: 'median', align: 'right' },
	          { text: 'Last', value: 'last' , align: 'right'},
	          { text: 'Average', value: 'avg' , align: 'right'}
	        ],
	      response: null
	      }
	},	
  methods:{
	  
	    add(id,method,url){
	    	var obj={index:this.items.length, id: id, method:method, url:url, repeat: false,
	    			 count: 0, max: null, min: null, total:0, median:null, last:null, avg:null}
	    	this.items.push(obj)
	    },
	    run(index){
	    	this.update(this.items[index])
	    },
	    
	    clear(index){
	    	var data=this.items[index]
	        data.count= data.total=  0
	        data.max= data.min= data.last= data.avg= data.median= null
	      },
	      
	    update (item) {
	       var _start = performance.now();
	      HTTP.request(item.url, {method: item.method, headers: {accept: 'application/json'}})
	      .then(r=>{
	        var elapsed=Math.floor(performance.now() - _start);
	        this.response=r.data
	        this.log(item,elapsed)
	        if(item.repeat) this.update(item);  
	      })
	    },
	    // update item stats
	    log(item,val){
	        item.last= val
	        item.total+= val;
	        item.count+= 1;
	        if(item.count==1){
	          item.max=val;
	          item.min=val;
	         item.median=val;
	        }else{
	          if(val<item.min)item.min=val;
	          if(val>item.max)item.max=val;
	        };
	        //https://jeremykun.com/2012/06/14/streaming-median/
	        if (item.median > val)
	          item.median-= 1
	        else if( item.median < val)
	          item.median += 1;
	          item.avg=(item.total / item.count).toFixed(2);
	        },
	        
	     repeats(b){
	        	this.$nextTick(() => {
	        	this.items.forEach(item=>item.repeat=b)
	        	})
	        },
	        
	     reset(){
	    	 this.items.forEach(item=>this.clear(item.index))
	     },
	     
	     clip(){
	    	 var txt=this.items.map(item=>item.id + ',' + item.avg).join("\n")
	    	 navigator.clipboard.writeText(txt).then(function() {
	    		  /* clipboard successfully set */
	    		}, function() {
	    		  alert("clipboard write failed")
	    		});
	     }
  },
  created:function(){
      console.log("qd-perfstats:",this.initial);
      this.initial.forEach(item=>this.add(item.id,item.method,item.url))
    }
}
</script>
