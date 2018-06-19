(:~ 
 :  pipeline library 
 : @author Andy Bunce
 : @version 0.2
 : @date nov 2017
:)
module namespace  qipe='http://quodatum.com/ns/pipeline';
import module namespace schematron = "http://github.com/Schematron/schematron-basex";

declare variable $qipe:DEBUG:=false(); (: currently unused :)

(:~  run a pipeline 
 : @param $pipe the pipeline document
 : @param $initial starting data as sequence
 : @result 
 :)
declare function qipe:run($pipe as node(),$initial as item()* )
as item()*
{
  let $steps:=$pipe/*/qipe:*
  return fold-left($steps,$initial,qipe:step#2)
};

(:~ check pipeline is valid against schema :)
declare function qipe:validate-pipeline($pipe as document-node() )
as document-node()
{
 validate:rng($pipe , "schemas/pipeline.rnc",true()),$pipe
};

(:~  run a step 
 : @param $acc current state
 : @param $this current step as qipe:* element
 :)
declare function qipe:step($acc,$this as element(*))
{
  typeswitch($this)
  case element(qipe:validate)  return qipe:validate($acc,$this)
  case element(qipe:xquery) return qipe:xquery($acc,$this)
  case element(qipe:xslt) return qipe:xslt($acc,$this)
  case element(qipe:load) return qipe:load($acc,$this)
  case element(qipe:store) return qipe:store($acc,$this)
  default return error(xs:QName('qipe'), 'unknown step:' || name($this))
};

(:~  run validate step based on @type
:)
declare function qipe:validate($acc,$this as element(qipe:validate))
{
  let $href:=qipe:resolve($this/@href)
  let $failOnError:=boolean($this/@failOnError)
  let $fn:= switch ($this/@type/string())
             case "relax-ng" return  qipe:relax-ng(?,$href )
             case "schematron" return  qipe:schematron(?,$href )
             case "xml-schema" return  qipe:validate-xsd(?,$href )
             default return error(xs:QName('qipe'), 'unknown validation type: ' || $this/@type/string() )
  for  $doc in $acc
  let $report:=$fn($doc)
  return  
         if($report/status = "valid") then
             $doc
         else
           let $_:=trace($report,"validation errors")
           return  if($failOnError) then
                        error(xs:QName('qipe'), ' validation fails: ' || base-uri($doc))
                   else
                       $doc
};

(:~  
 : run xquery referenced by @href and append result sequence to accumulator
 :)
declare function qipe:xquery($acc,$this  as element(qipe:xquery))
{
  let $href:=$this/@href/string()
  let $result:=xquery:invoke($href)
  return ($acc,$result)
};

(:~  
 : apply XSLT transform to each item in accumulator
 :)
declare function qipe:xslt($acc,$this  as element(qipe:xslt))
{
  let $href:=qipe:resolve($this/@href)
  let $result:=$acc!xslt:transform(., $href)  
  return $result
};

(:~  
 : store each item in accumulator at computed path
 :)
declare function qipe:store($acc,$this  as element(qipe:store))
{
  let $href:=qipe:resolve($this/@base)
  let $dated:=boolean($this/@dated)
  let $name:=$this/@fileExpression/string()
  let $href:=$href || (if( $dated) then format-date(current-date(),"/[Y0001][M01][D01]") else ())
  
  return ($acc,
          if(file:exists($href)) then () else file:create-dir($href),
          for $item in $acc
          let $name:=xquery:eval($name,map{"":$item}) (:eval against doc:)
          let $dest:=$href || "/" || $name
          return file:write($dest,$item)
        )
};

(:~  validate with xml-schema  :)
declare function qipe:validate-xsd($doc,$xsd )
as element(report)
{ 
  validate:xsd-report($doc,$xsd) 
};

(:~  validate with relax-ng  :)
declare function qipe:relax-ng($doc,$rng )
as element(report)
{
  let $compact:=matches($rng,".*\.rnc")
 return validate:rng-report($doc,$rng,$compact) 
};


(:~ 
 : validate with schematron
 : NOTE: relative paths in doc() references in schematron may cause issues  
  :)
declare function qipe:schematron($doc,$uri-sch )
as element(report)
{
  let $sch := schematron:compile(doc($uri-sch))
  let $svrl := schematron:validate($doc, $sch)
  return <report>
            <status>{
              if(schematron:is-valid($svrl)) then 'valid' else 'invalid'
            }</status>
           {$svrl}
   </report>          
};

(:~  load from file system  :)
declare function qipe:load($acc,$this )
{ 
 let $href:=qipe:resolve($this/@href)=>trace("load")
 let $new:=if(file:is-dir($href)) then  
                error(xs:QName('qipe'), 'dir loading not implemented') (: @TODO load all:)
            else 
               doc($href)
 return ($acc,$new)
};

(:~  resolve locations relative to this document typically from @href :)
declare function qipe:resolve($href as node()? )
{ 
 resolve-uri( $href,base-uri($href))
};
