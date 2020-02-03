(:~ 
: log enrich
: @author andy bunce
: @todo
:)
declare %updating function local:enrich($doc as document-node()){
  let $date:=fn:analyze-string(db:path($doc),"(\d{4}-\d{2}-\d{2})")/fn:match/fn:group/string()
  return 
  for $entry in $doc/entries/entry
  return  local:update-entry($entry,$date)
};

declare %updating function local:update-entry($entry,$date as xs:string){
  let $start :=xs:dateTime(concat($date,"T",$entry/@time)) 
  return (
     local:set-start($entry,$start),
     if($entry/@ms) then
          let $end:=$start+ xs:dayTimeDuration("PT" || ($entry/@ms div 1000) || "S")
          return local:set-end($entry,$end)
     else 
        delete node $entry/@end
   )
};

declare %updating function local:set-start($entry,$start as xs:dateTime)
{
 if($entry/@start) then
    replace value of node $entry/@start with $start
 else
    insert node attribute start {$start} into $entry  
};

declare %updating function local:set-end($entry,$end )
{
 if($entry/@end) then
    replace value of node $entry/@end with $end
 else
    insert node attribute end {$end} into $entry  
};

db:open("vue-poc","/logs") 
!local:enrich(.),
update:output("Done")