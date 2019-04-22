(:~ 
 :  plantuml library
 : @see  http://plantuml.com/code-javascript-synchronous
 : @author Andy Bunce
 : @version 0.1
 : @date apr 2019  
:)
module namespace  plant='http://quodatum.com/ns/plantuml';
import module namespace bin="http://expath.org/ns/binary";

declare function plant:encode6bit($b as xs:integer) {
  switch(true())
  case ($b lt  10) return fn:codepoints-to-string (48 + $b)
  case ($b lt 36) return fn:codepoints-to-string (65 + $b -10)
  case ($b lt 62) return fn:codepoints-to-string (97 + $b -36)
  case ($b eq 62) return "-"
  case ($b eq 63) return "_"
  default return "?"
};

declare function plant:append3bytes($b1 as xs:base64Binary , 
                                    $b2  as xs:base64Binary ,
                                    $b3 as xs:base64Binary )
  {
  let $c1 := $b1=>bin:shift(-2)
  let $c2:= $b1=>bin:and(bin:hex("3"))=>bin:shift(4)=>bin:or(bin:shift($b2,-4))
  let $c3 := $b2=>bin:and(bin:hex("F"))=>bin:shift(2)=>bin:or(bin:shift($b3,-6))
  let $mask:=function($b){bin:and($b,bin:hex("3F"))=>bin:unpack-integer(0,1)}
  let $c4 := $b3 =>bin:and(bin:hex("3F"))
  return concat( 
  plant:encode6bit($mask($c1)),
  plant:encode6bit($mask($c2)),
  plant:encode6bit($mask($c3)),
  plant:encode6bit($mask($c4))
  )
};

declare function plant:encode64($data as xs:string)
{
  let $b:=bin:encode-string($data,"UTF-8")
  let $b:=bin:pad-right($b,bin:length($b) mod 3)
  return $b
};