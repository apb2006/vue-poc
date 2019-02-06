module namespace ping = 'quodatum.test.ping';
declare variable $ping:db as xs:string:="vue-poc";
declare %basex:lazy variable $ping:state as element(state):=db:open($ping:db,"/state.xml")/state;

(:~
 :  ping incr counter
 :)
declare %updating  
%rest:POST %rest:path("/vue-poc/api/ping")
%output:method("text")
function ping:dopost()
{
    (replace value of node $ping:state/ping with 1+$ping:state/ping,
            update:output(1+$ping:state/ping))
};

(:~
 :  ping incr counter
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("/vue-poc/api/ping")
function ping:dostate()
{
  $ping:state/ping
};

(:~
 :  ping fastest no work
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("/vue-poc/api/nodb")
function ping:nodb()
{
  "ok"
};