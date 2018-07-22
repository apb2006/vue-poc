(:~
 : evaluTE query library
 :
 : @author Andy Bunce, 2018
 :)
module namespace query-a = 'vue-poc/query-a';
import module namespace request = "http://exquery.org/ns/request";

(:~
 : attributes of a stored query
 :)
declare function query-a:fields($mod as xs:anyURI)
as element(json)
{
let $updating:=xquery:parse-uri($mod)/@updating/string()
let $d:=inspect:module($mod)
let $vars:=$d/variable[@external="true"]
return <json type="object">
   <description>{ $d/description/string() }</description>
    <updating type="boolean" >{  $updating }</updating>
  <fields type="array">{  
  $vars!
        <_ type="object">
         <model>{ @name/string() }</model>
         <label>{ description/string() }</label>
         <type>{ @type/string() }</type>
        </_> 
  }</fields>
   <values type="object">{
   $vars!element{@name}{default_tag/string()}
   }</values>
   </json>
};

declare 
function query-a:params()
as map(*)
{
   map:merge(
           for $p in request:parameter-names() return map:entry($p,request:parameter($p))
           )
};

declare 
function query-a:run($query as xs:anyURI,$params as map(*))
{
   xquery:invoke($query,$params)
};

declare
%updating 
function query-a:update($query as xs:anyURI,$params as map(*))
{
   xquery:invoke-update($query,$params)
};