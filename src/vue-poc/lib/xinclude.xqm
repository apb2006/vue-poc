(: from maillist :)
declare namespace xi = 'http://www.w3.org/2001/XInclude';
declare option db:xinclude 'false';

let $doc := doc('EV.xml') update {
  for $inc in .//xi:include
  let $id := replace($inc/@xpointer, '.*\(|\)', '')
  let $included-doc := doc($inc/@href)
  return replace node $inc with id($id, $included-doc)
}
return (
  $doc
  (: write to database...
  db:create('db', $doc, 'doc.xml') :)
  (: write back to file...
  file:write('doc.xml', $doc) :)
)