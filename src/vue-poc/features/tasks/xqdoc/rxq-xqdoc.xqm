(:~
 : Generate html for for XQuery sources
 :)
module namespace vue-api = 'quodatum:vue.api';

import module namespace query-a = 'vue-poc/query-a' at "../../../lib/query-a.xqm";

declare variable $vue-api:query as xs:anyURI :=resolve-uri("tx-xqdoc.xq");


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
 resolve-uri($vue-api:query)=>query-a:update(query-a:params($vue-api:query))
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