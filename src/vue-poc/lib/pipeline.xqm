(:~ 
 :  pipeline library 
 : @author Andy Bunce
 : @version 0.2
 : @date nov 2017 jun 2018
:)
module namespace  qipe='http://quodatum.com/ns/pipeline';
import module namespace schematron = "http://github.com/Schematron/schematron-basex";


(:~  run a pipeline 
 : @param $pipe the pipeline document
 : @param $initial starting data as sequence
 : @result 
 :)
declare function qipe:run($pipe as node(),$initial as item()* )
as item()*
{
  let $opts:=map{"id":"66", "log":true(),"trace":true()}
  let $_:=qipe:log( "start: " || count($initial),$opts)
  let $steps:=$pipe/qipe:*
  let $result:= fold-left($steps,$initial,qipe:step(?,?,$opts))
  return (
          $result,
          qipe:log( "end: ",$opts)
        )
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
declare function qipe:step($acc,$this as element(*),$opts as map(*))
{
  typeswitch($this=>trace("RUNNING:"))
  case element(qipe:validate)  return qipe:validate($acc,$this,$opts)
  case element(qipe:xquery) return qipe:xquery($acc,$this,$opts)
  case element(qipe:xslt) return qipe:xslt($acc,$this,$opts)
  case element(qipe:load) return qipe:load($acc,$this,$opts)
  case element(qipe:store) return qipe:store($acc,$this,$opts)
  default return error(xs:QName('qipe'), 'unknown step:' || name($this))
};

(:~  run validate step based on @type
:)
declare function qipe:validate($acc,$this as element(qipe:validate),$opts as map(*))
{
  let $href:=qipe:resolve($this/@href)
  let $failOnError:=boolean($this/@failOnError)
  let $fn:= switch ($this/@type/string())
             case "relax-ng" return  qipe:relax-ng(?,$href )
             case "schematron" return  qipe:schematron(?,$href )
             case "xml-schema" return  qipe:validate-xsd(?,$href )
             case "dtd" return  qipe:validate-dtd(?,$href )
             default return error(xs:QName('qipe'), 'unknown validation type: ' || $this/@type/string() )
  for  $doc at $i in $acc
  let $report:=$fn($doc)
  let $_:=qipe:log("validate: " || $i,$opts)
  
  return  
         if($report/status = "valid") then
             $doc
         else
           let $_:=trace($report,"validation errors")
           return  if($failOnError) then
                        error(xs:QName('qipe'), 
                        ' validation fails: ' || $i || "=" || base-uri($doc))
                   else
                       $doc
};

(:~  
 : run xquery referenced by @href and append result sequence to accumulator
 :)
declare function qipe:xquery($acc,$this  as element(qipe:xquery),$opts as map(*))
{
  let $href:=$this/@href/string()
  let $result:=xquery:invoke($href)
  return ($acc,$result)
};

(:~  
 : apply XSLT transform to each item in accumulator
 :)
declare function qipe:xslt($acc,$this  as element(qipe:xslt),$opts as map(*))
{
  let $href:=qipe:resolve($this/@href)
  for $d at $i in $acc
  let $_:=qipe:log("xslt: " || $i,$opts)
  return xslt:transform($d, $href)  
};

(:~  
 : store each item in accumulator at computed path
 :)
declare function qipe:store($acc,$this  as element(qipe:store),$opts as map(*))
{
  let $href:=qipe:resolve($this/@base)
  let $dated:=boolean($this/@dated)
  let $name:=$this/@fileExpression/string()
  let $eval:="declare variable $position external :=0; " || $name
  let $href:=$href || (if( $dated) then 
                          format-date(current-date(),"/[Y0001][M01][D01]") 
                       else 
                          ())
  
  return (
          if(file:exists($href)) then () else file:create-dir($href),
          for $item at $pos in $acc
          let $name:=xquery:eval($eval,
                                 map{"":$item,
                                     "position": $pos}) (:eval against doc:)
          let $dest:=$href || "/" || $name
          return ($dest,file:write($dest,$item))
        )
};

(:~  validate with xml-schema  :)
declare function qipe:validate-xsd($doc,$xsd )
as element(report)
{ 
  validate:xsd-report($doc,$xsd) 
};

(:~  validate with dtd  :)
declare function qipe:validate-dtd($doc,$dtd )
as element(report)
{ 
  validate:dtd-report($doc,$dtd) 
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
declare function qipe:load($acc,$this,$opts as map(*) )
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

(:~  log msg :)
declare function qipe:log($text as xs:string,$opts as map(*) )
as empty-sequence()
{ 
 if($opts?log) then
      admin:write-log(``[[`{ $opts?id }`] `{$text}`]``,"QIPE")
 else    
   ()        
};