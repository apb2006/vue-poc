(:~ 
: create xml file list by scanning $SRC and write to vue-poc 
:)
import module namespace cfg = "quodatum:media.image.configure" at "../config.xqm";
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";

(: declare variable $DEST:="c:\tmp\pics2.xml"; :)
declare variable $DEST:=format-date(current-date(),"/[Y0001][M01][D01]-pics.xml");

declare %updating function local:put($data,$path){
   db:replace($cfg:DB-IMAGE,$path,$data)
};

let $opt:=map{"include-info":true()}
let $files:=fw:directory-list($cfg:IMAGEDIR,$opt)
return $files=>local:put($DEST)