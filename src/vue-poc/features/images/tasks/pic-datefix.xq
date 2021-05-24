(: folder date fix
locate files that belong else where based on file name
 :)
declare variable $date-folder:="2021-01-22";
declare variable $base:="P:\pictures\Pictures\2021\";
declare variable $folders:=file:list($base)!(if(ends-with(.,"\"))then substring(.,1,10) else ());
declare variable $reDate:=".*2021-?(\d{2})-?(\d{2}).*";

(:~ 
 return 2021-mm-dd or empty
:)
declare function local:extract($file as xs:string)
as xs:string?{
if(matches($file,$reDate)) 
then replace($file,$reDate,"2021-$1-$2")
else () 
};

(:~ 
  files in $base folder with a date in filename that does not match date-folder name 
:)
declare function local:date-wrong($base as xs:string,$date-folder as xs:string)
as map(*)*
{
 for $f in file:list($base || $date-folder)
 let $target:=local:extract($f)
 where $target and $target ne $date-folder
 let $original:=  ".picasaoriginals\"  || $f
 let $files:=($f,if(file:exists($base || $date-folder || "\" || $original )) then $original else ())
 group by $target
 return map{"key": $target, "files":$files}
};

(:~  move a file, create folder if needed :)
declare function local:move($src as xs:string, $dest as xs:string)
{
  file:create-dir(file:parent($dest)),
  file:move($src,$dest)
};

declare function local:print($src as xs:string, $dest as xs:string)
{
 concat($src,"->", $dest)
};

for $date-folder in $folders
let $actions:= (local:print#2,local:move#2)=>head()
for $target in local:date-wrong($base , $date-folder),
    $f in $target?files
let $src:= $base || $date-folder || "\" || $f
let $dest:= $base || $target?key || "\" || $f
return $actions!.($src,$dest)