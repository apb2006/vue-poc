(:~
 : Update `generated/models.xqm` from files in `data/models`
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 :)

declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace bf = 'quodatum.tools.buildfields' at "../lib/entity-gen.xqm";
  
let $efolder:="C:/Users/andy/git/vue-poc/src/vue-poc/models"
let $target:="C:/Users/andy/git/vue-poc/src/vue-poc/models.gen.xqm"
return (bf:write($efolder,$target),db:output("generated " || $target))
          
