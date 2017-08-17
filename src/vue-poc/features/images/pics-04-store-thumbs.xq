(:~
 : generate thumbs
 : @return initial number of missing docs  
:)
import module namespace t="expkg-zone58:image.thumbnailator";
import module namespace cfg = "quodatum:media.image.configure" at "config.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare variable $DB:="vue-poc";


declare %updating function local:store-thumb($f as xs:string)
{
  let $src:=$cfg:IMAGEDIR || trace($f)
  let $trg:= $cfg:THUMBDIR || $f
  return fetch:binary($src)=>t:size(80)=>local:write-binary($trg)
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
let $done:=uri-collection("vue-poc/Pictures")
let $files:= doc("/vue-poc/pics.xml")//c:file[ends-with(lower-case(@name),".jpg")] 

let $relpath:= $files!( ancestor-or-self::*/@name=>string-join("/"))
let $relpath:=filter($relpath,function($f){ 
                                not(file:exists($cfg:IMAGEDIR || $f)) and file:exists($cfg:IMAGEDIR || $f) 
                              })
let $todo:= $relpath=>subsequence(1, 400)

return (
        $todo!local:store-thumb(.),
        db:output($relpath=>count())
      )