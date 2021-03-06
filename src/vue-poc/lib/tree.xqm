xquery version "3.1";
(:~ 
 : convert sequence of paths to sequence of xml trees 
 :)
module namespace tree = 'quodatum.data.tree';


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
 
(:~  convert a path to xml :)
declare function tree:nest($path as xs:string)
as element(*)
{
  let $path:=if(starts-with($path,"/")) then $path else "/" || $path
  let $parts:=fn:tokenize(($path),"/")
  return fn:fold-right(subsequence($parts,1,count($parts)-1),
    <file name="{$parts[last()]}" target="{$path}"/>,
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

