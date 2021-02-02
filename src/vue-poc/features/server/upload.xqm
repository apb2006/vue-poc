xquery version "3.1";
(:~
 : upload test
 :)
module namespace _ = 'quodatum.test.upload';
import module namespace Session = 'http://basex.org/modules/session';
(:~ upload directory. :)
declare variable $_:upload-folder := (
  let $dir := db:option('dbpath') || '/.vue-poc'
  return (
    if(file:exists($dir)) then () else file:create-dir($dir),
    file:path-to-native($dir)
  )
);


(:~
 : save upload to filesystem
 :)
declare %updating  
%rest:POST %rest:path("/vue-poc/api/upload")
%rest:form-param("file", "{ $file }")
%output:method("text")
function _:upload( $file)
{
  for $name    in map:keys($file)
  let $content := $file($name)
  let $path    :=  $_:upload-folder || $name
  return (
    file:write-binary($path, $content),
    update:output(<file name="{ $name }" size="{ file:size($path) }"/>)
    )
};

(:~
 : list uploads
 :)
declare 
%rest:GET %rest:path("/vue-poc/api/upload")
%rest:produces("application/json")
%output:method("json")
function _:list-uploads()
{
 <json/>
};