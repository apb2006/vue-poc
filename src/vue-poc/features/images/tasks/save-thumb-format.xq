(:~  save in multiple formats  :)

import module namespace t="expkg-zone58:image.thumbnailator";

declare  namespace cfg = "quodatum:media.image.configure";

declare variable $cfg:IMAGEDIR:="P:/pictures/";

let $types:=("gif","jpg","png")
for $type in $types
let $task:=<thumbnail>
              <size width="100" height="100"/>
              <output format="{ $type }"/> 
            </thumbnail>
let $thumb:= file:resolve-path("Pictures/2002/05 may/2005/DSCF1313.JPG", $cfg:IMAGEDIR)
=>fetch:binary()
=>t:task($task)
return file:write-binary(``[c:\tmp\thumb.`{$type}`]``,$thumb)