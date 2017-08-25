(:~
 : Update `generated/models.xqm` from files in `data/models`
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 :)

declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace bf = 'quodatum.tools.buildfields' at "../lib/entity-gen.xqm";
  
declare variable $efolder:="C:/Users/andy/git/vue-poc/src/vue-poc/models";
declare variable $target:="C:/Users/andy/git/vue-poc/src/vue-poc/models.gen.xqm";

let $config:='import module namespace cfg = "quodatum:media.image.configure" at "features/images/config.xqm";'

let $src:=bf:module(bf:entities($efolder),$config)
return (
  file:write-text($target,$src)
 ,db:output("generated " || $target)
)
          
