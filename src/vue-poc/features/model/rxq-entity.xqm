(:~ 
: entity rest interface 
: defines urls below vue-poc/data/entity/
: @author andy bunce
: @since jun 2013
:)

module namespace model-rest = 'quodatum.model.rest';
declare default function namespace 'quodatum.model.rest'; 

import module namespace entity ='quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm"; 
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";
declare namespace ent="https://github.com/Quodatum/app-doc/entity"; 

declare variable $model-rest:models:=db:open("vue-poc")//ent:entity;

(:~ 
 : return list of entities 
 :)
declare 
%rest:GET %rest:path("vue-poc/api/data/entity")
%rest:query-param("q", "{$q}") 
%output:method("json")    
function model-list($q) {
 let $entity:=$entity:list("entity")
 let $items:=$entity?data()
 let $items:=if($q)then $items[fn:contains($entity("access")("name")(.),$q)] else $items
 return dice:response($items,$entity,web:dice())
};


(:~
 : Returns data results
 :)
declare
%rest:path("/vue-poc/api/data/{$entity}")
%rest:query-param("q", "{$q}")
%rest:produces("application/json")
%output:method("json")   
function data($entity as xs:string,$q )   
{
  let $entity:=$entity:list($entity)
  let $items:=$entity("data")()
  
 return dice:response($items,$entity,web:dice())
};

(:~ 
 : details of the entity $entity
 :)
declare 
%rest:GET %rest:path("vue-poc/api/data/entity/{$entity}")
%rest:produces("application/json")
%output:method("json")    
function model($entity) {
let $this:=$entity:list("entity")
 let $items:=$this?data()
 let $fields:=$this?json
 let $item:=$items[@name=$entity]
 (: just one :)
 return <json objects="json">{dice:json-flds($item,$fields)/*}</json>

};

(:~ 
 : details of the entity $entity
 :)
declare 
%rest:GET %rest:path("vue-poc/api/data/entity/{$entity}")
%rest:produces("text/xml;qs=0.8")
%output:method("xml")    
function model2($entity) {
let $this:=$entity:list("entity")
 let $items:=$this?data()
 let $fields:=$this?json
 let $item:=$items[@name=$entity]
 (: just one :)
 return <json objects="json">{dice:json-flds($item,$fields)/*}</json>

};

(:~ 
 : field list for model 
 :)
declare 
%rest:GET %rest:path("vue-poc/api/data/entity/{$entity}/field")
%output:method("json")    
function field-list($entity) {
    let $dentity:=$entity:list("entity")
    let $items:=$dentity?data()
    let $items:=$items[@name=$entity]/ent:fields/ent:field
    let $fentity:=$entity:list("entity.field")
    return dice:response($items,$fentity,web:dice())
                      
};