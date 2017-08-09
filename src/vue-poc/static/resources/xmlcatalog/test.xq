declare variable $dir-uri as xs:string external := string(inspect:static-context((),'base-uri'));
doc('http://transpect.io/test/test.xml'),
xslt:transform(resolve-uri('test.xml', $dir-uri), resolve-uri('importing.xsl', $dir-uri))