(:~
 : task
 :)
module namespace vue-rest = 'quodatum:vue.rest';


(:~
 : run compile task.
 :)
declare
%rest:POST %rest:path("/vue-poc/api/tasks/task")
%rest:form-param("name", "{$name}")
%rest:produces("application/json")
%output:method("json")
%updating   
function vue-rest:vue($name)   
{
  db:output(<json type="object"><msg> { $name }.</msg></json>)
};
  
(:~
: new app
:)
declare function vue-rest:new($name as xs:string){
    let $archive:=file:read-binary(fn:resolve-uri('./data/vuetif.zip'))
   let $contents := archive:extract-binary($archive)
   let $entries:= archive:entries($archive)
   (: update paths :)
   let $entries:=$entries!fn:replace(.,'vuetif',$name)
   let $contents:=$contents!vue-rest:update-extract(.,'[Vv]uetif',$name)

   return archive:create($entries,$contents)
};

(:~ 
 : test for text
 : @see http://stackoverflow.com/questions/2644938/how-to-tell-binary-from-text-files-in-linux
 :) 
declare function vue-rest:is-text($b as xs:base64Binary )
as xs:boolean{
    fn:empty(bin:find($b, 0,bin:hex("00")))
};

(:~ 
 : if context is text replace string else return unchanged
 :) 
declare function vue-rest:update-extract($extract as xs:base64Binary,
                                $from as xs:string,
                                $to as xs:string )
as xs:base64Binary{
  if(vue-rest:is-text($extract))
  then try{
  (: escape chars etc :)
    let $t:=convert:binary-to-string($extract)
    let $t:=fn:replace($t,$from,$to)
    return convert:string-to-base64($t)
    } catch * {
    $extract
    }
  else 
    $extract
};
  