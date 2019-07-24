(:~
 : generate thumbs
 : @return initial number of missing docs  
:)
import module namespace t="expkg-zone58:image.thumbnailator";
import module namespace cfg = "quodatum:media.image.configure" at "../config.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $CHUNK as xs:integer external := 5;

declare variable $DEST:="/pics.xml";
declare variable $SIZE:=xs:integer(100);

(:~ 
 : true if thumbnail not found
 :)
declare function local:missing($f as xs:string)
as xs:boolean
{
    let $_:=$f
    return not(file:exists($cfg:THUMBDIR || $f)) 
    and file:exists($cfg:IMAGEDIR || "../" || $f)
};

(:~
 : find 1st chunk valid items
 :)
declare function local:chunk($items as item()*,
                             $fn as function(*),
                             $chunksize as xs:integer)
{
 fold-left($items,(),
            function($result,$curr){
              if(count($result) ge $chunksize) then 
                ($result,$curr)
              else if($fn($curr)) then
               ($result,$curr)
              else
                $result
            }
          )      
};

declare %updating function local:store-thumb($f as xs:string)
{
  let $src:=$cfg:IMAGEDIR || "../" || trace($f,"gen thumb: ")
  let $trg:= $cfg:THUMBDIR || $f
  return try{
            fetch:binary($src)=>t:size($SIZE)=>local:write-binary($trg)
         } catch * {
            prof:dump("bad: " || $f),
            local:write-binary(convert:string-to-hex('bad'),$trg)
        }
};

(:~  create folder if missing) :)
declare %updating function local:write-binary($data,$url as xs:string)
{  
   let $p:=file:parent($url)
   return  (if(file:is-dir($p)) then 
               () 
           else 
               file:create-dir($p),
           file:write-binary($url,$data)
         )
};

let $files:= doc($cfg:DB-IMAGE || $DEST)//c:file[ends-with(lower-case(@name),".jpg")] 

let $relpath:= $files!( ancestor-or-self::*/@name=>string-join("/"))
let $todo:=  local:chunk($relpath,local:missing#1,$CHUNK)
let $msg:=out:format("%d / %d (%f)",count($todo),count($relpath),1 - count($todo) div count($relpath))
return (
        subsequence($todo,1,$CHUNK)!local:store-thumb(.),
        update:output($msg)
      )