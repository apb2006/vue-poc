xquery version "3.1";
(:~
 :  get basex settings default and current
 :)
module namespace set = 'quodatum.test.basexsettings';


declare   
%rest:GET %rest:path("/vue-poc/api/server/basexsettings")
%rest:produces("application/json")
%output:method("json") 
function set:values()
{
  let $defaults:=doc("basexsettings-921.xml")//*[not(*)]
  let $dm:=map:merge($defaults!map:entry(name(.),string(.)))
  let $settings:=db:system()//*[not(*)]
  let $sm:=map:merge($settings!map:entry(name(.),string(.)))
  let $names:=distinct-values((map:keys( $dm),map:keys($sm)))=>sort()
 return <json type="array">
{for $name in $names 
let $change:=$dm($name) ne $sm($name)
return <_ type="object">
            <name>{$name}</name>
            <default>{$dm($name)}</default>
            <current>{$sm($name)}</current>
            <changed type="boolean">{ if ($change) then $change else false() }</changed>
        </_>}
 </json>
};

declare   
%rest:GET %rest:path("/vue-poc/api/server/basexsettings2")
%rest:produces("application/json")
%output:method("json") 
function set:values2()
{
  let $defaults:=doc("basexsettings-921.xml")//*[not(*)]
  let $dm:=map:merge($defaults!map:entry(name(.),string(.)))
  let $settings:=db:system()//*[not(*)]
  let $sm:=map:merge($settings!map:entry(name(.),string(.)))
  let $names:=distinct-values((map:keys( $dm),map:keys($sm)))=>sort()
 return <json type="object">
     <items type="array">
		{for $name in $names 
		let $change:=$dm($name) ne $sm($name)
		return <_ type="object">
		            <name>{$name}</name>
		            <default>{$dm($name)}</default>
		            <current>{$sm($name)}</current>
		            <changed type="boolean">{ if ($change) then $change else false() }</changed>
		        </_>}
     </items>
 </json>
};
