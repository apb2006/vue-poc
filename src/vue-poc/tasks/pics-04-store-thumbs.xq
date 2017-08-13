(:~
 : generate thumbs
 : @return initial number of missing docs  
:)
import module namespace t="expkg-zone58:image.thumbnailator";

declare namespace c="http://www.w3.org/ns/xproc-step";
declare variable $DB:="vue-poc";
declare variable $IMAGEDIR:="P:/pictures/";
declare variable $THUMBDIR:="C:/tmp/";

(:
declare variable $IMAGEDIR:="/mnt/sda1/pictures/";
declare variable $THUMBDIR:="/mnt/sda1/pictures/thumbs/";
:)

declare %updating function local:store-thumb($f as xs:string)
{
  let $src:=$IMAGEDIR || trace($f)
  let $trg:= $THUMBDIR || $f
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
                                not(file:exists($THUMBDIR || $f)) and file:exists($IMAGEDIR || $f) 
                              })
let $todo:= $relpath=>subsequence(1, 400)

return (
        $todo!local:store-thumb(.),
        db:output($relpath=>count())
      )