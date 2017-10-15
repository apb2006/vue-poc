(:~ 
: XSLT transform handler
: @author andy bunce
: @since oct 2017
:)

module namespace tx = 'quodatum:vue.api.transform';
import module namespace qv = 'quodatum.validate' at "validate.xqm";

declare namespace cnt="http://cambridge.org/core/content";
(:~ location of schema to use :)
declare variable $tx:nvdl:=resolve-uri("../static/consignment/nvdl/consignment.nvdl",static-base-uri());

(:~ location of schema to use :)
declare variable $tx:schematron:=resolve-uri("../static/consignment/nvdl/core-consignment.sch",static-base-uri());

declare variable $tx:validators:=(qv:schematron(?,$tx:schematron)
                                  ,qv:nvdl(?,$tx:nvdl)
                                  );
                                  
(:~ run validation doc in db :)
declare 
%rest:GET %rest:path("/vue-poc/api/validate")
%rest:query-param("doc", "{$doc}") 
%rest:query-param("schema", "{$schema}") 
%rest:produces("text/xml")
%output:method("xml") 
function tx:validate-path($doc,$schema){
    tx:validate(doc($doc))
};

(:~ run validations add custom details - content-type:)
declare function tx:validate($doc){
  let $type:=$doc//cnt:*=>head()=>local-name()=>substring-after("content-")
  return qv:validation($doc,$tx:validators,attribute type {$type})
};
