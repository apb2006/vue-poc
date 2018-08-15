(:~ 
: Import a file or directory into a database
: @author andy bunce
: @since july 2018
:)
import module namespace dbtools = 'quodatum.dbtools' at "../../../lib/dbtools.xqm";


(:~ URL of file or folder to import
 : @default C:/Users/andy/git/vue-poc/src/vue-poc/models/entities
  :)
declare variable $srcpath as xs:anyURI  external :="C:/Users/andy/git/vue-poc/src/vue-poc/models/entities";

(:~ Target BaseX db root path for imported files 
 : @default /vuepoc-test/
 :)
declare variable $targetpath as xs:anyURI external :="/vuepoc-test";

(:~ unused boolean test
 : @default true
  :)
declare variable $boolean as xs:boolean  external :=false();
                                 
let $result:=<json type="object"><hello>TODO</hello></json>
return $result