(:~
 : vue-poc thumbnail api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api.eval';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace util = 'vue-poc/util' at "../../lib/util.xqm";
import module namespace ufile = 'vue-poc/file' at "../../lib/file.xqm";

declare variable $vue-api:db as xs:string:="vue-poc";
declare variable $vue-api:id as element(last-id):=db:open("vue-poc","/state.xml")/state/last-id;

(:~
 : eval
 :)
declare
%updating
%rest:POST %rest:path("/vue-poc/api/eval/execute")
%rest:form-param("xq", "{$xq}")
%output:method("json")   
function vue-api:eval($xq )   
{
 let $r:=util:query($xq,())
 return vue-api:response($r)
};

(:~
 : return id and return
 :)
declare
%updating 
function vue-api:response($r)
{
 let $id:=$vue-api:id + 1
 let $out:= <json   type="object" >
              <id>{ $id }</id>
              <result>{$r}</result>
            </json>
  return (
           replace value of node $vue-api:id with $id,
           db:output($out)
          )          
};

(:~
 : submit a simple job
 :)
declare
%updating
%rest:POST %rest:path("/vue-poc/api/eval/submit")
%rest:form-param("xq", "{$xq}")
%output:method("json")   
function vue-api:submit($xq )   
{
 let $bindings:=map{}
 let $opts:=map{"cache":true()}
 let $r:=jobs:eval($xq,$bindings,$opts)
 return vue-api:response($r)
};


(:~
 : query plan
 :)
declare
%rest:POST %rest:path("/vue-poc/api/eval/plan")
%rest:form-param("xq", "{$xq}")
%output:method("json")   
function vue-api:plan($xq )   
{
 let $x:=fn:trace($xq,"task: ")
 let $r:=xquery:parse($xq,map{"compile":true(),"plan":true()})
 return <json   type="object" >
            <result>{ serialize($r) }</result>
  </json>
};


(:~
 : submit a simple job from path 
 :)
declare
%rest:POST %rest:path("/vue-poc/api/eval/invoke")
%rest:form-param("path", "{$path}")
%output:method("json")
%updating    
function vue-api:invoke($path )   
{
 let $path:=ufile:web($path)
 let $xq:=fetch:text($path)
 let $bindings:=map{}
 let $opts:=map{"base-uri":$path,"cache":true()}
 let $r:=jobs:eval($xq,$bindings,$opts)

 return db:output(
 <json   type="object" >
            <job>{$r}</job>
  </json>
  )
};
(:~
 : list available imports
 :)
declare
%rest:GET %rest:path("/vue-poc/api/eval/imports")
%output:method("json")   
function vue-api:imports( )   
{
let $n:='import module namespace fw="quodatum:file.walker";'
 return <json   type="array" >
            <_>{$n}</_>
  </json>
};

(:~ 
 : get result for job with $id
 :)
declare 
%rest:POST %rest:path('/vue-poc/api/eval/result/{$id}') 
%output:method("json") 
function vue-api:result($id) 
{
  let $r:=jobs:result($id)
   return <json   type="object" >
            <result>{util:display($r)}</result>
  </json>
};