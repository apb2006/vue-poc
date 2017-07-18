(:~
 : vue-poc thumbnail api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api.images';
import module namespace fw="quodatum:file.walker";
import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $vue-api:PICS:="c:\tmp\";

(:~
 : do a thumbnail
 :)
declare
%rest:GET %rest:path("/vue-poc/api/images/list")
%rest:produces("application/json")
%rest:query-param("page", "{$page}",0)
%rest:query-param("from", "{$from}")
%rest:query-param("keyword", "{$keyword}")
%output:method("json")   
function vue-api:list( $page as xs:integer,
$from,
$keyword
)   
{
 let $a:=trace(($from,$keyword),"----------")
 let $rowsPerPage:=24
 let $entity:=$entity:list("thumbnail")
 let $images:=$entity("data")()
 let $images:=if($from)then  $images[datetaken ge $from] else $images
 let $images:=if($keyword)then  $images[keywords/keyword = $keyword] else $images
 let $images:=subsequence($images,1+$rowsPerPage*$page,$rowsPerPage)
 
 return <json   type="object" >
            <items type="array">{
            for $f in $images
            return <_ type="object">
            {vue-api:get-image($f,$entity)} 
            </_>
            }</items>
  </json>
};

(:~
 : keywords
 :)
declare
%rest:GET %rest:path("/vue-poc/api/images/keywords")
%rest:produces("application/json")
%output:method("json")   
function vue-api:keywords()   
{
let $keys:=
collection("/vue-poc/Pictures")/image/keywords/keyword
=>distinct-values()
=>sort("http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive")
return <json   type="object" >
            <items type="array">{
            $keys!<_ >{.}</_>
            }</items>
  </json>
};

declare function vue-api:get-image($image as element(image),$entity)
as element(*)*
{
let $id:=$entity?access?id($image)
let $path:=$entity?access?path($image)
let $name:=$entity?access?name($image)
let $thumb:= $vue-api:PICS || $path
let $thumb:=if(file:exists($thumb)) then $thumb else "C:\tmp\art.jpg"
return   ( <id>{$id}</id>
          ,<name>{$name}</name>
         ,<data>{fetch:binary($thumb)}</data>
         ,<mime>{fetch:content-type($thumb)}</mime>)
};



