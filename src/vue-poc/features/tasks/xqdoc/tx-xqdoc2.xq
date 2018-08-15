(:~
 : XQDoc: generate restxq.html from resources located at $target 
 :)
import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm"; 
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace xqdoc="http://www.xqdoc.org/1.0";


(:~ URL of the doc source
 : @default C:/tmp/xqdoc/
 :)
declare variable $target as xs:anyURI external :=
"C:/tmp/xqdoc/" cast as xs:anyURI;

declare variable $files :=doc(resolve-uri("files.xml",$target));

declare function local:foo($a,$k){
if($a) then map{"k":$k,"d":$a} else ()
};
                                 
let $base:=$files/*/@xml:base/string()
let $files:= $files//c:file
let $names:= $files!string-join(ancestor-or-self::*/@name,"/")
let $xqdocs:=$files!doc(resolve-uri(``[F`{ position() }`/xqdoc.xml]``,$target))
let $paths:= $xqdocs!local:foo(xqd:rxq(*),position())
let $items:=
for $annots in  $paths
    let $uri:=$annots?d/string()
    group by $uri
    order by $uri
    return <li>
               <h3>{ $uri }</h3>
               <ol>{
               for $annot in $annots
               let $fun:=$annot?d/../..
               let $funname:=concat($fun/xqdoc:name/string(),'#',$fun/@arity/string())
               let $href:="F12/index.html#field-list"
               return <li><a href="{$href}">{$funname}</a>{$annot?k}</li>
               }</ol>
               <a>{ $uri }</a>
           </li>

return <div>
          <nav id="toc">
            <div>
                <a href="index.html">
                   Index 
                </a>
            </div>
            <h2>
                <a id="contents"></a>
                <span class="namespace">
                    RestXQ
                </span>
            </h2>
            <ol class="toc">
                <li>
                    <a href="#main">
                        <span class="secno">1 </span>
                        <span class="content">Introduction</span>
                    </a>
                </li>
             </ol>
           </nav>
           <a href="index.html">index: { $base }</a>
          <ul>{ $items }</ul>
       </div>
       =>xqd:page(map{"resources":"resources/"})
       =>xqd:store(resolve-uri("restxq.html",$target),$xqd:HTML5)
