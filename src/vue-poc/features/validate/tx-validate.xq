(:~ 
: schema validation task
: @author andy bunce
: @since july 2018
:)


import module namespace qv = 'quodatum.validate' at "../../lib/validate.xqm";

(:~ URL of the doc to validate
 : @default C:/Users/andy/git/vue-poc/src/vue-poc/models/entities/adminlog.xml
  :)
declare variable $doc as xs:anyURI  external :="C:/Users/andy/git/vue-poc/src/vue-poc/models/entities/adminlog.xml";

(:~ URL of the schema to use 
 : @default C:/Users/andy/git/vue-poc/src/vue-poc/models/schemas/entity.xsd
 :)
declare variable $schema as xs:anyURI external :="C:/Users/andy/git/vue-poc/src/vue-poc/models/schemas/entity.xsd";
                                 
let $validators:=qv:xsd(?,$schema)
let $report:= qv:validation($doc ,$validators,attribute type {"xsd"})
return qv:json($report,map{})
