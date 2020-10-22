(:~ 
 : generate xquery access code for entity definitions
 :)
module namespace bf = 'quodatum.tools.buildfields';
declare namespace ent="https://github.com/Quodatum/app-doc/entity"; 


(:~
 : generate xquery module for given entities as a string
 :)
declare function bf:module($entities as element(ent:entity)*,$imports)
as xs:string
{
let $src:= <text>(: entity access maps 
 : auto generated from xml files in entities folder at: {fn:current-dateTime()} 
 :)

module namespace entity = 'quodatum.models.generated';
{$imports}

{bf:build-imports($entities)}
{bf:build-namespaces($entities)}
{(  bf:build-describe($entities))} 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){{
  $entity:list($entity)("access")
}}; 
  </text> 

 return $src
};

(:~
 : generate xquery for to return field value in the format: "name":function($_){}
 :)
declare function bf:accessfn(
      $f as element(ent:field)
) as xs:string
{
	let $name:=$f/@name/fn:string()
	let $resulttype:=$f/@type/fn:string()
	let $srctype:=$f/ancestor::ent:entity/ent:data/@type/fn:string()
	return ``[
'`{ $name }`': function($_ as `{ $srctype }`) as `{$resulttype}` { $_! `{ $f/ent:xpath }` }]``
};

declare function bf:generate($e as element(ent:entity)) as xs:string
{
  let $fields:=for $field in $e/ent:fields/ent:field   
                order by $field/@name
                return $field
                
  let $filter:=$e/ent:views/ent:view[@name="filter"]=>fn:tokenize()
  let $filter:= $e/ent:fields/ent:field[@name=$filter]/ent:xpath/fn:concat("$item/",.) 
                   
  return <field>
  "{$e/@name/fn:string()}": map{{
     "name": "{ $e/@name/fn:string()}",
     "description": "{ bf:escape($e/ent:description)}",
     "access": map{{ {$fields!bf:accessfn(.)=>fn:string-join(",")} }},
    
     "filter": function($item,$q) as xs:boolean{{ 
         some $e in ( {fn:string-join($filter,", ")}) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      }},
       "json":   map{{ {$fields!bf:jsonfn(.)=>fn:string-join(",")} }},
       
      "data": function() as {$e/ent:data/@type/fn:string(.)}*
       {{ {let $a:=$e/ent:data/fn:string() return if($a)then $a else "()"} }},
       
       "views": map{{ 
       {$e/ent:views/ent:view!("'" || @name || "': '" ||. || "'")=>fn:string-join(',')}
       }}
   }}</field>
};

(:~
 : @return sequence of element(entity) items for definitions at path
 :)
declare function bf:entities($path as xs:string) 
as element(ent:entity)*
{
 let $p:=fn:resolve-uri($path) || "/"
 return for $f in file:list($p,fn:true(),"*.xml")
        where not(ends-with($f,file:dir-separator()))
        order by $f
        return fn:doc(fn:concat($p,$f))/ent:entity
};

(:map for entity :)
declare function bf:build-map($entity as element(ent:entity)) 
as xs:string
{
let $m:=for $field in $entity/ent:fields/ent:field   
        order by $field/@name
        return bf:accessfn($field)
return <text>
declare variable $entity:{$entity/@name/fn:string()}: map{{ {fn:string-join($m,",")}
}};

</text>        
};

(:~ 
 :  return xml for suitable json serialization for field 
:)
declare function bf:jsonfn($f as element(ent:field)) 
as xs:string
{
    let $name:=$f/@name/fn:string()
    let $type:=$f/@type/fn:string()
    let $opt:=fn:contains($type,"?")
    let $repeat:=fn:contains($type,"*")
    let $json-type:=bf:json-type($type)
    let $srctype:=$f/ancestor::ent:entity/ent:data/@type/fn:string()
    let $mult:=if($repeat) then "*" else "?"
    
    let $at:=if($json-type ne "string") 
            then "attribute type {'" || $json-type || "'},"
            else "" 
    (: generate json xml :)
    let $simple:=function() as xs:string{
                <field>(: {$type} :)
                        fn:data($_!{ $f/ent:xpath })!element { $name } {{ { $at } .}} 
                </field>
                }
    let $array:=function() as xs:string{
                <field>(: array of strings :)
                   element {$name} {{ 
                        attribute type {{"array"}},
                        $_/{$f/ent:xpath }!element _ {{ attribute type {{"string"}}, .}}
                        }} 
                </field>
                }            
    (: serialize when element :)
    let $element:=function() as xs:string{
                <field>element {$name} {{ 
                     attribute type {{"string"}},
                     fn:serialize($_/{$f/ent:xpath})}}</field>
                } 
                    
    return <field>
           "{$name}": function($_ as { $srctype }) as element({ $name }){ $mult } {{
            {if($repeat)then
             $array() 
            else if($type="element()") then 
               $element() 
             else $simple()} }}</field>
};


(:~ convert xs type to json
:)
declare function bf:json-type($xsd as xs:string) as xs:string{
switch ($xsd)
   case "element()" return "string" 
   case "xs:boolean" return "boolean"
   case "xs:integer" return "number"
   case "xs:float" return "number"
   case "xs:double" return "number"
   case "xs:string*" return "array"
   default return "string" 
};

(:~ declare any namespaces found :)
declare function bf:build-namespaces($entities as element()*)
{
  for $n in bf:distinct-deep($entities/ent:namespace)
  return 
<text>declare namespace {$n/@prefix/fn:string()}='{$n/@uri/fn:string()}';
</text>
};

(:~ import any modules found must be in repo :)
declare function bf:build-imports($entities as element()*)
{
  for $n in bf:distinct-deep($entities/ent:module)
  return 
<text>import module namespace {$n/@prefix/fn:string()}='{$n/@namespace/fn:string()}';
</text>
};

declare function bf:build-describe($entities)
as xs:string
{
  let $m:=for $e in  $entities
          return bf:generate($e)
  return <text>          
declare variable $entity:list:=map {{ {fn:string-join($m,",")}
}};

</text>        
};

declare function bf:escape($str as xs:string) 
as xs:string
{
   fn:replace(
     fn:replace($str,'"','""'),
     "'","''")
};

(:-----from functx-------------------:)

 declare function bf:distinct-deep 
  ( $nodes as node()* )  as node()* {
       
    for $seq in (1 to fn:count($nodes))
    return $nodes[$seq][fn:not(bf:is-node-in-sequence-deep-equal(
                          .,$nodes[fn:position() < $seq]))]
};

declare function bf:is-node-in-sequence-deep-equal 
  ( $node as node()? ,
    $seq as node()* )  as xs:boolean {
       
   some $nodeInSeq in $seq satisfies fn:deep-equal($nodeInSeq,$node)
 } ; 