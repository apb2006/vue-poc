import module namespace html5="text.html5" at "C:\Users\andy\git\vue-poc\src\vue-poc\lib\vue-compile\html5parse.xqm";

let $text:=fetch:text("C:\Users\andy\git\vue-poc\src\vue-poc\features\server\dicetest.vue")
let $text:=``[
<!DOCTYPE html>
<template id="dicetest">
  <v-abc >
 <template v-slot:default> 
 <thead>xxx</thead>
 </template >
  </v-abc>
  </template>
]``
let $doc:=html5:doc($text)
let $tempNode:= html5:getElementFirstByTagName($doc,"template")
let $template:= html5:getInnerHTML($tempNode)
let $id  := html5:getAttribute($tempNode,"id")=>trace("ID")
return $template