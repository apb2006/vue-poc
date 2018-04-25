(:~
 : vue-poc application.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-poc = 'quodatum:vue.poc';
declare variable $vue-poc:index:=resolve-uri ('static/' || "app.html",fn:static-base-uri() );

(:~
 : Redirects to the start page.
 :)
declare
%rest:path("/vue-poc")
function vue-poc:redirect() 
as element(rest:response) 
{
  web:redirect("/vue-poc/ui")
};

(:~ display home page :) 
declare 
%rest:GET %rest:path("/vue-poc/ui")
function vue-poc:main()
{
  vue-poc:get-file("app.html")
};

(:~
 : Returns a file.
 : @param  $file  file or unknown path
 : @return rest response and binary file
 :)
declare
%rest:path("/vue-poc/ui/{$file=.+}")
function vue-poc:file(
  $file as xs:string
) as item()+ 
{
   vue-poc:get-file($file)
};


(:~
 :web serve $file if it exists otherwise serve $vue-poc:index
 :)
declare function vue-poc:get-file($file)
{
  let $path := resolve-uri( 'static/' || $file,static-base-uri())
  let $path:=if(file:exists($path))then $path else ($vue-poc:index,prof:dump($path," Not found"))
  return (
    web:response-header(map { 'media-type': vue-poc:content-type($path) }),
    file:read-binary($path)
  )
};

(:~ 
 : content type for path 
 :)
declare function vue-poc:content-type($path as xs:string) 
as xs:string
{
 let $ct:=web:content-type($path)
 return if($ct = "text/ecmascript") then "text/javascript" else $ct
};

(:~ unused
 :)
declare function vue-poc:get-filex($file)
{
  let $path := resolve-uri( 'static/' || $file,static-base-uri())
  return 
    
    try{
    (web:response-header(map { 'media-type': web:content-type($path) }),
    fetch:binary($path))
    }catch * {
      (web:response-header(map { 'media-type': web:content-type($vue-poc:index) }),
    fetch:binary($vue-poc:index))
    }
};
