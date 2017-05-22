(:~
 : vue-poc application.
 :
 : @author Andy Bunce may-2017
 :)
module namespace vue-poc = 'quodatum:vue.poc';
declare variable $vue-poc:index:=file:base-dir() || 'static/' || "app.html";

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



declare function vue-poc:get-file($file)
{
  let $path := file:base-dir() || 'static/' || $file
  let $path:=if(file:exists($path))then $path else $vue-poc:index
       
  return (
    web:response-header(map { 'media-type': web:content-type($path) }),
    file:read-binary($path)
  )
};