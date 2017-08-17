(:~
 : compile vue files to js
 :)
module namespace vue = 'quodatum:vue.compile';

import module namespace html5="text.html5" at "html5parse.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace Document="java:ch.digitalfondue.jfiveparse.Document";
declare namespace Element="java:ch.digitalfondue.jfiveparse.Element";
declare namespace Node="java:ch.digitalfondue.jfiveparse.Node";

declare namespace functx = "http://www.functx.com";
declare variable $vue:PROJ:="C:/Users/andy/git/vue-poc/src/vue-poc/";
declare variable $vue:FEATURES:="features/";
declare variable $vue:COMPONENTS:="components/";
declare variable $vue:CORE:="components/core.js";
declare variable $vue:FILTERS:="components/filters.js";
declare variable $vue:DEST:="static/app-gen.js";

(:~ 
 : generate javascript vue call from vue files in source folder and core.js
 : @param $doc url for vue file
 :)
declare function vue:feature($doc,$isComp as xs:boolean)
as xs:string
{
let $p:=vue:parse($doc)
let $script:= $p?script=>substring-after("{")

return if(empty($p?id)) then 
           () 
       else if($isComp) then
           ``[Vue.component('`{ $p?id }`',{template:` `{ $p?template }` `,
      `{$script}`
      );
      ]``
       else
             ``[const `{ vue:capitalize-first($p?id) }`=Vue.extend({template:` `{ $p?template }` `,
      `{ $script }`
      );
      ]``
};

(:~
 : parse a vue file to extract template and script
 : @return  map{"id":$id,"template":$template,"script":$script}
 :)
declare function vue:parse($doc)
as map(*)
{
  let $tempNode:= html5:getElementFirstByTagName($doc,"template")
  let $template:= Node:getInnerHTML($tempNode)
  let $id  := Element:getAttribute($tempNode,"id")=>trace("ID")

  let $script:= html5:getElementFirstByTagName($doc,"script")
  let $script:= Node:getInnerHTML($script)
  return map{"id":$id,"template":$template,"script":$script}
};

declare function vue:capitalize-first
  ( $arg as xs:string? )  as xs:string? 
{
   concat(upper-case(substring($arg,1,1)), substring($arg,2))
};

(:~
 : compile vue code to "static/app-gen.js"
 : @param $proj root folder e.g "C:/Users/andy/git/vue-poc/src/vue-poc/"
 :)
declare function vue:compile($proj as xs:string)
{
let $FEATURES:="features/"=>file:resolve-path($proj=>trace("proj:"))
let $COMPONENTS:="components/"=>file:resolve-path($proj)
let $CORE:="components/core.js"=>file:resolve-path($proj)
let $FILTERS:="components/filters.js"=>file:resolve-path($proj)
let $DEST:="static/app-gen.js"=>file:resolve-path($proj)

let $files:= fw:directory-list($FEATURES,map{"include-filter":".*\.vue"})
             //c:file/@name/resolve-uri(.,base-uri(.))
let $feats:=$files!(fetch:text(.)=>html5:doc()=>vue:feature(false()))

let $files:= fw:directory-list($COMPONENTS,map{"include-filter":".*\.vue"})
             //c:file/@name/resolve-uri(.,base-uri(.))
let $comps:=$files!(fetch:text(.)=>html5:doc()=>vue:feature(true()))

let $comment:="// generated " || current-dateTime() || "&#xA;&#xD;"
return file:write-text($DEST,string-join(($comment,
                                         $comps,
                                         fetch:text($FILTERS),
                                         $feats,
                                         fetch:text($CORE))))
};