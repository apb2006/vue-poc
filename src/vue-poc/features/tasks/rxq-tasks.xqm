(:~
 : tasks
 :)
module namespace vue-rest = 'quodatum:vue.tasks';

(:~
 : list tasks
 :)
declare
%rest:GET %rest:path("/vue-poc/api/tasks")
%rest:produces("application/json")
%output:method("json")
function vue-rest:tasks()   
{
  let $tasks:=doc("taskdef.xml")/tasks/task
  return <json type="array">{
  $tasks!<_ type="object">
          <to>{ @name/string() }</to>
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
  let $tasks:=doc("taskdef.xml")/tasks/task[@name=$task]
  return  <json type="object">
          <to>{ $tasks/@name/string() }</to>
          <text>{ $tasks/title/string() }</text>
          <params>{ count($tasks/params/*) }</params>
        </json>
};
  
(:~
 :   task run
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/{$task}")
%rest:produces("application/json")
%output:method("json")
function vue-rest:runtask($task)   
{
  let $tasks:=doc("taskdef.xml")/tasks/task
  return <json type="array">{
  $tasks!<_ type="object">
          <to>{ @name/string() }</to>
          <text>{ title/text() }</text>
        </_>
        }</json>
};
    