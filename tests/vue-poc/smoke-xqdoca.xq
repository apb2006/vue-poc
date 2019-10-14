(:
:)
import module namespace query-a = 'vue-poc/query-a' at 'C:\Users\andy\git\vue-poc\src\vue-poc\lib\query-a.xqm';

declare variable $q-uri:= "C:\Users\andy\git\xqdoca\src\main\xqdoca.xq";
let $opts:= map{"base-uri":"C:\Users\andy\git\xqdoca\src\main\xqdoca.xq"}
return query-a:run($q-uri, map{}, $opts)