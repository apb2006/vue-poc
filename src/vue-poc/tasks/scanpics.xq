(:~ create xml file list
:)
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";
let $opt:=map{"include-filter":".*\.xsd",
              "max-depth":-1,
              "include-info":true()}
return fw:directory-list("/",$opt)