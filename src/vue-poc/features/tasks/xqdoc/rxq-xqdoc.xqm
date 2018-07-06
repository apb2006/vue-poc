(:~
 : Generate html for for XQuery sources
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $vue-api:state as element(state):=db:open("vue-poc","/state.xml")/state;

(:~
 : run xqdoc task.
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/xqdoc")
%rest:form-param("efolder", "{$efolder}")
%rest:form-param("target", "{$target}")
%rest:produces("application/json")
%output:method("json")
%updating   
function vue-api:model($efolder ,$target )   
{
  let $project:=tokenize($efolder,"[/\\]")[last()]=>trace("xqdoc: ")
  let $files:= fw:directory-list($efolder,map{"include-filter":".*\.xqm"})
  let $id:=$vue-api:state/last-id
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
         db:output($result),
         replace value of node $id with 1+$vue-api:state/last-id
         )
};
  
