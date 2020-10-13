xquery version "3.1";

module namespace mt = 'urn:quodatum:data:mimetype';
declare namespace MediaType='java:org.basex.util.http.MediaType';
declare %basex:lazy variable $mt:lines:="media-types.properties"=>fn:unparsed-text-lines();

(:~ 
 : fetch function for given data type "text","xml","binary"
: @return function()
:)
declare function mt:fetch-fn($treat as xs:string)
as function(*)
{
     switch  ($treat) 
     case "text"
          return fetch:text(?)
     case "xml" 
          return fetch:text(?)
     default 
          return fetch:binary(?)
};

(:~ get mediatype and dataformat as map
 : @return e.g. {type:"application/xml","treat-as":"xml"}
 :)
declare function mt:type($filepath as xs:string)
as map(*)
{
let $f:="a." || mt:base-ext($filepath)
let $a:=MediaType:get($f)
let $type:= if($a="application/sparql-query") then 
                 "text"
            else if(MediaType:isXML($a)) then 
                 "xml"
            else if(MediaType:isText($a) or MediaType:isXQuery($a))then
                "text"
            else
               "binary"
 return map{"type": MediaType:type($a) ,
            "treat-as": $type}
};


(:~ treat as extension
:)
declare function mt:base-ext($filepath as xs:string)
{
  let $ext:=file:name($filepath)=>substring-after(".")
  let $types:=map{"vue":".html","sch":".xml"}
  return ($types($ext),$ext)=>head()
};

(:~
: map of keys:all mimetypes, values: extensions  as array
:)
declare function mt:types(){
fold-left($mt:lines,
         map{},
         function($acc,$line){
              let $p:=tokenize ($line,"=")
              return map:merge(($acc,map{tail($p):head($p)}),map { 'duplicates': 'combine' })
             })
 }; 