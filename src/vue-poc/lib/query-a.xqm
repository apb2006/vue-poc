(:~
 : XQuery evalution helpers library
 :    query-a:inspect($mod as xs:anyURI) return {description:.., updating:.., url:.., fields:[{model:..,label:..,type:..}]}
 :    query-a:params($mod as xs:anyURI)
 :    query-a:run($query as xs:anyURI,$params as map(*))
 :
 : @author Andy Bunce, 2018
 :)
module namespace query-a = 'vue-poc/query-a';

import module namespace request = "http://exquery.org/ns/request";


(:~
 : attributes of a stored query including parameters and updating status.
 : @return json format
 :)
declare function query-a:inspect($mod as xs:string)
as element(json)
{
let $mod:= xs:anyURI($mod)
let $updating:=xquery:parse-uri($mod)/@updating/string()
let $d:=inspect:module($mod)
let $vars:=$d/variable[@external="true"]
return <json type="object">
   <description>{ $d/description/string() }</description>
   <updating type="boolean" >{  $updating }</updating>
    <url >{  $mod }</url>
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
 : @return map of request parameter names typed
 :)
declare 
function query-a:params($mod as xs:anyURI)
as map(*)
{
  let $vars:=inspect:module($mod=>trace("params"))/variable[@external="true"]
  return map:merge(
          $vars[@name=request:parameter-names()]!
              map:entry(@name,query-a:cast(request:parameter(@name/string()),@type))

           )
};

(:~ 
 :
 :)
declare
%updating  
function query-a:run($query as xs:string, 
                     $bindings as map(*),
                     $options as map(*)
                   )
{
let $query := xs:anyURI($query)  
let $updating:=xquery:parse-uri($query)/@updating/boolean(.)
return if($updating) then
       xquery:eval-update($query, $bindings, $options)
     else 
       <json type="object">
               <res>{ xquery:invoke($query, $bindings, $options)}</res>
               <params>todo</params>
       </json>=>update:output()
};

declare
%updating  
function query-a:run-json($query as xs:anyURI,$params as map(*))
{ 
  xquery:invoke($query,$params)=>update:output()
};


declare
%updating 
function query-a:update($query as xs:anyURI,$params as map(*))
{
    xquery:invoke-update($query,$params)
};

