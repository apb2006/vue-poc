xquery version "3.1";
(:~
 : upload test
 :)
module namespace _ = 'quodatum.test.upload';
import module namespace Session = 'http://basex.org/modules/session';
(:~ DBA directory. :)
declare variable $_:DBA-DIRECTORY := (
  for $dir in db:option('dbpath') || '/.vue-poc'
  return (
    if(file:exists($dir)) then () else file:create-dir($dir),
    file:path-to-native($dir)
  )
);
(:~
 : sample form i/p
 :)
declare %updating  
%rest:POST %rest:path("/vue-poc/api/upload2")
%rest:form-param("data", "{ $data }")
%rest:form-param("avatar", "{ $file }")
%output:method("text")
function _:upload($data, $file)
{
  for $name    in map:keys($file)
  let $content := $file($name)
  let $path    := _:directory() || $name
  return (
    file:write-binary($path, $content),
    update:output(<file name="{ $name }" size="{ file:size($path) }"/>)
    )
};

declare function _:directory() as xs:string {
  (: let $dir := Session:get($_:DIRECTORY)
  return if(exists($dir) and file:exists($dir)) then $dir else :)
  $_:DBA-DIRECTORY
};