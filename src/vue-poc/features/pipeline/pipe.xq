import module namespace qipe='http://quodatum.com/ns/pipeline' at "../../lib/pipeline.xqm" ;

declare namespace docinfo="http://www.lexis-nexis.com/glp/docinfo";
declare variable $base:="C:\Users\andy\Dropbox\job\lexisnexis.2\data\";
declare variable $src:="C:\Users\andy\Desktop\basex.versions\data\08s3\raw\";
declare function local:resolve($path,$base){
  file:resolve-path($path,$base)
};
let $ip:=file:list($src,false(), "*.xml")
let $ip:=subsequence($ip,1,10)!doc(concat($src,.))
let $d:=
<root xmlns="http://quodatum.com/ns/pipeline">
 <xslt href="{ local:resolve('08S3-to-rosetta-legdoc.xsl',$base) }"/>
 <validate href="{ local:resolve('legdoc-norm.dtd',$base) }" type="dtd" failOnError="true"/>
 <store base="c:\tmp\" fileExpression="'a' || $position || '.xml'" dated="true"/>
</root>

 return qipe:run($d,$ip)


