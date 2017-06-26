module namespace j = 'quodatum.test.jobs';


(:~
 :  job list
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/job")
%output:method("json")   
function j:list()
as element(json)
{
 let $jlist:=jobs:list()[. != jobs:current()] !jobs:list-details(.)
 return <json type="array">
 {for $j in $jlist
 return <_ type="object">
 <id>{$j/@id/string()}</id>
 <type>{$j/@type/string()}</type>
 <state>{$j/@state/string()}</state>
 <user>{$j/@user/string()}</user>
 <duration>{$j/@duration/string()}</duration>
 </_>
 }</json>
};

