(:~
 : Generate html for for XQuery sources
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";


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
  let $project:=tokenize($efolder,"[/\\]")[last()]=>trace("DDD")
  let $files:= fw:directory-list($efolder,map{"include-filter":".*\.xqm"})
  let $op:=xqd:save-xq($files,$target,map{"project":$project})
  return db:output(<json type="object"><msg> {$target}, {count($files//c:file)} files processed.</msg></json>)
};
  
