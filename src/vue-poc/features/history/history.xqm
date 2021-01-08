(:~
 : vue-poc history api.
 :
 : @author Andy Bunce july-2020
 :)
module namespace vue-api = 'quodatum:vue.api.history';


import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";

(:~
 : history list for $type
 :)
declare
%rest:GET %rest:path("/vue-poc/api/history/{$type}")
%rest:query-param("search", "{$search}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:history( $type as xs:string, $search )   
{
 let $entity:= switch ($type)
               case "file" return $entity:list("history.file")
               case "task" return $entity:list("history.task")
               default return error()
          
  let $items:= $entity("data")()
 return dice:response($items,$entity,web:dice())
};
