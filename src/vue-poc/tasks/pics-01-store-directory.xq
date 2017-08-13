(:~ 
: create xml file list by scanning $SRC and write to vue-poc 
:)
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare variable $SRC:="P:/pictures/Pictures/";
(: declare variable $DEST:="c:\tmp\pics2.xml"; :)
declare variable $DEST:="/pics.xml";
declare %updating function local:put($data,$path){
db:replace("vue-poc",$path,$data)
};
let $opt:=map{"include-info":true()}
let $files:=fw:directory-list($SRC,$opt)
return $files=>local:put($DEST)