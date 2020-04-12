(:~
 : support tree view
 : @author apb
 : @exampletag some value
 :)
module namespace j = 'quodatum.test.components';

(:~
 : id:, label:,children:
 : @return sequence of json array items for each item 
 :)
declare function j:tax($items)
as element(_)*
{
 for $a in $items
return <_ type="object">
    <id>{$a/@id/string()}</id>
    <label>{$a/@label/string()}</label>
    {if($a/item)then (
       <children type="array">{j:tax($a/item)}</children>
       ,<icon></icon>
      ) else (
        <icon>fa fa-tag</icon>
      )}
</_> 
};



(:~
 :  sample tree data as json
 : source balisage-taxonomy.xml
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/components/tree")
%output:method("json")   
function j:tree()
as element(json)
{
let $d:=doc(resolve-uri("balisage-taxonomy.xml",static-base-uri()))/tax/item
return
<json type="array">
{j:tax($d)}
</json>
};

(:~
 :  serve sample markdown from "md-sample.md"
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/components/markdown")
%output:method("text")  
function j:markdown()
as xs:string
{
let $uri:=resolve-uri("md-sample.md",static-base-uri())
return fn:unparsed-text($uri)
};
