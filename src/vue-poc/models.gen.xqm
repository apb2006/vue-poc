(: entity access maps 
 : auto generated from xml files in entities folder at: 2017-08-09T12:18:41.183+01:00 
 :)

module namespace entity = 'quodatum.models.generated';
declare namespace h='urn:quodatum:vue-poc.history';
declare namespace c='http://www.w3.org/ns/xproc-step';
          
declare variable $entity:list:=map { 
  "basexlog": map{
     "name": "basexlog",
     "description": "BaseX log entry ",
     "access": map{ 
       "address": function($_ as element()) as xs:string {$_/@address },
       "ms": function($_ as element()) as xs:integer {$_/@ms },
       "text": function($_ as element()) as xs:string {$_/. },
       "time": function($_ as element()) as xs:string {$_/@time },
       "type": function($_ as element()) as xs:string {$_/@type },
       "user": function($_ as element()) as xs:string {$_/@user } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "address": function($_ as element()) as element(address)? {
            (: xs:string :)
                        fn:data($_/@address)!element address {  .} 
                 },
           "ms": function($_ as element()) as element(ms)? {
            (: xs:integer :)
                        fn:data($_/@ms)!element ms { attribute type {'number'}, .} 
                 },
           "text": function($_ as element()) as element(text)? {
            (: xs:string :)
                        fn:data($_/.)!element text {  .} 
                 },
           "time": function($_ as element()) as element(time)? {
            (: xs:string :)
                        fn:data($_/@time)!element time {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "user": function($_ as element()) as element(user)? {
            (: xs:string :)
                        fn:data($_/@user)!element user {  .} 
                 } },
       
      "data": function() as element(entry)*
       { hof:top-k-by(admin:logs(), hof:id#1, 2)/string()!reverse(admin:logs(.,true())) },
       
       "views": map{ 
       
       }
   },
  "filehistory": map{
     "name": "filehistory",
     "description": "vue-poc file view events ",
     "access": map{ 
       "created": function($_ as element()) as xs:string {$_/@when },
       "id": function($_ as element()) as xs:string {$_/@id },
       "protocol": function($_ as element()) as xs:string {$_/h:file/@mode },
       "url": function($_ as element()) as xs:string {$_/h:file/@url },
       "user": function($_ as element()) as xs:string {$_/@user } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "created": function($_ as element()) as element(created)? {
            (: xs:string :)
                        fn:data($_/@when)!element created {  .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: xs:string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "protocol": function($_ as element()) as element(protocol)? {
            (: xs:string :)
                        fn:data($_/h:file/@mode)!element protocol {  .} 
                 },
           "url": function($_ as element()) as element(url)? {
            (: xs:string :)
                        fn:data($_/h:file/@url)!element url {  .} 
                 },
           "user": function($_ as element()) as element(user)? {
            (: xs:string :)
                        fn:data($_/@user)!element user {  .} 
                 } },
       
      "data": function() as element(h:event)*
       { doc("history.xml")/h:history/h:event },
       
       "views": map{ 
       
       }
   },
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
  