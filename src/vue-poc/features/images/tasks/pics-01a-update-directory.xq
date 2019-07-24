(:~ 
: enrich file list for images
:)
import module namespace cfg = "quodatum:media.image.configure" at "../config.xqm";

declare namespace c="http://www.w3.org/ns/xproc-step";

declare %updating function local:put($data,$path)
{
  if(db:exists($cfg:DB-IMAGE)) then
   db:replace($cfg:DB-IMAGE,$path,$data)
  else
    db:create($cfg:DB-IMAGE,$data,$path)
};

declare function local:type($path as xs:string)
as xs:string
{
   try{
     fetch:content-type($path)
   }catch * {
     "**ERR"
   }    
};

declare %updating function local:meta($doc)
{
 insert node (attribute { 'dc-updated' } { current-dateTime() }) into $doc/*
};

declare %updating function local:original($doc)
{
 for $f in  $doc//c:file[ends-with(../@xml:base,"originals/")]
 return insert node (attribute { 'original' } {true() }) into $f
};

declare %updating function local:content-type($doc)
{
 for $f in $doc//c:file
    let $loc:= $f/../@xml:base || $f/@name
    let $mime:="?" (: local:type($loc) :)
    return insert node attribute { 'content-type' } { $mime } into $f
};

let $doc:=db:open($cfg:DB-IMAGE,"/pics.xml")
let $doc:= $doc transform with {   
           local:meta(/)
           ,local:original(/)
           ,local:content-type(/)
  }
return $doc