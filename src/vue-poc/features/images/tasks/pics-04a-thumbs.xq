(:~
 : generate thumbs
 : @return initial number of missing docs  
:)
import module namespace t="expkg-zone58:image.thumbnailator";
import module namespace cfg = "quodatum:media.image.configure" at "../config.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $CHUNK:= 2;

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
                else if(local:missing($curr)) then
                 ($result,$curr)
                else
                  $result
              }
            )      
};

let $files:= doc($cfg:DB-IMAGE || $DEST)//c:file[ends-with(lower-case(@name),".jpg")] 

let $relpath:= $files!( ancestor-or-self::*/@name=>string-join("/"))
(: let $relpath:=filter($relpath,local:missing#1) :)

(: let $relpath:=fold-left($relpath,(),
              function($result,$curr){
                if(count($result) ge $CHUNK) then 
                  $result 
                else if(local:missing($curr)) then
                  ($result,$curr)  
                else
                  $result
              }
            ) :)      

return local:chunk($relpath,local:missing#1,$CHUNK)