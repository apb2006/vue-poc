declare namespace fw="quodatum:collection.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";
import module namespace tree="quodatum.data.tree" at "lib/tree.xqm";

let $paths:=uri-collection("/ALO")
return tree:build($paths)