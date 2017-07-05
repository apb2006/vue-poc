(:~
 : vue-poc api.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-api = 'quodatum:vue.api';
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace session = "http://basex.org/modules/session";


declare namespace c="http://www.w3.org/ns/xproc-step";

declare namespace wadl="http://wadl.dev.java.net/2009/02";



(:~
 : Returns a query result.
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
            {(1 to 100)!(<_>A{.}</_>)}              
            </items>
  </json>
};

(:~
 : get status
 :)
declare
%rest:GET %rest:path("/vue-poc/api/status")
%rest:produces("application/json")
%output:method("json")   
function vue-api:status( )   
{
let $user:=user:current()
let $detail:=user:list-details($user)
return  <json   type="object" >
            <user>{$user}</user>
            <permission>{$detail/@permission/string()}</permission>
            <session>{session:id()}</session>
            <created>{session:created()}</created>
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

