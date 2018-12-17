xquery version "3.1";
(:~
 : vue-poc api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace session = "http://basex.org/modules/session";
import module namespace entity = 'quodatum.models.generated' at "models.gen.xqm";



declare namespace c="http://www.w3.org/ns/xproc-step";

declare namespace wadl="http://wadl.dev.java.net/2009/02";

(:~
 : get status
 :)
declare
%rest:GET %rest:path("/vue-poc/api/start")
 function vue-api:start( )   
{
  if(db:exists("vue-poc")) then
   ()
  else 
  ()
};



(:~
 : Returns test list for select.
 :)
declare
%rest:path("/vue-poc/api/test-select")
%rest:query-param("q", "{$q}")
%rest:produces("application/json")
%output:method("json")   
function vue-api:test-select($q )   
{
  <json   type="object" >
            <items type="array">
            {(1 to 100)!(<_ type="object">
             <name>A{ . }</name>
             <value>V{ . }</value>
            </_>)}              
            </items>
  </json>
};

(:~
 : Returns wadl.
 :)
declare
%rest:path("/vue-poc/api")
function vue-api:wadl()   
{
 rest:wadl()
};

(:~
 :  user list
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/user")
%output:method("json")   
function vue-api:user()
as element(json)
{
 let $jlist:=user:list
 return <json type="array">
 {for $j in $jlist
 return <_ type="object">
  <name>{$j}</name>
 </_>
 }</json>
};

(:~
 :  repo list
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/repo")
%output:method("json")   
function vue-api:repo()
as element(json)
{
 let $jlist:=repo:list()
 return <json type="array">
 {for $j in $jlist
 return <_ type="object">
  <name>{$j}</name>
 </_>
 }</json>
};

declare
  %rest:POST
  %rest:path("/vue-poc/api/upload")
  %rest:form-param("files", "{$files}")
function vue-api:upload($files) {
  for $name    in map:keys($files)
  let $content := $files($name)
  let $path    := file:temp-dir() || $name
  return (
    file:write-binary($path, $content),
    <file name="{ $name }" size="{ file:size($path) }"/>
  )
};