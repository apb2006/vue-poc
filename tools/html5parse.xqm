

module namespace html5="text.html5";
declare namespace Document="java:ch.digitalfondue.jfiveparse.Document";
declare namespace Element="java:ch.digitalfondue.jfiveparse.Element";
declare namespace Node="java:ch.digitalfondue.jfiveparse.Node";
declare namespace Parser="java:ch.digitalfondue.jfiveparse.Parser";
declare namespace Selector="java:ch.digitalfondue.jfiveparse.Selector";
declare namespace list="java:java.util.ArrayList";

(:~
 : parse html text string into jfiveparse.Document 
 :)
declare function html5:doc($text as xs:string)
{
  let $p:=Parser:new()
  return Parser:parse($p,$text)
};

(:~ 
 : apply function $fn to each jfiveparse.Node
 :)
declare function html5:for-each($nodes,$fn as function(*))
{
  for $index in 0 to list:size($nodes)-1
  let $a:=list:get($nodes,xs:int($index))
  return $fn($a)
};

(:~ 
 : first element with given name 
 :)
declare function html5:getElementFirstByTagName($doc,$tag as xs:string)
{
 Document:getElementsByTagName($doc,$tag)
 =>list:get(xs:int(0))
};

(:~ 
 : @return matcher for given element and attribute with value
 :)
declare function html5:selector()
{
  Selector:select()
  =>Selector:element("script")
  =>Selector:attrValEq("type", "text/x-template")
  =>Selector:toMatcher()
};

(:~ 
 :write file
 :)
declare function html5:write-text($text as xs:string,$file as xs:string)
{
file:write-text($file,$text)
};