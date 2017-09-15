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
  return <json type="object"><msg> hello tasks</msg></json>
};
  
