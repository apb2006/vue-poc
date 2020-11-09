(:~
 : resolve uri tools supports protocols:  "xmldb"  "webfile"
 result map{
    "protocol": one of "file", "xmldb"
     "uri":  
     "fnGet": function#0 to get
     } 
 @since Sept 2020
 @author Andy Bunce
 @copyright Quodatum Ltd
 @version 0.0.4  
 :)
module namespace  resolve = 'urn:quodatum:resolve';
import module namespace web = 'http://basex.org/modules/web';

(:~
 : 
 :)
declare function resolve:uri($uri as xs:string)
as map(*){
  let $t:=tokenize($uri,':')
  let $protocol:= if(count($t) gt 1 ) then head($t) else ()
  let $isDrive:= matches($protocol,"^[A-Za-z]$")
  let $path:= tail($t)=>string-join(":")
  let $uri:=switch ($protocol)
            case "webfile"
                  return let $webroot:=db:system()/globaloptions/webpath/string()
                         return concat($webroot,$path)
           case  "xmldb"
                return  $path
                  
           case "file"
                  return web:decode-url($path)=>replace("^//*","")=>replace("/","\" || file:dir-separator())
           default 
                 return if ($isDrive) then $uri else $path
                           
  let $protocol:= switch (true())
                case $isDrive
                    return "file"
                    
                case $protocol = "webfile"
                    return "file"
                    
                default 
                     return $protocol
                   
  let $getfn:= switch ($protocol) 
			   case "xmldb" 
			         return function(){ doc($uri)}
			         
			   default 
			       return function(){ fetch:text($uri)}
				   
  return map{
     "protocol": $protocol,
     "uri": $uri,
     "isDrive": $isDrive,
     "fnGet": $getfn
  }
};

declare function resolve:meta($uri )
as map(*){
let $uri:=resolve:analyse($uri)
let $size:=50
return map:merge(($uri,map{"size": $size}))          
};


declare function resolve:analyse($uri) 
as map(*){
  typeswitch($uri)
  case map(*) return $uri
  case xs:string return resolve:uri($uri)
  default return error(xs:QName("resolve:analyse"),"type not supported")
};

declare function resolve:special($uri as xs:string) 
as xs:string{
 let $webroot:=db:system()/globaloptions/webpath/string()
 let $_:=trace(($uri,$webroot),"special")
 return $uri
};
