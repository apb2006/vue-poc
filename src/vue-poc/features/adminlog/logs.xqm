module namespace j = 'quodatum.test.logs';
import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";
(:~
 :  job list
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/log")
%output:method("json")   
function j:list()
as element(json)
{
  let $entity:=$entity:list("basexlog")
 let $items:=$entity("data")()
 let $items:=$items[. ne "[GET] http://localhost:8984/vue-poc/api/log"]
 (: let $_:=admin:write-log("hello admin:write-log") :)
 return dice:response($items,$entity,web:dice())
};

(:~
 :  job info
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/log/{$log}")
%output:method("json")   
function j:log($log)
as element(json)
{
 let $j:=jobs:list-details($log)
 return <json type="object">
         {j:job-json($j)}
        </json>
};

declare function j:job-json($j) 
as element(*)*
{
     <id>{$j/@id/string()}</id>
     ,<type>{$j/@type/string()}</type>
     ,<state>{$j/@state/string()}</state>
     ,<user>{$j/@user/string()}</user>
     ,<duration>{$j/@duration/string()}</duration>
     ,<text>{$j/string()}</text>
};