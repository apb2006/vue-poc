(:~ 
: create xml file list by scanning $cfg:IMAGEDIR and write to db $cfg:DB-IMAGE
:)
import module namespace cfg = "quodatum:media.image.configure" at "../config.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";


declare %updating function local:put($data,$path)
{
  if(db:exists($cfg:DB-IMAGE)) then
   db:replace($cfg:DB-IMAGE,$path,$data)
  else
    db:create($cfg:DB-IMAGE,$data,$path)
};

let $opt:=map{"include-info":true()}
let $files:=fw:directory-list($cfg:IMAGEDIR,$opt)
let $meta:=<meta created="{ current-dateTime() }">
            <imagedir>{ $cfg:IMAGEDIR }></imagedir>
          </meta>
return ($files=>local:put('/pics.xml'),
        $meta=>local:put('pics-meta.xml')
      )