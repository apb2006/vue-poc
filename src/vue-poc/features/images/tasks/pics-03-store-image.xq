(:~ 
 : generate image docs from meta docs 52 sec 
 : <metadata/> -> <image/> 
 :)
import module namespace metadata = 'expkg-zone58:image.metadata';
import module namespace cfg = "quodatum:media.image.configure" at "../../../config.xqm";
for $meta in collection($cfg:DB-IMAGE || "/meta")/metadata
  let $loc:=db:path($meta)=>tokenize("/")
  let $name:=$loc[count($loc)-1]
  let $path:= subsequence($loc,2,count($loc)-2)=>string-join("/")
  let $image:=<image> 
             <file name="{$name}" path="{$path}"/>{
                metadata:core($meta),
                metadata:geo($meta),
                metadata:keywords($meta)
              } </image>
let $target:="image/"|| $path || "/image.xml"
return  db:replace($cfg:DB-IMAGE,$target=>trace(),$image)