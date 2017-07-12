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

(:~ defines accessor functions for each collection type
:)
declare variable $vue-api:MODE:=map{
"webfile":
      function($url)
      as element(c:directory)
      {
       let $path := ufile:web( $url)=>trace("vue-api:web ")
         return if( file:exists($path))then 
                   fw:directory-list($path,map{"max-depth":1,"include-info":true()})
                else
                    error(xs:QName('vue-api:badpath'),$path)
      },
"basexdb":
      function($url)
      as element(c:directory)
      {
        <c:directory  name="" xml:base="basexdb:/" last-modified="2017-07-01T13:39:38.98691Z" size="4096">{
         if($url="/") then
             db:list()!
             <c:directory name="{db:property(.,'name')}" 
                     last-modified="{db:property(.,'timestamp')}" 
                     size="{db:property(.,'size')}"/>
           
        else
          let $map:=vue-api:collection-next($url)
          for $name in map:keys($map)
          (: db:list-details($db as xs:string, $path as xs:string) as element(resource)* :)
          return if($map($name)="file") then
                    <c:file name="{$name}" size="0"/>
                  else
                    <c:directory name="{$name}"  size="0"/>
      }</c:directory>
}
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
 let $h:=doc("history.xml")/history/entry
 return <json   type="object" >
            <items type="array">
            {$h!(<_ type="object">
            <url>{@url/string()}</url>
            <mode>{@mode/string()}</mode>
            </_>)}              
            </items>
  </json>
};


(:~
 : Returns folder info.
 :)
declare
%rest:path("/vue-poc/api/file")
%rest:query-param("url", "{$url}")
%rest:query-param("protocol", "{$protocol}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:file($url as xs:string,$protocol as xs:string?)
as element(json)   
{
   let $mode:=if(map:contains($vue-api:MODE,string($protocol)))then $protocol else "webfile"
   let $reader:=$vue-api:MODE($mode)
   let $items:=$reader($url)
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


(:~ return map of next level database contents
 :@param $url a database base collection e.g /dbname/fred/
:)
declare function vue-api:collection-next($url as xs:string)
as map(*)
{
 if(not(starts-with($url,"/")) or ends-with($url,"/")) then
  error(xs:QName('vue-api:badpath'),$url)
 else 
 fold-left(
    uri-collection($url ),
    map{},
    function($acc,$this){
      let $s:=substring-after($this ,$url || "/")
      let $isDir:=contains($s,"/") 
      let $s:=if($isDir)then substring-before($s,"/")  else $s
      return map:merge((map:entry($s,if($isDir)then "directory" else "file"),$acc))
    }
  )
};
