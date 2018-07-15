(:~
 : Generate html for for XQuery sources
 :)
import module namespace fw="quodatum:file.walker";
import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";
 
(:~ URL of the root folder to document
 : @default C:/Users/andy/git/vue-poc/src/vue-poc
 :)
declare variable $efolder as xs:anyURI  external :="C:/Users/andy/git/vue-poc/src/vue-poc";

(:~ URL of the schema to use 
 : @default C:/tmp/xqdoc/
 :)
declare variable $target as xs:anyURI external :="C:/tmp/xqdoc/";

declare variable $state as element(state):=db:open("vue-poc","/state.xml")/state;
                                 
let $project:=tokenize($efolder,"[/\\]")[last()]=>trace("xqdoc: ")
let $files:= fw:directory-list($efolder,map{"include-filter":".*\.xqm"})
let $id:=$state/last-id
let $opts:=map{
               "project": $project, 
               "id": $id/string()
               }
let $op:=xqd:save-xq($files,$target,$opts)
let $result:=<json type="object">
                  <msg> {$target}, {count($files//c:file)} files processed.</msg>
                  <id>{$id/string()}</id>
              </json>
return (
       update:output($result),
       replace value of node $id with 1+$state/last-id
       )
