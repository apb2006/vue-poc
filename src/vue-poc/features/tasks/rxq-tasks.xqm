(:~
 : tasks
 :)
module namespace vue-rest = 'quodatum:vue.tasks';
import module namespace query-a = 'vue-poc/query-a' at "../../lib/query-a.xqm";
import module namespace hlog = 'quodatum.data.history' at '../../lib/history.xqm';
import module namespace  resolve = 'urn:quodatum:resolve'  at '../../lib/resolve.xqm';

declare namespace hist="urn:quodatum:vue-poc.history";

(:~
 : list tasks
 :)
declare
%rest:GET %rest:path("/vue-poc/api/tasks")
%rest:produces("application/json")
%output:method("json")
function vue-rest:tasks()   
{
  let $tasks:=doc("taskdef.xml")/tasks/task[@url]
  
  return <json type="array">{
  $tasks!<_ type="object">
          <to>{ @name/string() }</to>
          <url>{ @url/string() }</url>
          <title>{ title/text() }</title>
          <description>{ fn:serialize(description/node()) }</description>
        </_>
        }</json>
};
  
(:~
 :   task details
 :)
declare
%rest:GET %rest:path("/vue-poc/api/tasks/{$task}")
%rest:query-param("id", "{ $id }")
%rest:produces("application/json")
%output:method("json")
function vue-rest:task($task,$id)   
{
  let $taskdef:=doc("taskdef.xml")/tasks/task[@name=$task]
  let $url:=resolve-uri($taskdef/@url)
  let $h:=if($id) then hlog:get($id) else ()
  let $info:= query-a:inspect($url) 
  let $info:= if($h) then (: use old values :)
              let $v:=<values type="object">{
                       $h/hist:task/hist:param!element{@name}{string(.)}
                     }</values> =>trace("O/P")
 			  return $info transform with {replace node ./values with $v}
 		 else
 		      $info
 	return $info transform with { insert node <url2>{ resolve:special($url) }</url2> into . }
};
 

(:~
 :   Run the named task and log history 
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/{$task}")
%rest:produces("application/json")
%updating
%output:method("json")
function vue-rest:runtask($task)   
{
  let $taskdef:=doc("taskdef.xml")/tasks/task[@name=$task]
  let $url:=resolve-uri($taskdef/@url)=>trace("RUNTASK")
  let $params:=query-a:params($url)
  let $log:=<task task="{ $task }" url="{ $url }">
               { map:keys($params)!<param name="{.}">{map:get($params,.)}</param> }
            </task>
  return (
    query-a:run($url, $params, map{}),
    hlog:save($log),
    vue-rest:result()
  )
};

(:~ massage update:output 
 update:cache = (results,id) 
 :)
declare 
%updating
function vue-rest:result(){
 let $a:=update:cache(true())
 let $r:=$a[1]
 let $r:=typeswitch($r)
         case element(json) return <result type="{$r/@type}">{$r/*}</result>
         default return <result>{$r}</result>
          
 let $r:=<json type="object">
	            {$r}
	            <id>{$a[2]}</id>
            </json>
    return update:output($r)
};    