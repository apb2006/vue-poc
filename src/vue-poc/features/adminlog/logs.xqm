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
 let $items:=$items[false() or not(ends-with(. ,"/vue-poc/api/log"))]
 (: let $_:=admin:write-log("hello admin:write-log") :)
 return dice:response($items,$entity,web:dice())
};

declare  
%rest:POST %rest:path("/vue-poc/api/log/add")
%output:method("text")   
function j:add()
{
let $type:="INFO"
let $text:="A log message"
 return ("AAAA",
     admin:write-log($text, $type ) 
     )
};
