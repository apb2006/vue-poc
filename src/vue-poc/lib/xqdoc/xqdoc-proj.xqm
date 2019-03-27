(:~
 : Generate XQuery  documentation in html
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 : $efolder:="file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models"
 : $target:="file:///C:/Users/andy/workspace/app-doc/src/doc/generated/models.xqm"
 :)
module namespace xqd = 'quodatum:build.xqdoc';
import module namespace xp="expkg-zone58:text.parse";
import module namespace store = 'quodatum.store' at '../store.xqm';
import module namespace xqhtml = 'quodatum:build.xqdoc-html' at "xqdoc-html.xqm";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace xqdoc="http://www.xqdoc.org/1.0";

declare variable $xqd:HTML5:=map{"method": "html","version":"5.0"};
declare variable $xqd:XML:=map{"indent": "no"};
declare variable $xqd:mod-xslt external :="html-module.xsl";
declare variable $xqd:index-xslt external :="html-index.xsl";
declare variable $xqd:nsRESTXQ:= 'http://exquery.org/ns/restxq';
declare variable $xqd:cache external :=false();

(:~  @see https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods :)
declare variable $xqd:methods:=("GET","HEAD","POST","PUT","DELETE","PATCH");

(:~ 
 : save documentation for files to target
 : @param $files c:directory-list
 : @param $target where to save
 : @param $opts
 :)
