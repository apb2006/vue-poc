(: clean tiddly images
:)
declare variable $SRC:="Z:\home\tiddly\quodatum\tiddlers\";

declare function local:decode($a){
  let $b:= analyze-string(trace($a),"%[\d][\d]") 
         transform with {
           for $m in fn:match
           return replace value of node $m with 
               bin:decode-string(bin:hex( substring($m,2))) 
        }
   return $b/string()
};

for $f in file:list($SRC,false())=>filter(function($f){contains($f,"%")})
let $d:=local:decode($f)
return file:move($SRC || $f,$SRC || $d)