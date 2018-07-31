(:~
 : tasks
 :)
module namespace vue-rest = 'quodatum:vue.tasks';
import module namespace query-a = 'vue-poc/query-a' at "../../lib/query-a.xqm";

(:~
 : list tasks
 :)
declare
%rest:GET %rest:path("/vue-poc/api/tasks")
%rest:produces("application/json")
%output:method("json")
function vue-rest:tasks()   
{
  let $tasks:=doc("taskdef.xml")/tasks/task[@url]
  
  return <json type="array">{
  $tasks!<_ type="object">
          <to>{ @name/string() }</to>
          <url>{ @url/string() }</url>
          <title>{ title/text() }</title>
          <description>{ fn:serialize(description/node()) }</description>
        </_>
        }</json>
};
  
(:~
 :   task details
 :)
declare
%rest:GET %rest:path("/vue-poc/api/tasks/{$task}")
%rest:produces("application/json")
%output:method("json")
function vue-rest:task($task)   
{
  let $task:=doc("taskdef.xml")/tasks/task[@name=$task]
  let $url:=resolve-uri($task/@url)
  let $info:=query-a:fields($url)
  return  $info
};
  
(:~
 :   task run
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/{$task}")
%rest:produces("application/json")
%updating
%output:method("json")
function vue-rest:runtask($task)   
{
  let $task:=doc("taskdef.xml")/tasks/task[@name=$task]
  let $url:=resolve-uri($task/@url)
  
  return query-a:run($url,query-a:params())
};
    