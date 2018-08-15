(:~
 : Generate XQuery  documentation in html
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 : $efolder:="file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models"
 : $target:="file:///C:/Users/andy/workspace/app-doc/src/doc/generated/models.xqm"
 :)
module namespace xqd = 'quodatum:build.xqdoc';
import module namespace xp="expkg-zone58:text.parse";
declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace xqdoc="http://www.xqdoc.org/1.0";

declare variable $xqd:HTML5:=map{"method": "html","version":"5.0"};
declare variable $xqd:XML:=map{"indent": "no"};
declare variable $xqd:mod-xslt external :="html-module.xsl";
declare variable $xqd:index-xslt external :="html-index.xsl";

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
    $files//c:file!xqd:gendoc(.,"F" || position(),$target,$params),
    $f=>xqd:store($target || "/files.xml",$xqd:XML),
    $f=>xqd:index-html($params)=>xqd:store($target || "/index.html",$xqd:HTML5),
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
  
   let $xqdoc:= xqd:xqdoc($ip,map{})
   let $xq:= fetch:text($ip)
   let $params:=map:merge((map{
                "source":$xq,
                "filename":$f/@name/string(),
                "cache":true(),
                "show-private":true(),
                "resources":"../resources/"},
                $params))
   return (
       $xq=>xqd:parse()=>xqd:store($dest || "/xparse.xml",$xqd:XML),
       $xqdoc=>xqd:store($dest || "/xqdoc.xml",$xqd:XML),
       $xqdoc=>xqd:xqdoc-html($params)=>xqd:store($dest || "/index.html",$xqd:HTML5)
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
     
(:~ parse XQuery 
 : result is <XQuery> or <ERROR>
 :)
declare function xqd:parse($xq as xs:string)
as element(*)
{  
  xp:parse($xq || "",map{"lang":"xquery","version":"3.1 basex-20161204"}) 
};

(:~ Generate xqdoc :)
declare function xqd:xqdoc($url as xs:string,$opts as map(*))
as element(xqdoc:xqdoc)
{  
 inspect:xqdoc($url)
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
declare function xqd:export-resources($target as xs:string)                       
{  
archive:extract-to($target, file:read-binary(resolve-uri('resources.zip')))
}; 
(:~ 
 : return all rest:path annotations
  :)
declare function xqd:rxq($xqdoc  as element(xqdoc:xqdoc)) 
as element(xqdoc:annotation)*
{
   let $restxq:=$xqdoc//xqdoc:namespace[@uri='http://exquery.org/ns/restxq']/@prefix/string()
  return $xqdoc//xqdoc:annotations/xqdoc:annotation[@name=(for $p in $restxq return concat($p,':path'))]

};

(:~ 
 : generate standard page wrapper
  :)
declare function xqd:page($body,$opts as map(*)) 
as element(html)
{
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="Generator" content="xqdoc-r - https://github.com/quodatum/xqdoc-r" />

        <title>
          RestXQ - xqDoc
        </title>
        <link rel="shortcut icon" type="image/x-icon" href="{$opts?resources}xqdoc.png" />
        <link rel="stylesheet" type="text/css" href="{$opts?resources}page.css" />
        <link rel="stylesheet" type="text/css" href="{$opts?resources}query.css" />
        <link rel="stylesheet" type="text/css" href="{$opts?resources}base.css" />

        <link rel="stylesheet" type="text/css" href="{$opts?resources}prettify.css" />

        <script src="{$opts?resources}prettify.js" type="text/javascript">&#160;</script>
        <script src="{$opts?resources}lang-xq.js" type="text/javascript">&#160;</script>
      </head>

      <body class="home" id="top">
        <div id="main">
        {$body}
        </div>
        <div class="footer">
            <p style="text-align:right">generated at {current-dateTime()}</p>
          </div>
      </body>
    </html>

};          