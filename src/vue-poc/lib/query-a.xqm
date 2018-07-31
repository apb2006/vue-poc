(:~
 : evaluTE query library
 :
 : @author Andy Bunce, 2018
 :)
module namespace query-a = 'vue-poc/query-a';
import module namespace hlog = 'quodatum.data.history' at 'history.xqm';
import module namespace request = "http://exquery.org/ns/request";
declare namespace map2='http://www.woerteler.de/xquery/modules/map-extras';
(:~
 : attributes of a stored query including parameters and updating status.
 : @return json format
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

(:~ 
 :convert type
:)
declare function query-a:cast($val as item(),$type as xs:string)
as item() 
{
  switch($type)
   case "xs:anyURI" return xs:anyURI($val)
   default          return $val
};

(:~ 
 :@return map param->type
:)
declare function query-a:types($mod as xs:anyURI)
as map(*)
{
  let $vars:=inspect:module($mod)/variable[@external="true"]
  return map:merge(
   $vars!map:entry(@name/string(),@type/string())
  )
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
%updating  
function query-a:run($query as xs:anyURI,$params as map(*))
{
   let $types:=query-a:types($query)
   let $params:=query-a:map-with-key($params,
   function($key,$val){
   switch($types($key)=>trace("CONV"))
   case "xs:anyURI" return xs:anyURI($val)
   default          return $val
   }
   )
   
   return (
   xquery:invoke($query,$params)=>update:output(),
   hlog:save(<task url="{ $query }">
   <params/>
   </task>)
 )
};

declare
%updating 
function query-a:update($query as xs:anyURI,$params as map(*))
{
   xquery:invoke-update($query,$params)
};

(:~
 : Maps a function over all entries of the map <code>$map</code>.
 : Each entry <code>($key, $value)</code> in the map is replaced by a new
 : entry <code>($key, $f($key, $value))</code>, the keys are not touched.
 :
 : @param $f function to be applies to all entries
 : @param $map input map
 : @return copy of <code>$map</code> where all values <code>$value</code>
 :         are replaced by <code>$f($key, $value)</code>
 :)
declare function query-a:map-with-key(
  $map as map(*),
  $f as function(item(), item()*) as item()*
) as map(*) 
{
  map:merge(
    for $key in map:keys($map)
    return map:entry($key, $f($key, $map($key)))
  )
};
