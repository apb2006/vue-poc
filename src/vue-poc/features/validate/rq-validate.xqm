(:~ 
: schema validation
: @author andy bunce
: @since oct 2017
:)

module namespace tx = 'quodatum:vue.api.validate';
import module namespace qv = 'quodatum.validate' at "../../lib/validate.xqm";
import module namespace query-a = 'vue-poc/query-a' at "../../lib/query-a.xqm";

                                 
(:~ run validation 
 : @return json 
 :)
declare 
%rest:POST %rest:path("/vue-poc/api/validate")
%rest:produces("application/json")
%output:method("json")
%updating
function tx:run( )
{
  let $url:= resolve-uri("tx-validate.xq")
  return query-a:run-json($url,query-a:params($url))
};

(:~ validation settings 
 : @return json 
 :)
declare 
%rest:GET %rest:path("/vue-poc/api/validate")
%rest:produces("application/json")
%output:method("json") 
function tx:parameters( )
{
   let $xq:=resolve-uri("tx-validate.xq")
   return query-a:inspect($xq)
};

