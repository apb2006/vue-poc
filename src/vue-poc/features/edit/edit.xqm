(:~
 : vue-poc api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace session = "http://basex.org/modules/session";
import module namespace ufile = 'vue-poc/file' at "../../lib/file.xqm";

import module namespace mt = 'quodatum.data.mimetype' at "../../lib/mimetype.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";


(:~
 : Returns a file content.
 :)
declare
%rest:GET %rest:path("/vue-poc/api/edit")
%rest:query-param("url", "{$url}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:edit-get($url as xs:string)   
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
            error(xs:QName('vue-api:raw'),$path)
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

