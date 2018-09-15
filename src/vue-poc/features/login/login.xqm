(:~
 : Code for logging in and out.
 :
 :)
module namespace vue-login = 'vue-poc/login';
import module namespace session = "http://basex.org/modules/session";


(:~ Session key. :)
declare variable $vue-login:SESSION-KEY := "id";
(:~ Current session. :)
declare variable $vue-login:SESSION-VALUE := session:get($vue-login:SESSION-KEY);

(:~
 : get status
 :)
declare
%rest:GET %rest:path("/vue-poc/api/status")
%rest:produces("application/json")
%output:method("json")   
function vue-login:status( )   
{
let $user:=session:get("id","")
let $role:=if($user and user:exists($user)) then user:list-details($user)/@permission/string() else ""
return  <json   type="object" >
            <user>{ if($user) then $user else "guest" }</user>
            <permission>{$role}</permission>
            <session>{session:id()}</session>
            <created>{session:created()}</created>
  </json>
};

(:~
 : Checks the user input and redirects to the main page, or back to the login page.
 : @param  $name  user name
 : @param  $pass  password
 : @param  $path  path to redirect to (optional)
 : @return true/false
 :)
declare
  %rest:path("/vue-poc/api/login-check")
  %rest:form-param("username", "{$name}")
  %rest:form-param("password", "{$pass}")
  %rest:form-param("redirect", "{$path}")
%rest:produces("application/json")
%output:method("json")     
function vue-login:login(
  $name  as xs:string,
  $pass  as xs:string,
  $path as xs:string?) 
{
  try {
    user:check($name, $pass),
    if( user:list-details($name)/@permission ne "admin") then (
      vue-login:reject($name, 'Admin credentials required.', $path)
    ) else (
      vue-login:accept($name, $pass, $path)
    )
  } catch user:* {
    vue-login:reject($name, 'Please check your login data.', $path)
  }
};

(:~
 : Ends a session and redirects to the login page.
 : @return redirect
 :)
declare
  %rest:path("/vue-poc/api/logout")
function vue-login:logout(
) as element(rest:response) {
  session:close(),
  admin:write-log('vue-poc user was logged out: ' || $vue-login:SESSION-VALUE),
  web:redirect("/vue-poc/login", map { 'name': $vue-login:SESSION-VALUE })

};

(:~
 : Accepts a user and redirects to the main page.
 : @param  $name  entered user name
 : @param  $path  path to redirect to
 :)
declare %private function vue-login:accept(
  $name  as xs:string,
  $pass  as xs:string,
  $path  as xs:string?
) {
  let $expires:=current-dateTime() + xs:dayTimeDuration('P7D')
  let $pic:="[FNn,3-3],[D01] [MNn,3-3] [Y4] [H01]:[m01]:[s01] [z]"
  let $val:=``[remember=`{ random:uuid() }`; path=/; expires=`{ format-dateTime($expires,$pic) }`;]``
   return (
  session:set($vue-login:SESSION-KEY, $name),
  admin:write-log('VUEPOC user was logged in: ' || $name),
  
  <rest:response>
    <http:response>
       <http:header name="Set-Cookie" value="{ $val }"/> 
    </http:response>   
   </rest:response>, 
    
  <json type="object">
    <status type="boolean">true</status>
  </json>
  )
};

(:~
 : Rejects a user and redirects to the login page.
 : @param  $name     entered user name
 : @param  $message  error message
 : @param  $path     path to redirect to
 : @return json
 :)
declare %private function vue-login:reject(
  $name     as xs:string,
  $message  as xs:string,
  $path     as xs:string?) 
 as element(json) {
  admin:write-log('VUE login was denied: ' || $name),
  <json type="object">
    <status type="boolean">false</status>
    <message>{$message}</message>
  </json>
};
