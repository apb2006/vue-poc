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
 {for $j in reverse($jlist)
 return <_ type="object">
   {j:job-json($j)}
 </_>
 }</json>
};

(:~
 :  job info
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/job/{$job}")
%output:method("json")   
function j:job($job)
as element(json)
{
 let $j:=jobs:list-details($job)
 return <json type="object">
         {if($j) then j:job-json($j) else ()}
        </json>
};

declare function j:job-json($j as element(job)) 
as element(*)*
{
     <id>{$j/@id/string()}</id>
     ,<type>{$j/@type/string()}</type>
     ,<state>{$j/@state/string()}</state>
     ,<user>{$j/@user/string()}</user>
      ,<registered>{$j/@time/string()}</registered>
      ,<start>{$j/@start/string()}</start>
     ,<duration>{$j/@duration/string()}</duration>
     ,<text>{$j/string()}</text>
      ,<reads>{$j/@reads/string()}</reads>
       ,<writes>{$j/@writes/string()}</writes>
};