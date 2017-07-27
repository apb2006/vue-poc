(:~
 : Update `generated/models.xqm` from files in `data/models`
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 : $efolder:="file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models"
 : $target:="file:///C:/Users/andy/workspace/app-doc/src/doc/generated/models.xqm"
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $vue-api:HTML5:=map{"method": "html","version":"5.0"};
declare variable $vue-api:mod-xslt external :="html-module.xsl";
(:~
 : Returns a file content.
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/xqdoc")
%rest:form-param("efolder", "{$efolder}")
%rest:form-param("target", "{$target}")
%rest:produces("application/json")
%output:method("json")
%updating   
function vue-api:model($efolder ,$target )   
{(
  let $files:= fw:directory-list($efolder,map{"include-filter":".*\.xqm"})//c:file
  let $op:=vue-api:save-xq($files,$target)
  return db:output(<json type="object"><msg> {$target}, {count($files)} files written.</msg></json>)
)};
  

declare function vue-api:save-xq($files,$target)
  {
  let $params:=map{
                    "project":"BCH",
                    "source":"Not available",
                    "cache":true() }
  return for $f in $files
   let $ip:=$f/@name/resolve-uri(.,base-uri(.))
   let $op:=$f/ancestor-or-self::*/@name=>string-join("/")
   let $xq:=inspect:xqdoc(trace($ip,"iiii"))
   let $dest:=file:resolve-path($op,$target)
   return (
   vue-api:write2($xq,$dest || ".xml",map{}),
   vue-api:write2($xq=>xslt:transform($vue-api:mod-xslt,$params),$dest || ".html",$vue-api:HTML5)
   )
  };   
  
 declare function vue-api:write2($data,$url as xs:string,$opts as map(*))
  {  
   let $p:=file:parent($url)
   return (
           if(file:is-dir($p)) then () else file:create-dir($p),
           file:write($url,$data)
           )
  };
     
     
