(:~ 
: basex web system info
: @author andy bunce
: @since oct 2012
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
function tx:xslt($xml,$xslt) {

   let $result:=try{
                let $x:=fn:parse-xml($xml)
                let $s:=fn:parse-xml($xslt)
                 let $params:=map{}
                 let $opts:=map{"cache":true()}
                let $r:=xslt:transform-text($x,$s,$params,$opts)
                return 
                <json objects="json">
                   <rc>0</rc>
                   <result>{$r}</result>
                </json>
                } 
                catch *{
                 <json objects="json">
                   <rc>1</rc>
                   <info>{$err:description}</info>
                </json>
                }
   return $result
};