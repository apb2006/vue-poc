import module namespace qipe='http://quodatum.com/ns/pipeline' at "../../lib/pipeline.xqm" ;

declare namespace docinfo="http://www.lexis-nexis.com/glp/docinfo";
declare variable $src:="C:\Users\BUNCEAX\Desktop\08s3\data\";

let $ip:=file:list($src,false(), "*.xml")
let $ip:=subsequence($ip,1,100)!doc(concat($src,.))
let $d:=
<root xmlns="http://quodatum.com/ns/pipeline">
<!--

  <xslt href="file:/C:/apb-git/sources/rosetta/EU/Regulatory/08S3/08S3-to-rosetta-legdoc.xsl"/>
 <validate href="C:\Users\BUNCEAX\Desktop\08s3\legdoc-norm.dtd" type="dtd" failOnError="true"/>
  -->
</root>

 return qipe:run($d,$ip) =>count()

