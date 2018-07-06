(:~ 
: schema validation
: @author andy bunce
: @since oct 2017
:)

module namespace tx = 'quodatum:vue.api.validate';
import module namespace qv = 'quodatum.validate' at "validate.xqm";

                                 
(:~ run validation 
 : @return json 
 :)
declare 
%rest:POST %rest:path("/vue-poc/api/validate")
%rest:form-param("doc", "{$doc}") 
%rest:form-param("schema", "{$schema}") 
%rest:produces("application/json")
%output:method("json") 
function tx:validate-path($doc as xs:anyURI,
                          $schema as xs:anyURI)
{
   (: tx:validate(doc($doc)) :)
   let $_:=trace($doc,"doc ")
   let $_:=trace($schema,"schema: ")
   let $validators:=qv:xsd(?,$schema)
   let $report:= qv:validation($doc ,$validators,attribute type {"xsd"})
   return qv:json($report,map{})
};

