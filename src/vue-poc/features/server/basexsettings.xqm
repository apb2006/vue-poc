module namespace set = 'quodatum.test.basexsettings';

(:~
 :  basex settings default and current
 :)
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
{for $name in $names return <_ type="object">
                                <name>{$name}</name>
                                <default>{$dm($name)}</default>
                                <current>{$sm($name)}</current>
                                <changed type="boolean">{$dm($name) ne $sm($name)}</changed>
                            </_>}
 </json>
};

