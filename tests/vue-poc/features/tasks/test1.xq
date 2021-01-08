declare base-uri "../../../../src/vue-poc/"; 
(: test query-a.xqm with task :)
import module namespace query-a = 'vue-poc/query-a' at "lib/query-a.xqm";

declare variable $url:= "features/tasks/taskdef.xml";

declare variable $taskdef:= doc($url)/tasks/task[@name='import2'];
(: let $url:=resolve-uri($taskdef/@url,base-uri($taskdef)) :)
let $url:="C:\Users\andy\git\vue-poc\src\vue-poc\features\validate\tx-validate.xq"
let $url:="C:\Users\andy\git\vue-poc\src\vue-poc\features\tasks\task\test.xq"
let $info:= query-a:inspect($url)
let $v:= $info/values/*
let $f:=function($v){element {name($v)}{query-a:param-json($v/@type),string($v)}} 
return $info