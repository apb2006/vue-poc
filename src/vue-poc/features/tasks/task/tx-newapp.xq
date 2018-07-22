(:~ 
: create new app
: @author andy bunce
: @since july 2018
:)

(:~ 
 : name of the app to create
 : @default myapp
 :)
declare variable $name as xs:string  external :="myapp";


(:~
: new app
:)
declare function local:new($name as xs:string){
    let $archive:=file:read-binary(fn:resolve-uri('./data/vuetif.zip'))
   let $contents := archive:extract-binary($archive)
   let $entries:= archive:entries($archive)
   (: update paths :)
   let $entries:=$entries!fn:replace(.,'vuetif',$name)
   let $contents:=$contents!local:update-extract(.,'[Vv]uetif',$name)

   return archive:create($entries,$contents)
};

(:~ 
 : test for text
 : @see http://stackoverflow.com/questions/2644938/how-to-tell-binary-from-text-files-in-linux
 :) 
declare function local:is-text($b as xs:base64Binary )
as xs:boolean{
    fn:empty(bin:find($b, 0,bin:hex("00")))
};

(:~ 
 : if context is text replace string else return unchanged
 :) 
declare function local:update-extract($extract as xs:base64Binary,
                                $from as xs:string,
                                $to as xs:string )
as xs:base64Binary{
  if(local:is-text($extract))
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
 
update:output(<json type="object"><msg> { $name }.</msg></json>)  