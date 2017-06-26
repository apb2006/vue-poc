(:~
 : vue-poc thumbnail api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api.eval';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace util = 'vue-poc/util' at "../../lib/util.xqm";


(:~
 : eval
 :)
declare
%rest:POST %rest:path("/vue-poc/api/eval/execute")
%rest:form-param("xq", "{$xq}")
%output:method("json")   
function vue-api:eval($xq )   
{
 let $x:=fn:trace($xq,"task: ")
 let $r:=util:query($xq,())
 return <json   type="object" >
            <result>{$r}</result>
  </json>
};

(:~
 : submit a simple job
 :)
declare
%rest:POST %rest:path("/vue-poc/api/eval/submit")
%rest:form-param("xq", "{$xq}")
%output:method("json")   
function vue-api:submit($xq )   
{
 let $x:=fn:trace($xq,"submit: ")
 let $bindings:=map{}
 let $opts:=map{"cache":true()}
 let $r:=jobs:eval($xq,$bindings,$opts)
 return <json   type="object" >
            <job>{$r}</job>
  </json>
};
