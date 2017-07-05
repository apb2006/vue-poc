(:~
 : file Utility functions.
 :
 : @author Andy Bunce, 2017
 :)
module namespace ufile = 'vue-poc/file';

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
                error(xs:QName('vue-api:badpath'),"leading slash")
                 
  let $webroot:=db:system()/globaloptions/webpath/concat(.,"/")
  return file:resolve-path($file,$webroot)
};

