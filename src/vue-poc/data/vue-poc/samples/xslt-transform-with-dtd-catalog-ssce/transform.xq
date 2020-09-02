
declare option db:catfile 'schemas/catalog.xml';
declare option db:intparse 'false';
declare option db:dtd 'true';
declare option db:chop 'false';

declare variable $input1 := file:resolve-path('input1.xml');
declare variable $xsl := file:resolve-path('transform.xsl');


'## parse with doc()',
doc('input1.xml'),
'## transform with XSLT',
try {
  (# db:catfile schemas/catalog.xml #)
  (# db:intparse false #)
  (# db:dtd true #)
  (# db:chop false #)
  { xslt:transform('input1.xml', 'transform.xsl')//inlinegraphic }
} catch * { $err:description }
