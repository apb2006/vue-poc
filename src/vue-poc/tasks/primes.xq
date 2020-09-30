(:~
 : performance test
 :)
 
 (:~ calculate primes upto
 : @default 100000
 :)
declare variable $MAX as xs:integer  external:= 100000;

declare function local:go(){
for $i in (2 to $MAX) 
return if (every $j in (2 to $i - 1) satisfies $i mod $j ne 0) 
       then $i 
       else ()
};
local:go()=>count()=>update:output()