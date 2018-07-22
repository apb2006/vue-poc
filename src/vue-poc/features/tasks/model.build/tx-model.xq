(:~
 : Update `generated/models.xqm` from XML files in `data/models`
 :)

import module namespace bf = 'quodatum.tools.buildfields' at "./../../../lib/entity-gen.xqm";

(:~ 
 : Folder containing model definitions as xml
 : @default C:/Users/andy/git/vue-poc/src/vue-poc/models/entities
 :)
declare variable $efolder as xs:anyURI  external :="C:/Users/andy/git/vue-poc/src/vue-poc/models/entities";

(:~ 
 : Path to xqm file to generate
 : @default C:/Users/andy/git/vue-poc/src/vue-poc/models.gen.xqm
 :)
declare variable $target as xs:anyURI  external :="C:/Users/andy/git/vue-poc/src/vue-poc/models.gen.xqm";


let $config:='import module namespace cfg = "quodatum:media.image.configure" at "config.xqm";'
let $src:=bf:module(bf:entities($efolder),$config)
return (
  prof:variables(),
  file:write-text($target,$src),
  update:output(<json type="object"><msg>Updated: {$target}</msg></json>)
)
       
