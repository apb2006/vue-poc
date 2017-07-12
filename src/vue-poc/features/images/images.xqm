(:~
 : vue-poc thumbnail api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api.images';
import module namespace thb="expkg-zone58:image.thumbnailator";
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $vue-api:PICS:="c:\tmp\";

(:~
 : do a thumbnail
 :)
declare
%rest:GET %rest:path("/vue-poc/api/images/list")
%rest:produces("application/json")
%rest:query-param("page", "{$page}",0)
%output:method("json")   
function vue-api:list( $page as xs:integer)   
{
 let $rowsPerPage:=24
 let $opt:=map{"include-filter":".*\.jpg",
              "max-depth":-1,
              "include-info":true()}
let $d:= fw:directory-list($vue-api:PICS,$opt)
let $f:=$d//c:file/@name/resolve-uri(encode-for-uri(.),base-uri(.))
let $images:=subsequence($f,1+$rowsPerPage*$page,$rowsPerPage)
 return <json   type="object" >
            <items type="array">{
            for $f in $images
            return <_ type="object">
            {vue-api:get-image($f)} 
            </_>
            }</items>
  </json>
};


declare function vue-api:get-image($f as xs:string)
as element(*)*
{
         <name>{$f}</name>
         ,<data>{fetch:binary($f)}</data>
         ,<mime>{fetch:content-type($f)}</mime>
};



