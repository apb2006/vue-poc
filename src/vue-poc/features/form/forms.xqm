module namespace page = 'quodatum.test.schema';


(:~
 :  get a schema
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/form/schema")
%output:method("json")   
function page:schema()
as element(json)
{
 let $s:="schema.json"
         =>resolve-uri(static-base-uri())
         =>fetch:text()
         =>json:parse()
  return $s/*
};

