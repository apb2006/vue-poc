import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";

for $f in //c:file
let $ip:= $f/@name/resolve-uri(.,base-uri(.))
 let $xq:= fetch:text($ip)
 return xqd:parse($xq)