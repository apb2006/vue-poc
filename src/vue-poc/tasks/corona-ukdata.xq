(:~ 
 : virus cases by UTLA
 : @author Andy Bunce
 : @date 2020-05-19
 :)
declare variable $url:="https://c19downloads.azureedge.net/downloads/json/coronavirus-cases_latest.json";
declare variable $date:="2020-05-20";

declare function local:json-parse($t as xs:string)
{
  (: @see https://stackoverflow.com/questions/15228651/how-to-parse-json-string-containing-nan-in-node-js  :)
  let $t:=replace($t,"NaN","null")
  return json:parse($t,map{})
};

let $json:= fetch:text($url)=>local:json-parse()
for $utla in $json/json/utlas/_[specimenDate=$date]
let $cases:= $utla/totalLabConfirmedCases/number()
let $daily:= $utla/dailyLabConfirmedCases/number()
order by $cases descending
count $pos
return ``[ `{$pos }`: `{ $utla/areaName }` `{$cases}``{ if($daily ne 0) then " +" || $daily else '' }`.]``