declare function xqd:save-xq($files,$target,$params as map(*))
{
let $f:=  document{$files} transform with { delete  node //c:directory[not(.//c:file)]}
 
return (
    $files//c:file!xqd:gendoc(.,"modules/F" || position(),$target,$params),
    $f=>xqd:store($target || "/files.xml",$xqd:XML),
    $f=>xqhtml:index-html($params)=>xqd:store($target || "/index.html",$xqd:HTML5),
    xqd:export-resources($target)
    )
};   
 
(:~
 : save xqdoc and html for source file $f
 : @param $f <c:file/>
 : @param $target destination folder
 : @param map
 : @param 
 :)
declare  function xqd:gendoc(
                    $f as element(c:file),
                    $op as xs:string, 
                    $target as xs:string,
                    $params as map(*)
)
 {
  let $_:= if(file:is-dir($target)) then () else file:create-dir($target)
   let $target:= file:path-to-native($target)
  let $ip:= $f/@name/resolve-uri(.,base-uri(.))
   let $dest:= file:resolve-path($op,$target)
  
   let $xqdoc:= xqd:xqdoc($ip,map{"source": $ip})
   let $xq:= fetch:text($ip)
   let $params:=map:merge((map{
                "source": $xq,
                "filename": $f/@name/string(),
                "cache": $xqd:cache,
                "show-private": true(),
                "resources": "resources/"},
                $params))
   return (
       $xq=>xqd:parse()=>xqd:store($dest || "/xparse.xml",$xqd:XML),
       $xqdoc=>xqd:store($dest || "/xqdoc.xml",$xqd:XML),
       $xqdoc=>xqd:xqdoc-html($params)=>xqd:store($dest || "/index.html",$xqd:HTML5)
        )
 };
 
 (:~
  : create documentation folder map
  : map{"base-uri":.., "files":map(*)*}
  :)
 declare function xqd:read($efolder as xs:string)
{
let $files:= file:list($efolder,true(),"*.xqm")
let $full:= $files!concat($efolder || "\",.)                                
return map{ 
             "base-uri": $efolder,
             "files": for $file in $files
                      let $full:=concat($efolder || "\", $file)
                      return map{
                        "full":$full,
                        "xqdoc": xqd:xqdoc($full,map{"_source": $full}),
                        "xqparse": xqd:parse($full)
                      }
          
           }

};

declare function xqd:imports($doc)
{
  let $keys:=$doc?files?xqdoc!map:entry(generate-id(.),position())=>map:merge()
let $ns:=for $in in $doc?files?xqdoc//xqdoc:import[@type="library"]
         group by $ns:=$in/xqdoc:uri
         let $id:=$keys?($in/root()/generate-id())
         return map:entry($ns,$id)
  return map:merge(($doc,map{"keys": $keys, 
                             "imports": $ns}))
};

 (:~
 : save xqdoc and html for source file $f
 : @param $f <c:file/>
 : @param $target destination folder
 : @param map
 : @param 
 :)
declare  function xqd:gendoc2(
                    $f as element(c:file),
                    $op as xs:string, 
                    $target as xs:string,
                    $params as map(*)
)
as map(*)* {
  let $ip:= $f/@name/resolve-uri(.,base-uri(.))
  let $xqdoc:= xqd:xqdoc($ip,map{})
  let $xq:= fetch:text($ip)
  let $params:=map:merge((map{
                "source": $xq,
                "filename": $f/@name/string(),
                "cache": $xqd:cache,
                "show-private": true(),
                "root": "../../",
                "resources": "resources/"},
                $params))
   return (
       xqd:store2(xqd:parse($xq), "xparse.xml",$xqd:XML),
        xqd:store2($xqdoc,"xqdoc.xml",$xqd:XML),
        xqd:store2(xqd:xqdoc-html($xqdoc,$params), "index.html",$xqd:HTML5)
        )
 };
(:~ 
 :save $data to $url , create fdolder if missing) 
 :)
declare function xqd:store($data,$url as xs:string,$params as map(*))
{  
   let $p:=file:parent($url)
   return (
           if(file:is-dir($p)) then () else file:create-dir($p),
           file:write($url,$data,$params)
           )
};

(:~ 
 : return intent to save $data to $url with serialization $params
 :)
declare function xqd:store2($data,$url as xs:string,$params as map(*))
{  
  map{"document": $data, "uri":$url,"opts":$params}
};
     
(:~ parse XQuery 
 : result is <XQuery> or <ERROR>
 :)
declare function xqd:parse($xq as xs:string)
as element(*)
{  
  xp:parse($xq || "",map{"lang":"xquery","version":"3.1 basex-20161204"}) 
};

(:~ 
 : Generate xqdoc adding custom opts 
 :)
declare function xqd:xqdoc($url as xs:string,$opts as map(*))
as element(xqdoc:xqdoc)
{  
  inspect:xqdoc($url)
  transform with {
          for $tag in map:keys($opts)
          return insert node <xqdoc:custom tag="_{ $tag }">{ $opts?($tag) }</xqdoc:custom> 
          into xqdoc:module[@type="library"]/xqdoc:comment
  }
};
         
(:~ transform xqdoc to html :)
declare function xqd:xqdoc-html($xqd as element(xqdoc:xqdoc),
                            $params as map(*)
                            )
as document-node()                            
{  
xslt:transform($xqd,$xqd:mod-xslt,$params)
};

(:~ transform files to html :)
declare function xqd:index-html($files,
                            $params as map(*)
                            )
as document-node()                            
{  
xslt:transform($files,$xqd:index-xslt,$params)
};

(:~ save runtime support files to $target :)
declare
function xqd:export-resources($target as xs:string)                       
as empty-sequence(){  
archive:extract-to($target, file:read-binary(resolve-uri('resources.zip')))
}; 

(:~ save runtime support files to $target :)
declare %updating
function xqd:export-resources2($target as xs:string)                       
as empty-sequence(){  
archive:extract-to($target, file:read-binary(resolve-uri('resources.zip')))
}; 
(:~ 
 : return all matching annotations in xqdoc
  :)
declare function xqd:annotations($xqdoc  as element(xqdoc:xqdoc),
                                 $annotns as xs:string,
                                 $aname as xs:string) 
as element(xqdoc:annotation)*
{
   let $prefixes:=$xqdoc//xqdoc:namespace[@uri=$annotns]/@prefix/string()
  return $xqdoc//xqdoc:annotations/xqdoc:annotation[@name=(for $p in $prefixes return concat($p,':',$aname))]

};

(:~ 
 : return annotations with namespace and name
  :)
declare function xqd:methods($annots  as element(xqdoc:annotations),
                                 $annotns as xs:string,
                                 $aname as xs:string) 
as element(xqdoc:annotation)*
{
   let $ns:=$annots/ancestor::xqdoc:xqdoc/xqdoc:namespaces
   let $prefixes:=$ns/xqdoc:namespace[@uri=$annotns]/@prefix/string()
  return $annots/xqdoc:annotation[@name=(for $p in $prefixes return concat($p,':',$aname))]

};



(: @return map of functions and variables having annotations :)
declare function xqd:annotation-map($xqdoc){
  let $ns:=map:merge((
           map:entry("", "http://www.w3.org/2012/xquery"),
           $xqdoc//xqdoc:namespace!map:entry(string(@prefix),string(@uri))
           ))
  let $f:=$xqdoc//xqdoc:function[xqdoc:annotations]!
                  map:entry(
                        xqdoc:name || "#" || @arity,
                        xqd:annots(xqdoc:annotations/xqdoc:annotation,$ns)
                   )
   let $v:=$xqdoc//xqdoc:variable[xqdoc:annotations]!
                 map:entry(
                   xqdoc:name ,
                   xqd:annots(xqdoc:annotations/xqdoc:annotation,$ns)
                 )
  return map:merge(($f,$v))
         
};

(: return annotation map for a name 
 :  map{ $ns: map{
 :        $aname: $values
 :      }
 : }
 :)
declare function xqd:annots(
 $annots as element(xqdoc:annotation)*,
 $ns as map(*)
) as map(*)
{
 map:merge( 
 for $a in $annots
 group by $prefix:=substring-before($a/@name,":")
 return for $p in $prefix
                  return map:entry(
                     $ns?($p),
                     map:merge((
                     for $x in $a
                     group by $aname:=if(contains($x/@name,":")) then substring-after($x/@name,":") else $x/@name
                     return map:entry($aname,$x/*/string())
                  ))
                )
)};        