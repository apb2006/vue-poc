(: entity access maps 
 : auto generated from xml files in entities folder at: 2017-07-17T17:47:26.588+01:00 
 :)

module namespace entity = 'quodatum.models.generated';
declare namespace c='http://www.w3.org/ns/xproc-step';
          
declare variable $entity:list:=map { 
  "thumbnail": map{
     "name": "thumbnail",
     "description": "an image.",
     "access": map{ 
       "id": function($_ as element()) as xs:integer {$_/db:node-id(.) },
       "name": function($_ as element()) as xs:string {$_/file/@name },
       "path": function($_ as element()) as xs:string {$_/file/@path },
       "size": function($_ as element()) as xs:integer {$_/0 } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/file/@name) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "id": function($_ as element()) as element(id)? {
            (: xs:integer :)
                        fn:data($_/db:node-id(.))!element id { attribute type {'number'}, .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/file/@name)!element name {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: xs:string :)
                        fn:data($_/file/@path)!element path {  .} 
                 },
           "size": function($_ as element()) as element(size)? {
            (: xs:integer :)
                        fn:data($_/0)!element size { attribute type {'number'}, .} 
                 } },
       
      "data": function() as element(image)*
       { collection("/vue-poc/Pictures")/image },
       
       "views": map{ 
       'filter': 'name'
       }
   }
};

 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){
  $entity:list($entity)("access")
}; 
  