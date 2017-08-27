// performance monitoring. of value stream
// stores max min etc
function perfStat() {   
  this.data={count:0,max:null,min:null,total:0,median:0,last:null,avg:null};
  // add a value return updated stats
  this.log=function(val){
    var data=this.data
    data.last=val;
    data.total+=val;
    data.count+=1;
    if(data.count==1){
      data.max=val;
      data.min=val;
     data.median=val;
    }else{
      if(val<data.min)data.min=val;
      if(val>data.max)data.max=val;
    };
    //https://jeremykun.com/2012/06/14/streaming-median/
    if (data.median > val)
      data.median-= 1
    else if( data.median < val)
      data.median += 1;

    data.avg=data.total / data.count;
   // console.log("stats",data);
    return data;
  };
  // clear stats
  this.clear=function(){
    this.data={count:0,max:null,min:null,total:0,median:0,last:null,avg:null};
    return this.data
  };
  // return values
  this.values=function(){
    return this.data;
  };
}