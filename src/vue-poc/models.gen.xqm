(: entity access maps 
 : auto generated from xml files in entities folder at: 2017-09-17T13:41:02.538+01:00 
 :)

module namespace entity = 'quodatum.models.generated';
import module namespace cfg = "quodatum:media.image.configure" at "features/images/config.xqm";declare namespace h='urn:quodatum:vue-poc.history';
declare namespace xqdoc='http://www.xqdoc.org/1.0';
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
       { doc("vue-poc/history.xml")/h:history/h:event[h:file] },
       
       "views": map{ 
       
       }
   },
  "query": map{
     "name": "query",
     "description": "An replx query",
     "access": map{ 
       "created": function($_ as element()) as xs:string {$_/created },
       "id": function($_ as element()) as xs:string {$_/@id },
       "query": function($_ as element()) as xs:string {$_/query },
       "result": function($_ as element()) as xs:string {$_/substring(result,0,1000) },
       "resultlength": function($_ as element()) as xs:integer {$_/string-length(result) } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "created": function($_ as element()) as element(created)? {
            (: xs:string :)
                        fn:data($_/created)!element created {  .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: xs:string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "query": function($_ as element()) as element(query)? {
            (: xs:string :)
                        fn:data($_/query)!element query {  .} 
                 },
           "result": function($_ as element()) as element(result)? {
            (: xs:string :)
                        fn:data($_/substring(result,0,1000))!element result {  .} 
                 },
           "resultlength": function($_ as element()) as element(resultlength)? {
            (: xs:integer :)
                        fn:data($_/string-length(result))!element resultlength { attribute type {'number'}, .} 
                 } },
       
      "data": function() as element(query)*
       { collection("replx/queries")/query
	 },
       
       "views": map{ 
       'filter': 'name description'
       }
   },
  "search-result": map{
     "name": "search-result",
     "description": "About a search result.",
     "access": map{ 
       "sref": function($_ as element()) as xs:string {$_/"app.item.index({'name':'benchx'})" },
       "title": function($_ as element()) as xs:string {$_/title },
       "type": function($_ as element()) as xs:string {$_/type },
       "uri": function($_ as element()) as xs:string {$_/uri } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "sref": function($_ as element()) as element(sref)? {
            (: xs:string :)
                        fn:data($_/"app.item.index({'name':'benchx'})")!element sref {  .} 
                 },
           "title": function($_ as element()) as element(title)? {
            (: xs:string :)
                        fn:data($_/title)!element title {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/type)!element type {  .} 
                 },
           "uri": function($_ as element()) as element(uri)? {
            (: xs:string :)
                        fn:data($_/uri)!element uri {  .} 
                 } },
       
      "data": function() as element(search)*
       { () },
       
       "views": map{ 
       
       }
   },
  "thumbnail": map{
     "name": "thumbnail",
     "description": "an image.",
     "access": map{ 
       "geo": function($_ as element()) as xs:boolean {$_/geo },
       "height": function($_ as element()) as xs:integer {$_/height },
       "id": function($_ as element()) as xs:integer {$_/db:node-id(.) },
       "keywords": function($_ as element()) as xs:integer {$_/0 },
       "name": function($_ as element()) as xs:string {$_/file/@name },
       "path": function($_ as element()) as xs:string {$_/file/@path },
       "size": function($_ as element()) as xs:integer {$_/0 },
       "width": function($_ as element()) as xs:integer {$_/width } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/file/@name) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "geo": function($_ as element()) as element(geo)? {
            (: xs:boolean :)
                        fn:data($_/geo)!element geo { attribute type {'boolean'}, .} 
                 },
           "height": function($_ as element()) as element(height)? {
            (: xs:integer :)
                        fn:data($_/height)!element height { attribute type {'number'}, .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: xs:integer :)
                        fn:data($_/db:node-id(.))!element id { attribute type {'number'}, .} 
                 },
           "keywords": function($_ as element()) as element(keywords)? {
            (: xs:integer :)
                        fn:data($_/0)!element keywords { attribute type {'number'}, .} 
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
                 },
           "width": function($_ as element()) as element(width)? {
            (: xs:integer :)
                        fn:data($_/width)!element width { attribute type {'number'}, .} 
                 } },
       
      "data": function() as element(image)*
       { collection($cfg:DB-IMAGE || "/image")/image },
       
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
  