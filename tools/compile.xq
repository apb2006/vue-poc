(:~
 : create app-gen.js from vue files 
 :)
import module namespace html5="text.html5" at "html5parse.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace Document="java:ch.digitalfondue.jfiveparse.Document";
declare namespace Element="java:ch.digitalfondue.jfiveparse.Element";
declare namespace Node="java:ch.digitalfondue.jfiveparse.Node";

declare namespace functx = "http://www.functx.com";
declare variable $PROJ:="C:/Users/andy/git/vue-poc/src/vue-poc/";
declare variable $FEATURES:="features/"=>file:resolve-path($PROJ);
declare variable $COMPONENTS:="components/"=>file:resolve-path($PROJ);
declare variable $CORE:="components/core.js"=>file:resolve-path($PROJ);
declare variable $FILTERS:="components/filters.js"=>file:resolve-path($PROJ);
declare variable $DEST:="static/app-gen.js"=>file:resolve-path($PROJ);

(:~ 
 : generate javascript vue call from vue files in source folder and core.js
 :)
declare function local:feature($doc,$isComp as xs:boolean)
{
let $p:=local:vue-parse($doc)
let $script:= $p?script=>substring-after("{")

return if(empty($p?id)) then 
           () 
       else if($isComp) then
           ``[Vue.component('`{$p?id}`',{template:` `{$p?template}` `,
      `{$script}`
      );
      ]``
       else
             ``[const `{functx:capitalize-first($p?id)}`=Vue.extend({template:` `{$p?template}` `,
      `{$script}`
      );
      ]``
};

declare function local:vue-parse($doc)
as map(*)
{
  let $tempNode:= html5:getElementFirstByTagName($doc,"template")
  let $template:= Node:getInnerHTML($tempNode)
  let $id  := Element:getAttribute($tempNode,"id")=>trace("ID")

  let $script:= html5:getElementFirstByTagName($doc,"script")
  let $script:= Node:getInnerHTML($script)
  return map{"id":$id,"template":$template,"script":$script}
};

declare function functx:capitalize-first
  ( $arg as xs:string? )  as xs:string? 
{
   concat(upper-case(substring($arg,1,1)), substring($arg,2))
};

let $files:= fw:directory-list($FEATURES,map{"include-filter":".*\.vue"})
             //c:file/@name/resolve-uri(.,base-uri(.))
let $feats:=$files!(fetch:text(.)=>html5:doc()=>local:feature(false()))

let $files:= fw:directory-list($COMPONENTS,map{"include-filter":".*\.vue"})
             //c:file/@name/resolve-uri(.,base-uri(.))
let $comps:=$files!(fetch:text(.)=>html5:doc()=>local:feature(true()))

let $comment:="// generated " || current-dateTime() || "&#xA;&#xD;"
return file:write-text($DEST,string-join(($comment,
                                         $comps,
                                         fetch:text($FILTERS),
                                         $feats,
                                         fetch:text($CORE))))