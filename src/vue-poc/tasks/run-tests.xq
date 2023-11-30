(:~ 
 : queue BaseX job to run XQuery unit tests in $dir. 
 : @return jobId 
 :)
declare variable $path external :="C:\Users\andy\git\qd-cmpx\src\test\tests.xqm";
declare variable $basex-jar external :="C:\Users\andy\basex.home\basex.933\BaseX.jar";
  
declare function local:queue-tests($dir as xs:string,$opts as map(*)){
 let $q:=``[
    declare variable  $password external;
    client:connect('localhost',
                   db:system()/globaloptions/port/xs:integer(.),
                   'admin',
                   $password)
   ! client:execute(.,'TEST `{$dir}`')
  ]``
  return job:eval($q,
                   map{"password":$opts?password},
                   map { 'cache': true()}
                 )
};

declare function local:run-tests($dir){
 let $args := ('-cp', $basex-jar, 'org.basex.BaseX', '-t', $path)
let $result := proc:system('java', $args)
return ($result) 
};
 local:run-tests($path)