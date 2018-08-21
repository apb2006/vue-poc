(:~
 : store meta.xml document for all jpgs referenced in doc("/vue-poc/pics.xml")
 : done in batches of 1000
 : @return initial number of missing docs  
:)
import module namespace cfg = "quodatum:media.image.configure" at "../../../config.xqm";
import module namespace imgmeta = "expkg-zone58:image.metadata" ;
declare namespace c="http://www.w3.org/ns/xproc-step";

declare variable $dir-uri:=``[`{ $cfg:DB-IMAGE }`/pics.xml]``;
declare variable $doc:=doc( $dir-uri);
declare variable $CHUNK:=15000;
declare variable $meta:="/meta/";
let $done:=uri-collection($cfg:DB-IMAGE ||$meta)
let $files:= $doc//c:file[ends-with(lower-case(@name),".jpg")] 

let $relpath:= $files!( ancestor-or-self::*/@name=>string-join("/"))

let $todo:= $relpath[not($done=``[/`{ $cfg:DB-IMAGE }`/meta/`{ . }`/meta.xml]``)]
return (for $f in subsequence($todo,1, $CHUNK)
        let $spath:=$cfg:IMAGEDIR || "../" || $f
        let $dbpath:=$meta || $f || "/meta.xml"
        let $meta:=imgmeta:read(trace($spath))
        return  db:replace($cfg:DB-IMAGE,$dbpath,$meta),
        update:output($todo=>count()))