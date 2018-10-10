(:~
 : XQDoc: generate restxq.html from resources located at $target 
 :)
import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
import module namespace store = 'quodatum.store' at "../../../lib/store.xqm"; 
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace xqdoc="http://www.xqdoc.org/1.0";


(:~ URL of the doc source
 : @default file:///C:/tmp/xqdoc/
 :)
declare variable $target as xs:anyURI external :=
"file:///C:/tmp/xqdoc/" cast as xs:anyURI;
declare variable $nsRESTXQ:='http://exquery.org/ns/restxq';
declare variable $files :=doc(resolve-uri("files.xml",$target));

declare function local:xqdoc-url($key as item())
as xs:anyURI
{
  resolve-uri(``[F`{ string($key) }`/xqdoc.xml]``,$target)
};
  
declare function local:item($doc as item()*,$key as item())
as map(*)?
{
  if($doc) then map{"key":$key,"value":$doc} else ()
};
                                 
let $base:=$files/*/@xml:base/string()
let $files:= $files//c:file
let $names:= $files!string-join(ancestor-or-self::*/@name,"/")
let $xqdocs:=$files!doc(local:xqdoc-url(position()))
let $paths:= $xqdocs!local:item(xqd:annotations(*, $nsRESTXQ,"path"),position())
let $items:=
for $annots in  $paths
    let $uri:=$annots?d/string()
    group by $uri
    order by $uri
    return <li>
               <h3>{ $uri }</h3>
               <ol>{
               for $annot in $annots
               let $fun:=$annot?doc/../..
               let $funname:=concat($fun/xqdoc:name/string(),'#',$fun/@arity/string())
               let $href:="F12/index.html#field-list"
               return <li><a href="{$href}">{$funname}</a>{$annot?key}</li>
               }</ol>
               <a>{ $uri }</a>
           </li>

let $op:= <div>
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
       =>xqd:store2(resolve-uri("restxq.html",$target),$xqd:HTML5)
       
 let $result:=<json type="object">
                  <extra>hello</extra>
                  <msg> {$target}, {count($files//c:file)} files processed.</msg>
                  <id>none</id>
              </json>
                    
return (
        store:store($op,$target),update:output($result)
        )
