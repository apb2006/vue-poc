(:~
 : compile
 :)
module namespace vue-rest = 'quodatum:vue.rest';
import module namespace vue = 'quodatum:vue.compile' at "../../../lib/vue-compile/vue-compile.xqm";



(:~
 : run compile task.
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/vue-compile")
%rest:form-param("proj", "{$proj}")
%rest:produces("application/json")
%output:method("json")
%updating   
function vue-rest:vue($proj )   
{
  let $op:=vue:compile($proj)
  return update:output(<json type="object"><msg> { $proj }.</msg></json>)
};
