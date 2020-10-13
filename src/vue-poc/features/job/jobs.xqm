module namespace j = 'quodatum.test.jobs';
import module namespace entity ='quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm"; 
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";

(:~
 :  job list
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/job")
%rest:produces("application/json")
%output:method("json")   
function j:list()
as element(json)
{
 let $entity:=$entity:list("basex.job")
 let $items:=$entity?data()
 return dice:response($items,$entity,web:dice())
};



(:~
 :  job info
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/job/{$job}")
%rest:produces("application/json")
%output:method("json")   
function j:job($job)
as element(json)
{
 let $this:=$entity:list("basex.job")
 let $items:=$this?data()
 let $fields:=$this?json
 let $item:=$items[@id=$job]
 (: just one :)
 return <json objects="json">{dice:json-flds($item,$fields)/*}</json>
};

