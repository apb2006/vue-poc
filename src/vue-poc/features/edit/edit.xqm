(:~
 : vue-poc api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace session = "http://basex.org/modules/session";
import module namespace ufile = 'vue-poc/file' at "../../lib/file.xqm";
import module namespace  resolve = 'urn:quodatum:resolve' (: at "../../lib/resolve.xqm" :) ;

import module namespace mt = 'urn:quodatum:data:mimetype' at "../../lib/mimetype.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";


(:~
 : Returns a file content.
 :)
declare
%rest:GET %rest:path("/vue-poc/api/edit")
%rest:query-param("url", "{ $url }")
%rest:produces("application/json")
%output:method("json")   
function vue-api:edit-get($url as xs:string)   
{
  let $u:=resolve:parse($url)=>trace("RESOLVE: ")
   return <json type="object">{
		        element protocol{ $u?protocol},
		        element path { $u?path },
		        element mimetype { $u?fnMime() },
                element data { $u?fnGet() =>serialize()}
          }</json>
};

(:~
 : Update a file content. @TODO
 :)
declare
%rest:POST %rest:path("/vue-poc/api/edit")
%rest:form-param("url", "{$url}")
%rest:form-param("data", "{$data}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:edit-post($url as xs:string,$data)   
{
  let $path := ufile:web( $url)=>trace("path ")
  let $data:=trace($data)
   return if( file:exists($path))then 
             let $type:=mt:type($path)
             let $fetch:=mt:fetch-fn($type("treat-as"))
             return <json type="object" >
                        <url>{$url}</url>
                        <mimetype>{$type?type}</mimetype>
                        <data>{$fetch($path)}</data> 
                     </json>
          else 
            error(xs:QName('vue-api:raw'),$path)
};

(:~
 : Returns a file content.
 :)
declare 
%rest:GET %rest:path("/vue-poc/api/get2")
%rest:query-param("url", "{$url}")
function vue-api:get-webfile($url as xs:string?)   
as element(json)
{
  let $path := ufile:web( $url)=>trace("path ")
   return if( file:exists($path))then 
             let $type:=mt:type($path)
             let $fetch:=mt:fetch-fn($type("treat-as"))
             return <json type="object" >
                        <url>{$url}</url>
                        <mimetype>{$type?type}</mimetype>
                        <data>{$fetch($path)}</data> 
                     </json>
          else 
            error(xs:QName('vue-api:raw'),$url)
};

(:~
 : Returns a file content.
 : @param $url starts with protocol accepts xmldb:path, file:path, webfile:/ path 
 :)
declare 
%rest:GET %rest:path("/vue-poc/api/get")
%rest:query-param("url", "{$url}")
%output:method("json")  
function vue-api:get-file($url as xs:string?)   
as element(json)
{
  let $protocol := substring-before($url,":")
  let $path:=if($protocol eq "webfile") then
                  substring-after($url,":") =>ufile:web()
             else
                $url
                
   return if( file:exists($path))then 
             let $type:=mt:type($path)
             let $fetch:=mt:fetch-fn($type("treat-as"))
             return <json type="object" >
                        <url>{$url}</url>
                        <mimetype>{$type?type}</mimetype>
                        <data>{$fetch($path)}</data> 
                     </json>
          else 
            error(xs:QName('vue-api:raw'),$url)
};

(:~
 : Returns a file content.
 :)
declare function vue-api:get-basexdb($url as xs:string)
as element(json)   
{
  if( doc-available($url))then 
            
             let $doc:=doc($url)
             return <json type="object" >
                        <url>{$url}</url>
                        <mimetype>application/xml</mimetype>
                        <data>{serialize($doc)}</data> 
                     </json>
          else 
            error(xs:QName('vue-api:get-basexdb'),$url)
};