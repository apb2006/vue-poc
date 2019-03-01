(:~ set original:)
import module namespace cfg = "quodatum:media.image.configure" at "../config.xqm";

for $i in collection($cfg:DB-IMAGE || "/image")/image
where $i[file/@path=>contains('original')]
return  insert node attribute { 'original' } { true() } into $i