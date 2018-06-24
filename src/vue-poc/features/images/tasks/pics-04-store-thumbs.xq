(:~
 : generate thumbs
 : @return initial number of missing docs  
:)
import module namespace t="expkg-zone58:image.thumbnailator";
import module namespace cfg = "quodatum:media.image.configure" at "../../../config.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $CHUNK:=1000;

declare %updating function local:store-thumb($f as xs:string)
{
  let $src:=$cfg:IMAGEDIR || "../" || trace($f)
  let $trg:= $cfg:THUMBDIR || $f
  return try{
            fetch:binary($src)=>t:size(80)=>local:write-binary($trg)
         } catch * {
             db:output("bad: " || $f)
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

let $files:= doc($cfg:DB-IMAGE || "/pics.xml")//c:file[ends-with(lower-case(@name),".jpg")] 

let $relpath:= $files!( ancestor-or-self::*/@name=>string-join("/"))
let $relpath:=filter($relpath,function($f){ 
                                not(file:exists($cfg:THUMBDIR || $f)) 
                                and file:exists($cfg:IMAGEDIR || "../" || $f) 
                              })
let $todo:= $relpath=>subsequence(1, $CHUNK)

return (
        $todo!local:store-thumb(.),
        db:output($relpath=>count())
      )