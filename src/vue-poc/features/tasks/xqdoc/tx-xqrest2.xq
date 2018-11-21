(:~
 : XQDoc: generate restxq.html from resources located at $target 
 :)
import module namespace xqd = 'quodatum:build.xqdoc' at "../../../lib/xqdoc/xqdoc-proj.xqm";
import module namespace store = 'quodatum.store' at "../../../lib/store.xqm";
import module namespace tree = 'quodatum.data.tree' at "../../../lib/tree.xqm";

declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace xqdoc="http://www.xqdoc.org/1.0";


(:~ URL of the doc source
 : @default file:///C:/tmp/xqdoc/
 :)
declare variable $target as xs:anyURI external :=
"file:///C:/tmp/xqdoca/" cast as xs:anyURI;

declare variable $nsRESTXQ:= 'http://exquery.org/ns/restxq';

(:~   map for each restxq:path 
 : @param 
:)
declare function local:import($path,
                              $id as item(),
                              $folder)
as map(*)*
{
  let $uri:=``[F`{ string($id) }`/]``
  let $doc:=doc(resolve-uri($uri || "xqdoc.xml",$folder))
  let $annots:=xqd:annotations($doc/*, $nsRESTXQ,"path")
  return $annots!map{
                "id": $id,
                "uri": $uri,
                "path": $path,
                "annot": .,
                "function": ./../../(xqdoc:name/string(),@arity/string()),
                "description": ./../../xqdoc:comment/xqdoc:description/node() 
                 }
       
};

(:~
 : html for page. 
 :)
 declare function local:page($reps as map(*)*)
{
let $tree:=trace($reps?uri)
let $tree:=tree:build($tree)=>trace("TRRES")
let $op:= <div>
          <nav id="toc">
            <div>
                <a href="index.html">
                   Index 
                </a>
            </div>
            <h2>
                <a id="contents"></a>
                <span >
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
                 <li  href="#main">
                    <a >
                        <span class="secno">2 </span>
                        <span class="content">Paths</span>
                    </a>
                </li>
                <li>
                </li>
             </ol>
           </nav>
           <a href="index.html">index: </a>
           <ol> { local:tree-list($tree) } </ol>
           <ul>{$reps!local:path-to-html(.)}</ul>
           </div>
return  xqd:page($op,map{"resources": "resources/"})
};

(:~ tree to list :)
declare function local:tree-list($tree){
  typeswitch ($tree )
  case element(directory) 
      return <li>{$tree/@name/string()}/<ul>{$tree/*!local:tree-list(.)}</ul></li>
      
  default 
     return <li>{$tree/@name/string()}</li>
};

(:~  html for a path :)          
declare function local:path-to-html($rep as map(*))
as element(li){
   <li id="{ $rep?uri }">
       <h4>{ $rep?uri }</h4>
       <ul>{
       let $methods as map(*) :=$rep?methods
       for $method in map:keys($methods)
       let $d:=$methods?($method)
       let $id:=head($d?function)
       return <li>
                    <a href="{$d?uri}index.html#{$id }">{ $method }</a>
                    <div>{$d?description}</div>
              </li>
       }</ul>
   </li>
};


(:sequence of maps :map{id:,path:,annot:} :)                                            
let $reports:= doc(resolve-uri("files.xml",$target))
              //c:file!local:import(string-join(ancestor-or-self::*/@name,"/"),position(),$target)

(: map keyed on uris :)
let $data:=map:merge(for $report in $reports
          group by $uri:=$report?annot/xqdoc:literal/string()
          let $methods:= map:merge(
                         for $annot in $report
                         let $hits:=for $method in $xqd:methods
                                     let $hit:=  xqd:methods($annot?annot/.., $nsRESTXQ, $method)
                                     return if(empty($hit)) then () else map{$method: $annot}
                         return if(exists($hits))then $hits else map{"ALL":$annot}
                         
                       )
          return map:entry($uri,map{ "uri": $uri, "methods": $methods})
        ) 


let $uris:=sort(map:keys($data))
let $result:=<json type="object">
                  <extra>hello</extra>
                  <msg> {$target}, {count($data)} uris processed.</msg>
                  <id>xqrest2 ID??</id>
              </json>
return 
      (
       local:page( $data?($uris))
       =>xqd:store2("restxq.html",$xqd:HTML5)
       =>store:store($target),
       update:output($result)
       )
 