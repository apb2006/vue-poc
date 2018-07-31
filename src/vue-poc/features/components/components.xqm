module namespace j = 'quodatum.test.components';


declare function j:tax($items){
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
 :  tree
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

