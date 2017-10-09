(:~ 
: XSLT transform handler
: @author andy bunce
: @since oct 2017
:)

module namespace tx = 'quodatum:vue.api.transform';

(:~
 : xslt
 :)
declare 
%rest:POST %rest:path("/vue-poc/api/xslt")
%rest:query-param("xml", "{$xml}") 
%rest:query-param("xslt", "{$xslt}")   
%output:method("json")
%updating   
function tx:xslt($xml,$xslt) {

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