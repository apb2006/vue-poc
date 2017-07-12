(:~ 
: dice utils - sort, filter, and serialize as json.
: can read parameters from request: sort,start,limit.
: @requires basex 8.6 for map:merge
: @author andy bunce
: @since mar 2013
:)

module namespace dice = 'quodatum.web.dice/v4';
declare default function namespace 'quodatum.web.dice/v4'; 
declare namespace restxq = 'http://exquery.org/ns/restxq';

declare variable $dice:default:=map{
    "start" : 1, (: start index :)
    "limit" : 30, (: max items :)
    "sort" : ""
};


(:~ 
 : sort items
 : @param sort  field name to sort on optional leading +/-
 : @return sorted items 
 :)
declare function sort($items as item()*
                     ,$fmap as map(*)
                     ,$sort as xs:string?)
as item()*{
  let $sort:=fn:normalize-space($sort)=>fn:trace("dice:sort")
  let $ascending:=fn:not(fn:starts-with($sort,"-"))
  let $fld:=fn:substring($sort,if(fn:substring($sort,1,1)=("+","-")) then 2 else 1)
  return if(fn:not(map:contains($fmap, $fld))) then
            $items
          else if ($ascending) then
            for $i in $items
           (: let $i:=fn:trace($i,"feld " || $fld ) :)
            order by $fmap($fld)($i) ascending collation "http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive"
            return $i
          else
            for $i in $items 
            order by  $fmap($fld)($i) descending collation "http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive"
            return $i
};

(:~ generate item xml for all fields in map :)
declare function json-flds($item,$fldmap)
as element(_){
  json-flds($item,$fldmap,map:keys($fldmap)) 
};

(:~ generate item xml for some fields in map :)
declare function json-flds($item as element(),
                           $fldmap as map(*),
						   $keys as xs:string*)
as element(_){ 
    <_> 
    {for $key in $keys 
	return 
    try{
       $fldmap($key)($item)
    }catch * {
       element {$key}{$err:description }
    } }
	</_>
};


(:~ 
 : sort, slice, return json using request parameters
 : @param $items sequence of source items
 : @param $opts sort and slice values
 :)
declare function response($items,
                          $entity as map(*),
                          $opts as map(*))
 {
  let $total:=fn:count($items)
  let $opts:=map:merge(($opts,$dice:default))
  let $items:= dice:sort($items,$entity?access,$opts?sort)
  let $jsonf:= $entity?json
  let $fields:=if ($opts?fields) then fn:tokenize($opts?fields) else map:keys($jsonf)
  let $slice:= fn:subsequence($items,$opts?start,$opts?limit)
  return 
  <json objects="json _" >
    <total type="number">{$total}</total>
    <range>{$opts?start}-{$opts?start+fn:count($slice)-1}/{$total}</range>
    <entity>{$entity?name}</entity>
    <items type="array">
        {for $item in $slice
        return <_ >{$fields!$jsonf(.)($item)}</_>}
    </items>
  </json> 
};

(:~ 
 : get data
 :)
declare function get($entity as map(*),$name as xs:string)
as element(*){
    let $results:=$entity("data")()
    return $results[$name=$entity?access?name(.)]
};

(:~ 
 : sort, slice, return json
 :)
declare function response($items,$entity as map(*)){
    response($items,$entity,map{})
};
(:~ 
 : @return  json for item
 :)
declare function one($item,$entity as map(*))
{
 one($item,$entity,map{})
};
(:~ 
 : @return  json for item
 :)
declare function one($item,$entity as map(*),$opts as map(*))
{
  let $jsonf:= map:get($entity,"json")
  let $fields:=if ($opts?fields) then fn:tokenize($opts?fields) else map:keys($jsonf)=>fn:trace("FF")
  
  return  <json objects="json " >
  {$fields!$jsonf(.)($item)}
  </json> 
};