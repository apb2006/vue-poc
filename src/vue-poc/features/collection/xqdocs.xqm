xquery version "3.1";
(:~
 : job info
 :)
 module namespace j = 'quodatum.test.xqdoc';


(:~
 :  job list (currently dummy list)
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/xqdocjob")
%output:method("json")   
function j:list()
as element(json)
{
 let $xqdoc-folder:=db:option("webpath") || "/static/xqdoc/"
 return <json type="array">
 {for $di in file:list($xqdoc-folder)
 let $meta:= $xqdoc-folder || $di || "xqdoca.xml"
 where fn:doc-available($meta)
let $doc:=doc($meta)/xqdoca
 return <_ type="object">
  <id>{ $di}</id>
  <created>{ $doc/@created/string() }</created>
  <name>{ $doc/project/string() }</name>
  <href>/static/xqdoc/{ $di }index.html</href>
 </_>
 }</json>
};

(:~
 :  job info (currently dummy item)
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/xqdocjob/{$job}")
%output:method("json")   
function j:job($job)
as element(json)
{
 let $j:=$job
 return <json type="object">
        <todo>uuu</todo>
        </json>
};

