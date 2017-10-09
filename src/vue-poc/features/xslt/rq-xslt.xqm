(:~ 
: validation handler
: @author andy bunce
: @since oct 2017
:)

module namespace tx = 'quodatum:vue.api.validate';

(:~
 : validate
 :)
declare 
%rest:POST %rest:path("/vue-poc/api/validate")
%rest:query-param("xml", "{$xml}") 
%rest:query-param("schema", "{$schema}")   
%output:method("json")
%updating   
function tx:validate($xml,$schema) {
   let $xslt:="fixme"
   let $result:=try{
                let $x:=fn:parse-xml($xml)
                let $s:=fn:parse-xml($xslt)
                let $t:=fn:trace($xml,"xml")
                 let $t:=fn:trace($xslt,"xml")
                let $r:=xslt:transform($x,$s)
                return 
                <json objects="json">
                   <rc>0</rc>
                   <result>{fn:serialize($r)}</result>
                </json>
                } 
                catch *{
                 <json objects="json">
                   <rc>1</rc>
                   <info>{$err:description}</info>
                </json>
                }
   return db:output($result)
};