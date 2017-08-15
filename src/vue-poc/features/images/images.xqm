(:~
 : vue-poc thumbnail api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api.images';
import module namespace cfg = "quodatum:media.image.configure" at "config.xqm";
import module namespace fw="quodatum:file.walker";
import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $vue-api:entity:=$entity:list("thumbnail");
(:~
 : do a thumbnail
 :)
declare
%rest:GET %rest:path("/vue-poc/api/images/list/{ $id }")
%rest:produces("application/json")
%output:method("json")   
function vue-api:id( $id as xs:integer)   
{
 let $image:=db:open-id("vue-poc",$id)
 return <json type="object" >
    <doc>{ serialize($image) }</doc>
     { vue-api:get-image($image) }
  </json>
};
(:~
 : do a thumbnail
 :)
declare
%rest:GET %rest:path("/vue-poc/api/images/list")
%rest:produces("application/json")
%rest:query-param("page", "{$page}",0)
%rest:query-param("from", "{$from}")
%rest:query-param("until", "{$until}")
%rest:query-param("keyword", "{$keyword}")
%output:method("json")   
function vue-api:list( $page as xs:integer,
$from,$until,
$keyword
)   
{
 let $rowsPerPage:=24
 let $images:=$vue-api:entity("data")()
 let $images:=if($from)then  $images[datetaken ge $from] else $images
 let $images:=if($until)then  $images[datetaken le $until] else $images
 let $images:=if($keyword)then  $images[keywords/keyword = $keyword] else $images
 let $images:=subsequence($images,1+$rowsPerPage*$page,$rowsPerPage)
 
 return <json   type="object" >
            <items type="array">{
            for $f in $images
            return <_ type="object">
            {vue-api:get-image($f)} 
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

(:~ fields for image for json :)
declare function vue-api:get-image($image as element(image))
as element(*)*
{
let $id:=$vue-api:entity?access?id($image)
let $path:=$vue-api:entity?access?path($image)
let $name:=$vue-api:entity?access?name($image)
let $thumb:= $cfg:THUMBDIR || $path
let $thumb:=if(file:exists($thumb)) then $thumb else $cfg:THUMBDIR || "missing.jpg"
return   ( <id>{$id}</id>
          ,<name>{$name}</name>
         ,<data>{fetch:binary($thumb)}</data>
         ,<mime>{fetch:content-type($thumb)}</mime>)
};



