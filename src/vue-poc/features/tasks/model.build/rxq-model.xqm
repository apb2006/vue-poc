(:~
 : Update `generated/models.xqm` from files in `data/models`
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 : $efolder:="file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models"
 : $target:="file:///C:/Users/andy/workspace/app-doc/src/doc/generated/models.xqm"
 :)
module namespace vue-api = 'quodatum:vue.api';

import module namespace bf = 'quodatum.tools.buildfields' at "entity-gen.xqm";

(:~
 : Returns a file content.
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/model")
%rest:form-param("efolder", "{$efolder}")
%rest:form-param("target", "{$target}")
%rest:produces("application/json")
%output:method("json")
%updating   
function vue-api:model($efolder ,$target )   
{(
  prof:variables(),
  bf:write($efolder,$target),
  db:output(<json type="object"><msg>Updated: {$target}</msg></json>)
)};
          
