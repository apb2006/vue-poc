(:~ 
: Import a file or directory into a database
: @author andy bunce
: @since july 2018
:)
import module namespace dbtools = 'quodatum.dbtools' at "../../../lib/dbtools.xqm";


(:~ URL of file or folder to import
 : @default C:\Users\andy\git\vue-poc\src\vue-poc\data\vue-poc\entities\
  :)
declare variable $srcpath as xs:string  external :="C:\Users\andy\git\vue-poc\src\vue-poc\data\vue-poc\entities\";

(:~ Target BaseX db root path for imported files 
 : @default /vue-poc/entities/
 :)
declare variable $targetpath as xs:string external :="/vuepoc-test";

(:~ delete from database if not if import files list
 @default false
:)
declare variable $deleteMissing as xs:boolean  external :=false();
           
dbtools:sync-from-path($targetpath, $srcpath,$deleteMissing )
