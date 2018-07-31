(:~
 : vue-poc search api.
 :
 : @author Andy Bunce aug-2018
 :)
module namespace vue-search = 'quodatum:vue.search';
import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";
import module namespace rest = "http://exquery.org/ns/restxq";

(:~
 : Returns search results
 :)
declare
%rest:path("/vue-poc/api/search")
%rest:query-param("q", "{$q}")
%rest:produces("application/json")
%output:method("json")   
function vue-search:search($q )   
{
  let $entity:=$entity:list("search-result")
  let $items:=(<search>
  <title>No search yet: {$q} </title>
  <uri>database?url=%2F</uri>
  </search>,
  <search>
  <title>soon</title>
  <uri>server/ping</uri>
  </search>)
  
 return dice:response($items,$entity,web:dice())
};

