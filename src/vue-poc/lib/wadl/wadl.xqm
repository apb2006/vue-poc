xquery version "3.1";
(:~
 : wadl tools..
 : 
 :)
module namespace  wadlx='http://quodatum.com/ns/wadl';

declare namespace wadl="http://wadl.dev.java.net/2009/02";

declare function wadlx:get(
		$wadl as element(wadl:application),
		$scope as xs:string?,
		$format as xs:string?
){

let $absolute:=function($path as xs:string){ concat(if (matches($path,"^/")) then "" else "/",$path)}
(: group by path :)
let $rg:=for $r in $wadl/wadl:resources/wadl:resource[matches(@path,"^" || $scope)]
         group by $p:=$absolute($r/@path)
         order by $p
        return element wadl:resource {attribute path {$p}, $r/*}
        
let $wadl:=  element wadl:application {
					  element wadl:resources {$wadl/wadl:resources/@base, $rg}
 					 }
 return if($format eq "html") 
        then 
           xslt:transform($wadl,"wadl.xsl")
        else
           $wadl
};