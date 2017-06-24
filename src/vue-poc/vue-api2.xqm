(:~
 : vue-poc api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace session = "http://basex.org/modules/session";
import module namespace fw="quodatum:file.walker";
import module namespace mt = 'quodatum.data.mimetype' at "lib/mimetype.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare namespace wadl="http://wadl.dev.java.net/2009/02";



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
            <session>{session:id()}</session>
            <created>{session:created()}</created>
  </json>
};


(:~
 : history list 
 :)
declare
%rest:GET %rest:path("/vue-poc/api/history")
%rest:produces("application/json")
%output:method("json")   
function vue-api:history( )   
{
 let $h:=(
 '/vue-poc/vue-poc.xqm',
 '/vue-poc/data/vue-poc/ch4d1.xml',
 '/vue-poc/static/app-gen.js',
 '/vue-poc/static/app.html',
 '/vue-poc/static/app.css',
 '/vue-poc/static/resources/sparql.rq',
  '/vue-poc/static/resources/turtle.ttl'
 )

 return <json   type="object" >
            <items type="array">
            {$h!(<_ type="object"><url>{.}</url></_>)}              
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
%rest:GET %rest:path("/vue-poc/api/edit")
%rest:query-param("url", "{$url}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:edit-get($url as xs:string)   
{
  let $path := vue-api:web( $url)=>trace("path ")
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
  let $path := vue-api:web( $url)=>trace("path ")
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

