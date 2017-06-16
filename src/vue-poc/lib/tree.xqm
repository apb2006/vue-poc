xquery version "3.1";
module namespace tree = 'quodatum.data.tree';


(:~
 : convert path(s) to tree
 :)
declare function tree:build($a as xs:string*)
{
fn:fold-right($a,
             (),
             function($a,$b){tree:merge(tree:tree($a),$b)}
            )
};
 
declare function tree:w($this,$seen)
as element(*)
{
  <directory name="{$this}">{$seen}</directory>
};

declare function tree:tree($path as xs:string)
as element(*)
{
  let $parts:=fn:tokenize($path,"/")
  return fn:fold-right(subsequence($parts,1,count($parts)-1),
    <file name="{$parts[last()]}"/>,
    tree:w#2 
   )
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
      return tree:w($a1/@name,for $x in $t order by $x/@name return $x)
 else 
     ($a1,$a2)                        
};




declare %unit:test
(:~
 : smoke test
 :)
function tree:test(){
    let $a:=("/",
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
    "/api/execute/zz")
    let $t:=tree:build($a)
    return unit:assert(fn:true())
};
