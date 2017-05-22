(:~
 : create app.js from vue files 
 :)
import module namespace html5="text.html5" at "html5parse.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace Document="java:ch.digitalfondue.jfiveparse.Document";
declare namespace Element="java:ch.digitalfondue.jfiveparse.Element";
declare namespace Node="java:ch.digitalfondue.jfiveparse.Node";
declare namespace list="java:java.util.ArrayList";
declare namespace functx = "http://www.functx.com";
declare variable $SRC:="C:/Users/andy/git/vue-poc/src/vue-poc/templates/";
declare variable $CORE:="C:/Users/andy/git/vue-poc/src/vue-poc/static/core.js";
declare variable $DEST:="C:/Users/andy/git/vue-poc/src/vue-poc/static/app-gen.js";

(:~ 
 : generate javascript vue call from vue file
 :)
declare function local:process($doc)
{
let $tempNode:= Document:getElementsByTagName($doc,"template")=>list:get(xs:int(0))
let $template:= Node:getInnerHTML($tempNode)
let $id  := Element:getAttribute($tempNode,"id")
let $name:=functx:capitalize-first($id)=>trace("ID")

let $script:= Document:getElementsByTagName($doc,"script")=>list:get(xs:int(0))
let $tempfix:=replace($template,"\$","\\\$")
let $s:= Node:getInnerHTML($script)=>replace('[''"]#' || $id || '[''"]','`' ||$tempfix ||'`')

let $js:= ``[const `{$name}`=Vue.extend(`{$s}`
);
]``
return if(empty($id)) then () else $js
};

declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? 
{
   concat(upper-case(substring($arg,1,1)), substring($arg,2))
};
let $files:= fw:directory-list($SRC,map{"include-filter":".*\.vue"})
//c:file/@name/resolve-uri(.,base-uri(.))
let $docs:=$files!(fetch:text(.)=>html5:doc()=>local:process())
return file:write-text($DEST,string-join(($docs,fetch:text($CORE))))