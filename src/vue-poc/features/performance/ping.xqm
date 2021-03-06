xquery version "3.1";
(:~
 : Simple server performance test
 :)
module namespace ping = 'quodatum.test.ping';
declare variable $ping:db as xs:string:="vue-poc";
declare %basex:lazy variable $ping:state as element(state):=db:open($ping:db,"/state.xml")/state;

(:~
 :  incr counter
 :)
declare %updating  
%rest:POST %rest:path("/vue-poc/api/performance/ping")
%output:method("text")
function ping:dopost()
{( 
     replace value of node $ping:state/ping with 1+$ping:state/ping,
     update:output(1+$ping:state/ping)
)};

(:~
 :  read counter
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("/vue-poc/api/performance/ping")
function ping:dostate()
{
  $ping:state/ping
};

(:~
 :  return simple constant
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("/vue-poc/api/performance/nodb")
function ping:nodb()
{
  "ok"
};