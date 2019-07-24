(:~
 : Generate html for for XQuery sources
 : @return info about the run (json format)
 :)

import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
import module namespace xqhtml = 'quodatum:build.xqdoc-html' at "../../../lib/xqdoc/xqdoc-html.xqm";
import module namespace store = 'quodatum.store' at "../../../lib/store.xqm";



(:~ URL of the root folder to document
 : @default C:/Users/andy/git/vue-poc/src/vue-poc
 :)
declare variable $efolder as xs:anyURI  external := xs:anyURI("C:/Users/andy/git/vue-poc/src/vue-poc");

declare variable $id as element(last-id):=db:open("vue-poc","/state.xml")/state/last-id;
let $path:="static/xqdoc/" || "33" || "/"
let $root:=db:option("webpath")=>file:path-to-uri()
let $target:=resolve-uri($path,$root)


let $state:=xqd:read($efolder)=>trace("READ: ")
let $opts:=map{
               "src-folder": $efolder, 
               "project": $state?project, 
               "ext-id": $id/string(),
               "resources": "resources/"
               }

(: generate o/ps per source file  :)
let $modmap:=for $file at $pos in $state?files
               let $params:=map:merge((map{
                              "source":  $file?xqparse/string(),
                              "filename": $file?path,
                              "cache": $xqd:cache,
                              "show-private": true(),
                              "root": "../../",
                              "resources": "resources/"},
                              $opts))
               return (
                 map{
                   "document": $file?xqdoc,
                    "uri":  $file?href || "/xqdoc.xml", "opts":  $xqd:XML
                 },
                  map{
                   "document": $file?xqparse,
                    "uri":  $file?href || "xqparse.xml", "opts":  $xqd:XML
                 },
                  map{
                   "document": xqd:xqdoc-html($file?xqdoc,$params),
                   "uri":  $file?href || "index.html", "opts":  $xqd:HTML5
                 }
               )
               
 let $index:= map{ 
                   "document": xqhtml:index-html2($state,$opts),
                   "uri": ``[index.html]``, "opts":  $xqd:HTML5
                 }
                 
 let $restxq:= map{
                   "document": xqhtml:restxq($state, xqd:rxq-paths($state),$opts),
                     "uri": ``[restxq.html]``, "opts":  $xqd:HTML5
                 }
let $imports:=map{
                   "document": xqhtml:imports($state,xqd:imports($state),$opts),
                     "uri": ``[imports.html]``, "opts":  $xqd:HTML5
                 }
return (
       store:store(($index,$restxq,$imports,$modmap),$target),
       xqd:export-resources2($target),
       replace value of node $id with 1+$id,
       update:output(
         <json type="object">
            <extra>XQdoc generated</extra>
            <msg> {$target}, {count($state?files)} files processed.</msg>
            <id>{$id/string()}</id>
        </json>
            )
       )

