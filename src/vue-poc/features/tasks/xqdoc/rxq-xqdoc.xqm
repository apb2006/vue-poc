(:~
 : Generate html for for XQuery sources
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
import module namespace query-a = 'vue-poc/query-a' at "../../../lib/query-a.xqm";
import module namespace fw="quodatum:file.walker";

declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $vue-api:query:="tx-xqdoc.xq";
declare variable $vue-api:state as element(state):=db:open("vue-poc","/state.xml")/state;

(:~
 : run xqdoc task.
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/xqdoc")
%rest:produces("application/json")
%output:method("json")
%updating 
function vue-api:model()   
{
 resolve-uri($vue-api:query)=>query-a:update(query-a:params())
};
  
(:~
 : get xqdoc settings.
 :)
declare
%rest:GET %rest:path("/vue-poc/api/tasks/xqdoc")
%rest:produces("application/json")
%output:method("json")
function vue-api:settings()   
{
    let $xq:=resolve-uri($vue-api:query)
   return query-a:fields($xq)
};