(:~
 : create vue-poc db
 :)
import module namespace dbtools = 'quodatum.dbtools'  at "../lib/dbtools.xqm";

declare variable $target-db:="vue-poc";

declare variable $data-uri:=resolve-uri("../data/vue-poc/");
(dbtools:sync-from-files(
                            $target-db
                           ,$data-uri
                           ,file:list($data-uri,fn:true())
                          ,hof:id#1))