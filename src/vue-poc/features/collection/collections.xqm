(:~
 : vue-poc collection api.
 :
 : @author Andy Bunce july-2017
 :)
module namespace vue-api = 'quodatum:vue.api.collection';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace fw="quodatum:file.walker";
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
 let $h:=(
 '/vue-poc/vue-poc.xqm',
 '/vue-poc/data/vue-poc/ch4d1.xml',
 '/vue-poc/static/app-gen.js',
 '/vue-poc/static/app.html',
 '/vue-poc/static/app.css',
 '/vue-poc/logo.svg',
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
 : Returns folder info.
 :)
declare
%rest:path("/vue-poc/api/file")
%rest:query-param("url", "{$url}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:file($url as xs:string)   
{
   let $path := ufile:web( $url)=>trace("vue-api:web ")
   return if( file:exists($path))then 
             let $items:=fw:directory-list($path,map{"max-depth":1,"include-info":true()})

             return <json type="object" >
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
          else 
            error(xs:QName('vue-api:raw'),$path)
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
