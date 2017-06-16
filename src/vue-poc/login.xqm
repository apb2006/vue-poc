(:~
 : Code for logging in and out.
 :
 :)
module namespace vue-login = 'vue-poc/login';

import module namespace Session = 'http://basex.org/modules/session';

(:~ Session key. :)
declare variable $vue-login:SESSION-KEY := "vue-poc";
(:~ Current session. :)
declare variable $vue-login:SESSION-VALUE := Session:get($vue-login:SESSION-KEY);

(:~
 : Checks the user input and redirects to the main page, or back to the login page.
 : @param  $name  user name
 : @param  $pass  password
 : @param  $path  path to redirect to (optional)
 : @return redirect
 :)
declare
  %rest:path("/vue-poc/api/login-check")
  %rest:form-param("username", "{$name}")
  %rest:form-param("password", "{$pass}")
function vue-login:login(
  $name  as xs:string,
  $pass  as xs:string
) as element(rest:response) {
  try {
    user:check($name, $pass),
    if(false() and user:list-details($name)/@permission ) then (
      vue-login:reject($name, 'Admin credentials required.', "$path")
    ) else (
      vue-login:accept($name, $pass, "$path")
    )
  } catch user:* {
    vue-login:reject($name, 'Please check your login data.', "$path")
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
  admin:write-log('vue-poc user was logged out: ' || $vue-login:SESSION-VALUE),
  web:redirect("/vue-poc/login", map { 'name': $vue-login:SESSION-VALUE }),
  Session:delete($vue-login:SESSION-KEY)
};

(:~
 : Accepts a user and redirects to the main page.
 : @param  $name  entered user name
 : @param  $path  path to redirect to
 : @return redirect
 :)
declare %private function vue-login:accept(
  $name  as xs:string,
  $pass  as xs:string,
  $path  as xs:string?
) {
  Session:set($vue-login:SESSION-KEY, $name),
  admin:write-log('VUEPOC user was logged in: ' || $name),
  web:redirect(if($path) then $path else "/")
};

(:~
 : Rejects a user and redirects to the login page.
 : @param  $name     entered user name
 : @param  $message  error message
 : @param  $path     path to redirect to
 : @return redirect
 :)
declare %private function vue-login:reject(
  $name     as xs:string,
  $message  as xs:string,
  $path     as xs:string?
) as element(rest:response) {
  admin:write-log('DBA login was denied: ' || $name),
  web:redirect("login", map { 'name': $name, 'error': $message, 'path': $path })
};
