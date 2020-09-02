import module namespace html5="text.html5" at "html5parse.xqm";
(:~
 : parse a vue file to extract template and script
 : @return  map{"id":$id,"template":$template,"script":$script}
 :)
declare function local:parse($doc)
as map(*)
{
  let $tempNode:= html5:getElementFirstByTagName($doc,"template")
  let $template:= html5:getInnerHTML($tempNode)
  let $id  := html5:getAttribute($tempNode,"id")=>trace("ID")

  let $script:= html5:getElementFirstByTagName($doc,"script")
  let $script:= html5:getInnerHTML($script)
  return map{"id":$id,"template":$template,"script":$script}
};
declare variable $src:="C:\Users\andy\git\vue-poc\src\vue-poc\features\eval\eval.vue";

let $p:=$src
=>file:read-text()
=>html5:doc()
=>local:parse()
return  $p?template