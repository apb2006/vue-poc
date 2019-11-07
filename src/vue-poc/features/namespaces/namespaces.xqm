xquery version "3.1";
(:~ 
: namespace rest interface 
: defines urls below vue-poc/data/namespace/
: @author andy bunce
: @since oct 2019
:)

module namespace _ = 'quodatum.model.namespaces';


import module namespace entity ='quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm"; 
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";

(:~ 
 : return a namespace 
 :)
declare 
%rest:GET %rest:path("vue-poc/api/data/namespace/item")
%rest:query-param("id", "{$id}") 
%output:method("json")    
function _:model-list($id) {
 let $entity:=$entity:list("namespace")
 let $_:=trace($id," ID:")
 let $item:=$entity?data()[1]
 return dice:one($item,$entity)
};
