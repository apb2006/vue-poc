(:~
 : compile vue files to js
 :)
module namespace vue = 'quodatum:vue.compile';

import module namespace html5="text.html5" at "html5parse.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";


declare namespace functx = "http://www.functx.com";

declare variable $vue:FEATURES:="features/";
declare variable $vue:COMPONENTS:="components/";

declare variable $vue:FILTERS:="components/filters.js";
declare variable $vue:DEST:="static/app-gen.js";

(:~ 
 : generate javascript vue call from vue files in source folder and core.js
 : @param $doc is a ch.digitalfondue.jfiveparse.Document
 : @param $url for vue file
 :)
declare function vue:feature($doc,$url as xs:string,$isComp as xs:boolean)
as xs:string
{
let $p:=vue:parse($doc)
let $script:= $p?script=>substring-after("{")

return if(empty($p?id)) then 
           () 
       else 
        if($isComp) then
           ``[
// src: `{ $url }`
Vue.component('`{ $p?id }`',{template:` `{ $p?template }` `,
      `{$script}`
      );
      ]``
       else
         ``[
// src: `{ $url }`
const `{ vue:capitalize-first($p?id) }`=Vue.extend({template:` `{ $p?template }` `,
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
  let $template:= html5:getInnerHTML($tempNode)
  let $id  := html5:getAttribute($tempNode,"id")=>trace("ID")

  let $script:= html5:getElementFirstByTagName($doc,"script")
  let $script:= html5:getInnerHTML($script)
  return map{"id":$id,"template":$template,"script":$script}
};

declare function vue:capitalize-first
  ( $arg as xs:string? )  as xs:string? 
{
   concat(upper-case(substring($arg,1,1)), substring($arg,2))
};

(: filename of features:)
declare function vue:feature-files($proj)
as xs:string*
{
 let $FEATURES:="features/"=>file:resolve-path($proj)
 let $files:=  fw:directory-list($FEATURES,map{"include-filter":".*\.vue"})
             //c:file/@name/resolve-uri(.,base-uri(.))
 return $files
};

declare function vue:feature-build($url as xs:string,$isComp as xs:boolean)
as xs:string
{
 fetch:text($url)=>html5:doc()=>vue:feature($url ,$isComp)
};

(:~
 : compile vue code to "static/app-gen.js"
 : @param $proj root folder e.g "C:/Users/andy/git/vue-poc/src/vue-poc/"
 :)
declare function vue:compile($proj as xs:string)
{
let $FEATURES:= file:resolve-path("features/",$proj=>trace("proj:"))
let $COMPONENTS:= file:resolve-path("components/",$proj)
let $js:=vue:filelist(file:resolve-path("components/",$proj),".*\.js")
let $CORE:="core.js"=>file:resolve-path($proj)
let $ROUTER:="router.js"=>file:resolve-path($proj)
let $APP:="app.vue"=>file:resolve-path($proj)
let $imports:="imports.js"=>file:resolve-path($proj)
let $DEST:="static/app-gen.js"=>file:resolve-path($proj)

let $files:=vue:feature-files($proj)
let $feats:=$files!vue:feature-build(.,false())

let $files:= fw:directory-list($COMPONENTS,map{"include-filter":".*\.vue"})
             //c:file/@name/resolve-uri(.,base-uri(.))
let $comps:=$files!vue:feature-build(.,true())

let $comment:="// generated " || current-dateTime() || "&#xA;&#xD;" 
return file:write-text($DEST,string-join(($comment,
                                         vue:js-text($imports), 
                                         $comps,
                                         $js!vue:js-text(.),
                                         $feats,
                                         vue:js-text($ROUTER),
                                         $APP!vue:feature-build(.,false()),
                                         vue:js-text($CORE))))
};

(:~
 : return sequence of file paths starting from $path matching $filter
 :)
 declare function vue:filelist($path as xs:string,$filter as xs:string)
 as xs:string*
 {
      fw:directory-list($path,map{"include-filter": $filter})
             //c:file/@name/resolve-uri(.,base-uri(.))
 };
(:~
 : javascript source with comment
 :)
declare function vue:js-text($url as xs:string)
{
 ``[
// src: `{ $url }`
`{ fetch:text($url) }`
]``
};