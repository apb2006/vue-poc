(:~
 : XQuery evaluation of uri helper library
 :    query-a:inspect($mod as xs:anyURI) return {description:.., updating:.., url:.., fields:[{model:..,label:..,type:..}]}
 :    request-bindings($mod as xs:anyURI)
 :    query-a:run($query as xs:anyURI,$params as map(*))
 :
 : @author Andy Bunce, 2018
 :)
module namespace query-a = 'vue-poc/query-a';

import module namespace request = "http://exquery.org/ns/request";
import module namespace xquery = "http://basex.org/modules/xquery";


(:~
 : attributes of a stored query including parameters and updating status.
 : @return json format
 :)
declare function query-a:inspect($mod as xs:string)
as element(json)
{
let $mod:= xs:anyURI($mod)
let $updating:=xquery:parse($mod)/@updating/string()
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
		   		$vars!element{@name}{ query-a:param-json( @type ), default_tag/string()}
		   }</values>
      </json>
};

(:~ 
 :convert value to XQuery for given type
:)
declare function query-a:cast($val as item(),$type as xs:string)
as item() 
{
  switch($type)
   case "xs:boolean" return $val="true"
   case "xs:integer" return xs:int($val)
   case "xs:anyURI" return xs:anyURI($val)
   default          return $val
};

(:~ 
 :json type for xs type
:)
declare function query-a:param-json($type as xs:string)
as attribute(type)?
{
  switch($type)
   case "xs:boolean" return attribute type {"boolean"}
   case "xs:integer" return  attribute type {"number"}
   default          return ()
};

(:~
 : @return map of request parameter names that are external variables, map{name:..,value}
 :)
declare 
function query-a:request-bindings($mod as xs:anyURI)
as map(*)
{
  let $vars:=inspect:module($mod)/variable[@external="true"]
  let $f:=function($name, $type){ map:entry($name,
                                            query-a:cast(request:parameter($name/string()),$type)
                                            )}
  return 
          $vars[@name=request:parameter-names()]! $f(@name,@type)=>map:merge()             
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
let $query := xs:anyURI($query) =>trace("query-a:run") 
let $updating:=xquery:parse($query)/@updating/boolean(.)
return if($updating) then
       xquery:eval-update($query, $bindings, $options)
     else 
       <json type="object">
               <res>{ xquery:eval($query, $bindings, $options)}</res>
               <params>todo</params>
       </json>=>update:output()
};

declare
%updating  
function query-a:run-json($query as xs:anyURI,$params as map(*))
{ 
  xquery:eval($query,$params)=>update:output()
};


declare
%updating 
function query-a:update($query as xs:anyURI,$params as map(*))
{
    xquery:eval-update($query,$params)
};

