(:~
 : vue-poc collection api.
 :
 : @author Andy Bunce july-2017
 :)
module namespace vue-api = 'quodatum:vue.api.collection';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace ufile = 'vue-poc/file' at "../../lib/file.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";


(:~
 : history list 
 :)
declare
%rest:GET %rest:path("/vue-poc/api/history")
%rest:produces("application/json")
%output:method("json")   
function vue-api:history( )   
{
 let $h:=doc("history.xml")/history/entry
 return <json   type="object" >
            <items type="array">
            {$h!(<_ type="object">
            <url>{@url/string()}</url>
            <protocol>{@mode/string()}</protocol>
            </_>)}              
            </items>
  </json>
};


(:~
 : Returns folder info.
 :)
declare
%rest:path("/vue-poc/api/collection")
%rest:query-param("url", "{$url}")
%rest:query-param("protocol", "{$protocol}","webfile")
%rest:produces("application/json")
%output:method("json")   
function vue-api:file($url as xs:string,$protocol as xs:string)
as element(json)   
{
   let $reader:=map{
              "webfile":ufile:webfile#1,
              "basexdb":ufile:basexdb#1
              }
   let $items:=$reader($protocol)($url)
   return vue-api:items($items)
};        



declare function vue-api:items($items)
as element(json)
{
   <json type="object" >
              <folders type="array">
              {for $f in $items/c:directory
              order by $f/@name/lower-case(.)
              return <_ type="object">
               {vue-api:details($f,"folder")}
              </_>
              }
              </folders>
               <files type="array">
              {for $f in $items/c:file
              order by $f/@name/lower-case(.)
              return <_ type="object">
              {vue-api:details($f,"insert_drive_file")}
              </_>
              }
              </files>
           </json>
};
      
declare function vue-api:details($f as element(*),$icon as xs:string)
as element(*)*
{
 <name>{$f/@name/string()}</name>
 ,<icon>{$icon}</icon>
 ,<modified>{$f/@last-modified/string()}</modified>
 ,<size type="number">{$f/@size/string()}</size>
 ,<mime>unknown</mime>
};


