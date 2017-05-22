(:~
 : create vue files from app.html
 :)
import module namespace html5="text.html5" at "html5parse.xqm";
declare namespace Document="java:ch.digitalfondue.jfiveparse.Document";
declare namespace Element="java:ch.digitalfondue.jfiveparse.Element";
declare namespace Node="java:ch.digitalfondue.jfiveparse.Node";

declare variable $DEST:="C:/Users/andy/git/vue-poc/src/vue-poc/templates/";
declare variable $SRC:="C:/Users/andy/git/vue-poc/src/vue-poc/static/app.html";


declare function local:process($node)
{
  let $id:= Element:getAttribute($node,"id")
  let $html:=Node:getInnerHTML($node)
  let $name:=$DEST || $id || ".vue"
  let $out:=``[<!DOCTYPE html>
<template id="`{$id}`">`{$html}`</template>
<script>
</script>
]``  
  return file:write-text($name,$out)

};

let $doc:=$SRC=>fetch:text()=>html5:doc()
let $matcher:=html5:selector()
let $nodes:= Document:getAllNodesMatching($doc,$matcher)
return $nodes=>html5:for-each(local:process#1)