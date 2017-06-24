module namespace ping = 'quodatum.test.ping';
declare variable $ping:db as xs:string:="doc-doc";
declare variable $ping:state as element(state):=db:open($ping:db,"/state.xml")/state;

(:~
 :  ping incr counter
 :)
declare %updating  
%rest:POST %rest:path("/vue-poc/api/ping")
%output:method("text")
function ping:dopost()
{
    (replace value of node $ping:state/hits with 1+$ping:state/hits,
            db:output(1+$ping:state/hits))
};

(:~
 :  ping incr counter
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("/vue-poc/api/ping")
function ping:dostate()
{
  $ping:state/hits
};