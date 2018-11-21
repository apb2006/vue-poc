xquery version "3.1";
(:~
 : async ..
 : scheduled, queued, running, cached
 :)
module namespace  qipe='http://quodatum.com/ns/pipeline';


(:~ submit a pipeline :)
declare 
%updating
function qipe:submit($item as element(qipe:pipeline))
{
  let $dbid:=qipe:id()
  let $id:=$dbid + 0
  let $pipe:=<qipe:run id="{$id}" state="queued" step="1" 
           base-uri="{base-uri($item)}">{ 
    $item 
   }</qipe:run>
  return (
        db:replace("!ASYNC",``[run/`{ $id }`.xml]``,$pipe),
        replace value of node $dbid with ($dbid +1)
        )
};

(:~ next id :)
declare 
function qipe:id()
as node(){
   db:open("!ASYNC","/state.xml")/state/id
};

declare 
function qipe:get($id as xs:string)
as element(qipe:run)?
{
   collection("!ASYNC/run")/qipe:run[@id=$id]
};

declare
%updating 
function qipe:run-step($id as xs:string)
 {
   let $run:=qipe:get($id)
   let $step:= if($run/@state="queued") then 
                    $run/@step/number()
               else error()
   let $base-uri:= $run/@base-uri/string()

   let $task:= $run/qipe:pipeline/*[position()=$step]
   let $xq:=resolve-uri($task/@href,$base-uri)
   let $opts:=map{
                "id": ``[pipe.`{ $run/@id }`.`{ $step }`]``,
                "cache": true()
                }
   let $bindings:=map:merge( $task/qipe:with-param!map:entry(@name,string()) )
   let $job:= jobs:invoke($xq,$bindings,$opts)
   return  replace value of node $run/@state with "running"
};

(:~ names of pipeline jobs with results :)
declare 
function qipe:done-jobs()
as xs:string*
{
 jobs:list()[starts-with(.,"pipe.")]!.[jobs:list-details(.)/@state="cached"]
};

declare 
function qipe:queued()
as xs:string*
{
  collection("!ASYNC/run")/qipe:run[@state="queued"]/@id/string()
};

(: update run using results of job
:)
declare 
%updating
function qipe:update($jobid){
let $p:=tokenize($jobid,"\.")
let $run:=qipe:get($p[2])
let $step:=$p[3]

return try{
       let $result:=jobs:result($jobid)
       let $step:=$step+1 (: TODO all done :)
       return (replace value of node $run/@step with ($step +1),
               replace value of node $run/@state with "queued")
}catch * {
    (insert node <error code="{ $err:code }">
                  <description>{ $err:description }</description>
                 </error>
     into   $run,
    replace value of node $run/@state with "error")
}
};

declare 
function qipe:list-details()
{
  collection("!ASYNC/run")/qipe:run!<run id="{ @id }" state="{ @state }"/>
}; 

(: periodic task to update :)
declare 
%updating
function qipe:tick()
{
 (qipe:queued()!qipe:run-step(.),
 qipe:done-jobs()!qipe:update(.) )
};
