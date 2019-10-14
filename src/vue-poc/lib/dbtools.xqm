xquery version "3.1";
(:~
: tools for databases..
: @author andy bunce
: @since mar 2013
:)

module namespace dbtools = 'quodatum.dbtools';
import module namespace file="http://expath.org/ns/file";
import module namespace db="http://basex.org/modules/db";
import module namespace archive="http://basex.org/modules/archive";
import module namespace hof="http://basex.org/modules/hof";

(:  trailing slash :)
declare variable $dbtools:webpath:= db:system()/globaloptions/webpath/fn:string()
                             || file:dir-separator();

(:~ 
: save all in db to zip
: no binary yet 
:)
declare function dbtools:zip($dbname as xs:string)
as xs:base64Binary{
  let $files:=db:list($dbname)
  let $zip   := archive:create(
                  $files ! element archive:entry { . },
                  $files ! fn:serialize(db:open($dbname, .))
                  )
return $zip
};

(:~
: update or create database from file path
: @param $dbname name of database
: @param $path file path contain files
:)
declare %updating function dbtools:sync-from-path(
                   $dbname as xs:string,
                   $path as xs:string,
                   $delete-missing as xs:boolean
                 )
{
   dbtools:sync-from-files($dbname,
                  $path,
                  file:list($path,fn:true()),
                  hof:id#1,
                  $delete-missing
                 )
};

(:~
: update or create database from file list. After this the database will have a
: matching copy of the files on the file system
: @param $dbname name of database
: @param $path  base file path where files are relative to en
: @param $files file names from base
: @param $ingest function to apply f(fullsrcpath)->anotherpath or xml nodes
:)
declare %updating 
function dbtools:sync-from-files($dbpath as xs:string,
                                 $path as xs:string,
                                 $files as xs:string*,
                                 $ingest as function(*),
                                 $delete-missing as xs:boolean
                               )
{
let $path:=$path ||"/"
let $files:=$files!fn:translate(.,"\","/")
let $files:=fn:filter($files,function($f){file:is-file(fn:concat($path,$f))})
let $dbpath:=tokenize($dbpath,"/")[.]
let $dbname:= head($dbpath)
return if(db:exists($dbname)) then
           (
           for $d in db:list($dbname) 
           where  $delete-missing  and fn:not($d=$files) 
           return db:delete($dbname,$d),
           
           for $f in $files
           let $_:=fn:trace($path || $f,"file:") 
           let $content:=$ingest($path || $f) 
           return db:replace($dbname,$f,$content),
           
           db:optimize($dbname)
           )
       else
          let $full:=$files!fn:concat($path,.)
          let $content:=$full!$ingest(.) 
          return (db:create($dbname,$content,$files))
};

