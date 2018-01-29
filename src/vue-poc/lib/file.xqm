(:~
 : file Utility functions.
 :
 : @author Andy Bunce, 2017
 :)
module namespace ufile = 'vue-poc/file';
import module namespace fw="quodatum:file.walker";
declare namespace c="http://www.w3.org/ns/xproc-step";
(:~
 : resolve path relative to basex webpath
 : file("/fred")=>C:\Program Files (x86)\BaseX\webapp\fred
 :)
declare function ufile:web($file as xs:string)
as xs:string
{
  let $file:=if(starts-with($file,"/")) then 
                substring($file,2) 
            else 
                error(xs:QName('ufile:badpath'),"leading slash")
                 
  let $webroot:=db:system()/globaloptions/webpath/concat(.,"/")
  return file:resolve-path($file,$webroot)
};

declare  function ufile:webfile($url as xs:string)
as element(c:directory)
{
       let $path := ufile:web( $url)=>trace("ufile:web ")
         return if( file:exists($path))then 
                   fw:directory-list($path,map{"max-depth":1,"include-info":true()})
                else
                    error(xs:QName('ufile:badpath'),$path)
};

declare  function ufile:xmldb($url as xs:string)
as element(c:directory)
{
        <c:directory  name="" xml:base="xmldb:/" last-modified="?" size="?">{
         if($url="/") then
             db:list()!
             <c:directory name="{db:property(.,'name')}" content-type="text/directory"
                     last-modified="{db:property(.,'timestamp')}" 
                     size="{db:property(.,'size')}"/>
           
        else
          let $db:=substring-before(substring($url,2),"/")
          let $path:=substring($url,2+string-length($db))
          let $map:=ufile:collection-next($url)
          for $name in map:keys($map)
        
          (: db:list-details($db as xs:string, $path as xs:string) as element(resource)* :)
          return if($map($name)="file") then
                   let $x:=db:list-details($db , $path || $name) 
                   return <c:file name="{$name}" size="0"/>
                  else
                    <c:directory name="{$name}"  content-type="text/directory" size="0"/>
      }</c:directory>
};

(:~ return map of next level database contents
 :@param $url a database base collection e.g /dbname/fred/
 :@result keys are names, values are "file" or "directory"
:)
declare function ufile:collection-next($url as xs:string)
as map(*)
{
 if(not(starts-with($url,"/") and ends-with($url,"/"))) then
  error(xs:QName('ufile:badcollection'),$url)
 else 
 fold-left(
    uri-collection($url ),
    map{},
    function($acc,$this){
      let $s:=substring-after($this ,$url )
      let $isDir:=contains($s,"/") 
      let $s:=if($isDir)then substring-before($s,"/")  else $s
      return map:merge((map:entry($s,if($isDir)then "directory" else "file"),$acc))
    }
  )
};
