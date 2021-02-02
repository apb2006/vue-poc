(:
    In the URI authority, the order of all substrings separated by dots is reversed.
    Dots in the authority and the path are replaced by slashes. If no path exists, a single slash is appended.
    If the resulting string ends with a slash, the index string is appended.
    URI are required to have a path component.
    @see https://docs.basex.org/wiki/Java_Bindings#URI_Rewriting
:)
declare function local:rew($p){
  replace($p,"\.",":")
};

let $a:="http://expkg-zone58.github.io/ex-dotml"
return (
  Q{java:org.basex.util.Strings}uri2path($a),
for $r in repo:list()
let $r:= $r/@name/string()
return local:rew($r)
)
