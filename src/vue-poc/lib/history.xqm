xquery version "3.1";
(:~
 : log an event
 :)
module namespace hlog = 'quodatum.data.history';
declare namespace hist="urn:quodatum:vue-poc.history";
declare variable $hlog:doc as element(hist:history):=db:open("vue-poc","/history.xml")/hist:history;

(:~
 wrap $item in <hist:event id=".." when=".." > node and insert in /history.xml in database vue-poc
 :)
declare 
%updating
function hlog:save($item as element(*))
{
let $id:=$hlog:doc/@next-id/string(.)
let $n:=<hist:event id="{$id}" when="{fn:current-dateTime()}" user="admin">{$item}</hist:event>
return (insert node $n as first into $hlog:doc,
            replace value of node $hlog:doc/@next-id with number($id)+1 
             )
};
