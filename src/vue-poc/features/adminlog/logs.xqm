module namespace j = 'quodatum.test.logs';
import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";

(:~
 :  show active log
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

(:~
 :  show archive log
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/logxml")
%rest:query-param("from", "{ $from }", "00:00:00")
%rest:query-param("date", "{ $date }")
%rest:query-param("window", "{ $window }")
%output:method("json")   
function j:archive( $date as xs:string,$from as xs:string,$window)
as element(json)
{
 let $start:=xs:dateTime(concat($date,"T",$from))=>trace("archive")
 let $items:=db:open("vue-poc","/logs/")[contains(base-uri(),$date)]/entries/entry
 
 let $items:= if ($from) then $items[@time ge $from] else $items
  let $entity:=$entity:list("logxml")=>prof:time("entity")
 return dice:response($items,$entity,web:dice())
};


(:~ 
 : create a log entry
 :)
declare  
%rest:POST %rest:path("/vue-poc/api/log/add")
%rest:form-param("type", "{$type}")
%rest:form-param("message", "{$message}")
%output:method("text")   
function j:add($type as xs:string,
               $message as xs:string)
{
  let $_:=trace(($type,$message),"post")
  return (
   "AAAA",
   admin:write-log($message, $type ) 
   )
};
