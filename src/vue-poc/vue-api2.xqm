(:~
 : vue-poc api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace rest = "http://exquery.org/ns/restxq";

import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare namespace wadl="http://wadl.dev.java.net/2009/02";
declare namespace MediaType='java:org.basex.util.http.MediaType';
declare variable $vue-api:index:=file:base-dir() || 'static/' || "app.html";


(:~
 : Returns a query result.
 :)
declare
%rest:path("/vue-poc/api/test-select")
%rest:query-param("q", "{$q}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:test-select($q )   
{
  <json   type="object" >
            <items type="array">
            {(1 to 100)!(<_>A{.}</_>)}              
            </items>
  </json>
};

(:~
 : get status
 :)
declare
%rest:GET %rest:path("/vue-poc/api/status")
%rest:produces("application/json")
%output:method("json")   
function vue-api:status( )   
{
let $user:=user:current()
let $detail:=user:list-details($user)
return  <json   type="object" >
            <user>{$user}</user>
            <permission>{$detail/@permission/string()}</permission>
  </json>
};

(:~
 : do a thumbnail
 :)
declare
%rest:POST %rest:path("/vue-poc/api/thumbnail")
%rest:form-param("url", "{$url}")
%rest:form-param("task", "{$task}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:thumbnail($url,$task )   
{
 let $x:=fn:parse-xml($task)=>fn:trace("task: ")
 return <json   type="object" >
            <items type="array">
            {(1 to 100)!(<_>A{.}</_>)}              
            </items>
  </json>
};

(:~
 : Returns wadl.
 :)
declare
%rest:path("/vue-poc/api")
function vue-api:wadl()   
{
 rest:wadl()
};

(:~
 : Returns a file content.
 :)
declare
%rest:path("/vue-poc/api/raw")
%rest:query-param("url", "{$url}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:raw($url as xs:string)   
{
  let $path := vue-api:web( $url)=>trace("path ")
   return if( file:exists($path))then 
             let $type:=vue-api:type($path)
             let $fetch:=vue-api:fetch-fn($type("treat-as"))
             return <json type="object" >
                        <url>{$url}</url>
                        <mimetype>{$type?type}</mimetype>
                        <data>{$fetch($path)}</data> 
                     </json>
          else 
            error(xs:QName('vue-api:raw'),$path)
};

(:~
 : Returns folder info.
 :)
declare
%rest:path("/vue-poc/api/file")
%rest:query-param("url", "{$url}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:file($url as xs:string)   
{
   let $path := vue-api:web( $url)=>trace("vue-api:web ")

   
   return if( file:exists($path))then 
             let $items:=fw:directory-list($path,map{"max-depth":1,"include-info":true()})

             return <json type="object" >
                        <folders type="array">
                        {for $f in $items/c:directory
                        order by $f/@name/lower-case(.)
                        return <_ type="object">
                        <name>{$f/@name/string()}</name>
                        <icon>folder</icon>
                         <modified>{$f/@last-modified/string()}</modified>
                         <size type="number">{$f/@size/string()}</size>
                        </_>
                        }
                        </folders>
                         <files type="array">
                        {for $f in $items/c:file
                        order by $f/@name/lower-case(.)
                        return <_ type="object">
                        <name>{$f/@name/string()}</name>
                         <icon>insert_drive_file</icon>
                          <modified>{$f/@last-modified/string()}</modified>
                         <size type="number">{$f/@size/string()}</size>
                        </_>
                        }
                        </files>
                     </json>
          else 
            error(xs:QName('vue-api:raw'),$path)
};

(:~
 : resolve path relative to basex webpath
 : file("/fred")=>C:\Program Files (x86)\BaseX\webapp\fred
 :)
declare function vue-api:web($file as xs:string)
as xs:string
{
  let $file:=if(starts-with($file,"/")) then 
                substring($file,2) 
            else 
                error(xs:QName('vue-api:badpath'),"leading slash")
                 
  let $webroot:=db:system()/globaloptions/webpath/concat(.,"/")
  return file:resolve-path($file,$webroot)
};

(:~ 
 : fetch function for given data type "text","xml","binary"
: @return function()
:)
declare function vue-api:fetch-fn($treat as xs:string)
as function(*)
{
     switch  ($treat) 
     case "text"
          return fetch:text(?)
     case "xml" 
          return fetch:text(?)
     default 
          return fetch:binary(?)
};

(:~ classify file as binary/text/xml
 :)
declare function vue-api:type($filepath as xs:string)
as map(*)
{
let $f:=vue-api:base-ext($filepath)
let $a:=MediaType:get($f)
let $type:= if(MediaType:isXML($a)) then 
            "xml"
            else if(MediaType:isText($a) or MediaType:isXQuery($a))then
            "text"
            else
            "binary"
 return map{"type":MediaType:type($a) ,"treat-as":$type}
};


(:~ change file to have baseextension
:)
declare function vue-api:base-ext($filepath as xs:string)
{
  let $ext:=replace ($filepath,'^.*\.','')
  let $ext:=if(contains($filepath,"/"))then '' else $ext
  let $types:=map{"vue":".html"}
  return if($types($ext)) then $types($ext) else $filepath
};