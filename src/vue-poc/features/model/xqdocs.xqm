module namespace j = 'quodatum.test.xqdoc';


(:~
 :  job list
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/xqdocjob")
%output:method("json")   
function j:list()
as element(json)
{
 let $jlist:=(279,280)
 return <json type="array">
 {for $j in $jlist
 return <_ type="object">
  <id>{ $j }</id>
  <name>todo</name>
 </_>
 }</json>
};

(:~
 :  job info
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

