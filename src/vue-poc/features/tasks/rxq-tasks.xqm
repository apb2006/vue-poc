(:~
 : tasks
 :)
module namespace vue-rest = 'quodatum:vue.tasks';

(:~
 : list tasks
 :)
declare
%rest:GET %rest:path("/vue-poc/api/tasks/list")
%rest:produces("application/json")
%output:method("json")
function vue-rest:tasks()   
{
  let $a:=42
  return <json type="array">
        <_ type="object">
          <to>tasks/model</to>
          <text>model</text>
        </_>
          <_ type="object">
          <to>tasks/xqdoc</to>
          <text>XQdoc</text>
        </_>
          <_ type="object">
          <to>tasks/vuecompile</to>
          <text>vue compile</text>
        </_>
        </json>
};
  
