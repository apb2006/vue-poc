(:~
 : Generate html for for XQuery sources
 : @return info about the run (json format)
 :)

import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
import module namespace store = 'quodatum.store' at "../../../lib/store.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace xqdoc="http://www.xqdoc.org/1.0";
(:~ URL of the root folder to document
 : @default C:/Users/andy/git/vue-poc/src/vue-poc
 :)
declare variable $efolder as xs:anyURI  external := xs:anyURI("C:/Users/andy/git/vue-poc/src/vue-poc");

declare variable $id as element(last-id):=db:open("vue-poc","/state.xml")/state/last-id;

let $target:="file:///" || db:option("webpath") || "/static/xqdoc/" || $id || "/"
let $project:=tokenize($efolder,"[/\\]")[last()]

let $opts:=map{
               "src-folder": $efolder, 
               "project": $project, 
               "ext-id": $id/string()
               }
let $state:=xqd:read($efolder)=>trace("READ: ")
let $imports:= xqd:imports($state)?xqdoc=>head()

let $modmap:=for $file at $pos in $state?files
               let $params:=map:merge((map{
                              "source": "** source**",
                              "filename": "**FILE**",
                              "cache": $xqd:cache,
                              "show-private": true(),
                              "root": "../",
                              "resources": "resources/"},
                              $opts))
               return (
                 map{
                   "uri": ``[f`{ $pos}`/xqdoc.xml]``,
                   "document": $file?xqdoc,
                   "opts":  $xqd:XML
                 },
                  map{
                   "uri": ``[f`{ $pos}`/xqparse.xml]``,
                   "document": $file?xqparse,
                   "opts":  $xqd:XML
                 },
                  map{
                   "uri": ``[f`{ $pos}`/index.html]``,
                   "document": xqd:xqdoc-html($file?xqdoc,$params),
                   "opts":  $xqd:HTML5
                 }
               )
 let $indexmap:=              
                  map{
                   "uri": ``[index.html]``,
                   "document": <html><title>todo</title></html>,
                   "opts":  $xqd:HTML5
                 }

return (
       store:store(($indexmap,$modmap),$target),
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

