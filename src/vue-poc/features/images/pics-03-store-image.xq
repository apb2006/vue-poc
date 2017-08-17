(:~ 
 : generate image docs from meta docs 52 sec 
 : <metadata/> -> <image/> 
 :)
import module namespace metadata = 'expkg-zone58:image.metadata';
import module namespace cfg = "quodatum:media.image.configure" at "config.xqm";
for $meta in collection("/vue-poc/Pictures")/metadata
  let $loc:=db:path($meta)=>tokenize("/")
  let $name:=$loc[count($loc)-1]
  let $path:= subsequence($loc,1,count($loc)-1)=>string-join("/")
  let $image:=<image> 
             <file name="{$name}" path="{$path}"/>{
                metadata:core($meta),
                metadata:geo($meta),
                metadata:keywords($meta)
              } </image>
let $target:=$path || "/image.xml"
return db:replace("vue-poc",$target,$image)