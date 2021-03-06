(:~
 : vue-poc collection api.
 :
 : @author Andy Bunce july-2017
 :)
module namespace vue-api = 'quodatum:vue.api.collection';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace ufile = 'vue-poc/file' at "../../lib/file.xqm";

import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";


(:~
 : xqdoc list 
 :)
declare
%rest:GET %rest:path("/vue-poc/api/xqdoc")
%rest:produces("application/json")
%output:method("json")   
function vue-api:xqdoc( )   
{
 let $entity:=$entity:list("xqdoc")
  let $items:= $entity("data")()
 return dice:response($items,$entity,web:dice())
};

(:~
 : Returns contents of a collection. example calls  
 :   <code>/vue-poc/api/collection?url=/&protocol=xmldb</code>
 :   <code>/vue-poc/api/collection?url=/</code>
 : @param $url collection identifier, a path 
 : @param $protocol 'webfile' or 'xmldb'
 :)
declare
%rest:GET %rest:path("/vue-poc/api/collection")
%rest:query-param("url", "{$url}")
%rest:query-param("protocol", "{$protocol}","webfile")
%rest:produces("application/json")
%output:method("json")   
function vue-api:file($url as xs:string,$protocol as xs:string)
as element(json)   
{
   let $reader:=map{
              "webfile":ufile:webfile#1,
              "xmldb":ufile:xmldb#1
              }
   let $items:=$reader($protocol=>trace("PROTO"))($url)
   return vue-api:items($items)
};        



declare function vue-api:items($items)
as element(json)
{
   <json type="object" >
              <items type="array">
              {for $f in $items/*
              order by $f/@name/lower-case(.)
              return <_ type="object">
               {vue-api:details($f,"folder")}
              </_>
              }
              </items>
           </json>
};
      
declare function vue-api:details($f as element(*),$type as xs:string)
as element(*)*
{
 <name>{$f/@name/string()}</name>
 ,<type>{if(local-name($f)="file" )then "file" else "folder"}</type>
 ,<modified>{$f/@last-modified/string()}</modified>
 ,<size type="number">{$f/@size/string()}</size>
 ,<selected type="boolean">false</selected>
 ,<mime>{$f/@content-type/string()}</mime>
};


