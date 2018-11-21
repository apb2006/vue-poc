xquery version "3.1";
(:~ 
 : convert sequence of paths to sequence of xml trees 
 :)
module namespace tree = 'quodatum.data.tree';

declare variable $tree:TEST1:=(
    "/",
    "/api/environment/",
    "/api/execute/",
    "/api/library/",
    "/api/library/",
    "/api/library/{$id}/",
    "/api/library/{$id}/",
    "/api/state/",
    "/api/~testbed/",
    "/api/state/",
    "/api/state/",
    "/api/suite/",
    "/api/suite/{$suite}/",
    "/api/execute/zz"
);

declare variable $tree:TEST2:=(
      "/vue-poc",
"/vue-poc/api",
"/vue-poc/api/collection",
"/vue-poc/api/components/tree",
"/vue-poc/api/data/users",
"/vue-poc/api/data/{$entity}",
"/vue-poc/api/edit",
"/vue-poc/api/eval/execute",
"/vue-poc/api/eval/imports",
"/vue-poc/api/eval/invoke",
"/vue-poc/api/eval/plan",
"/vue-poc/api/eval/result/{$id}",
"/vue-poc/api/eval/submit",
"/vue-poc/api/form/schema",
"/vue-poc/api/get",
"/vue-poc/api/get2",
"/vue-poc/api/history",
"/vue-poc/api/images/datetaken",
"/vue-poc/api/images/keywords2",
"/vue-poc/api/images/list",
"/vue-poc/api/images/list/{ $id }/image",
"/vue-poc/api/images/list/{ $id }/meta",
"/vue-poc/api/images/list/{ $id }/thumb",
"/vue-poc/api/images/list/{$id}",
"/vue-poc/api/images/report",
"/vue-poc/api/job",
"/vue-poc/api/job/{$job}",
"/vue-poc/api/log",
"/vue-poc/api/log/add",
"/vue-poc/api/login-check",
"/vue-poc/api/logout",
"/vue-poc/api/ping",
"/vue-poc/api/repo",
"/vue-poc/api/search",
"/vue-poc/api/start",
"/vue-poc/api/status",
"/vue-poc/api/tasks",
"/vue-poc/api/tasks/model",
"/vue-poc/api/tasks/task",
"/vue-poc/api/tasks/vue-compile",
"/vue-poc/api/tasks/xqdoc",
"/vue-poc/api/tasks/{$task}",
"/vue-poc/api/test-select",
"/vue-poc/api/thumbnail",
"/vue-poc/api/thumbnail/images",
"/vue-poc/api/thumbnail/validate",
"/vue-poc/api/user",
"/vue-poc/api/validate",
"/vue-poc/api/xqdoc",
"/vue-poc/api/xslt",
"/vue-poc/ui",
"/vue-poc/ui/{$file=.+}",
"vue-poc/api/data/entity",
"vue-poc/api/data/entity/{$entity}",
"vue-poc/api/data/entity/{$entity}/field"  
);


(:~
 : convert path(s) to tree
 :)
declare function tree:build($a as xs:string*)
{
fn:fold-right($a,
             (),
             function($this,$acc){ tree:merge($acc,tree:nest($this)) }
            )
};
 
declare function tree:nest($path as xs:string)
as element(*)
{
  let $path:=if(starts-with($path,"/")) then $path else "/" || $path
  let $parts:=fn:tokenize(($path),"/")
  return fn:fold-right(subsequence($parts,1,count($parts)-1),
    <file name="{$parts[last()]}"/>,
    tree:wrap#2 
   )
};

declare function tree:wrap($this as xs:string,$acc)
as element(*)
{
  <directory name="{$this}">{$acc}</directory>
};


declare function tree:merge($a1 as element(*)?,$a2 as element(*)?)
as element(*)*
{
 if($a1/@name=$a2/@name) then
      let $n1:=$a1/*
      let $n2:=$a2/*
         
      let $t:=(
        for $x in fn:distinct-values($n1/@name[.=$n2/@name]) (:both:)
        return tree:merge($a1/*[@name=$x],$a2/*[@name=$x]),
        
        for $x in fn:distinct-values($n1/@name[fn:not(.=$n2/@name)]) (:only $a1 :)
        return $a1/*[@name=$x],
        
        for $x in fn:distinct-values($n2/@name[fn:not(.=$n1/@name)]) (:only $a2 :)
        return $a2/*[@name=$x]
      )
      return tree:wrap($a1/@name,for $x in $t order by $x/@name return $x)
 else 
     ($a1,$a2)                        
};




declare %unit:test
(:~
 : smoke test
 :)
function tree:test(){
    let $t:=tree:build($tree:TEST1) 
    return unit:assert(fn:true(),$t)
};

declare %unit:test
function tree:test2(){

    let $t:=tree:build($tree:TEST1) 
    return unit:assert(fn:false(),$t)
};
