(: entity access maps 
 : auto generated from xml files in entities folder at: 2018-07-31T22:46:52.921+01:00 
 :)

module namespace entity = 'quodatum.models.generated';
import module namespace cfg = "quodatum:media.image.configure" at "config.xqm";declare namespace ent='https://github.com/Quodatum/app-doc/entity';
declare namespace h='urn:quodatum:vue-poc.history';
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
  "entity.field": map{
     "name": "entity.field",
     "description": "About an entity field. ",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/ent:description },
       "name": function($_ as element()) as xs:string {$_/@name },
       "parent": function($_ as element()) as xs:string {$_/../../@name },
       "type": function($_ as element()) as xs:string {$_/@type },
       "xpath": function($_ as element()) as xs:string {$_/ent:xpath } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/@name, $item/ent:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/ent:description)!element description {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "parent": function($_ as element()) as element(parent)? {
            (: xs:string :)
                        fn:data($_/../../@name)!element parent {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "xpath": function($_ as element()) as element(xpath)? {
            (: xs:string :)
                        fn:data($_/ent:xpath)!element xpath {  .} 
                 } },
       
      "data": function() as element(ent:field)*
       { collection("doc-doc")//ent:field },
       
       "views": map{ 
       'filter': 'name description'
       }
   },
  "entity": map{
     "name": "entity",
     "description": "About an entity i.e. something described in this framework
	",
     "access": map{ 
       "code": function($_ as element()) as xs:string? {$_/ent:data },
       "description": function($_ as element()) as xs:string {$_/ent:description },
       "fieldslink": function($_ as element()) as xs:string {$_/fn:concat("/data/entity/",@name,"/field") },
       "iconclass": function($_ as element()) as xs:string {$_/ent:views/@iconclass },
       "modules": function($_ as element()) as xs:string? {$_/ent:module/concat("import module namespace ",@prefix,"='",@namespace,"';
")=>string-join() },
       "name": function($_ as element()) as xs:string {$_/@name },
       "namespaces": function($_ as element()) as xs:string? {$_/ent:namespace/concat("declare namespace ",@prefix,"='",@uri,"';
")=>string-join() },
       "nfields": function($_ as element()) as xs:integer {$_/fn:count(ent:fields/ent:field) },
       "parent": function($_ as element()) as xs:string? {$_/ent:parent/@name },
       "parentlink": function($_ as element()) as xs:string? {$_/fn:concat("/data/entity/",ent:parent/@name) },
       "type": function($_ as element()) as xs:string {$_/ent:data/@type } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/@name, $item/ent:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "code": function($_ as element()) as element(code)? {
            (: xs:string? :)
                        fn:data($_/ent:data)!element code {  .} 
                 },
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/ent:description)!element description {  .} 
                 },
           "fieldslink": function($_ as element()) as element(fieldslink)? {
            (: xs:string :)
                        fn:data($_/fn:concat("/data/entity/",@name,"/field"))!element fieldslink {  .} 
                 },
           "iconclass": function($_ as element()) as element(iconclass)? {
            (: xs:string :)
                        fn:data($_/ent:views/@iconclass)!element iconclass {  .} 
                 },
           "modules": function($_ as element()) as element(modules)? {
            (: xs:string? :)
                        fn:data($_/ent:module/concat("import module namespace ",@prefix,"='",@namespace,"';
")=>string-join())!element modules {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "namespaces": function($_ as element()) as element(namespaces)? {
            (: xs:string? :)
                        fn:data($_/ent:namespace/concat("declare namespace ",@prefix,"='",@uri,"';
")=>string-join())!element namespaces {  .} 
                 },
           "nfields": function($_ as element()) as element(nfields)? {
            (: xs:integer :)
                        fn:data($_/fn:count(ent:fields/ent:field))!element nfields { attribute type {'number'}, .} 
                 },
           "parent": function($_ as element()) as element(parent)? {
            (: xs:string? :)
                        fn:data($_/ent:parent/@name)!element parent {  .} 
                 },
           "parentlink": function($_ as element()) as element(parentlink)? {
            (: xs:string? :)
                        fn:data($_/fn:concat("/data/entity/",ent:parent/@name))!element parentlink {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/ent:data/@type)!element type {  .} 
                 } },
       
      "data": function() as element(ent:entity)*
       { collection("vue-poc")//ent:entity },
       
       "views": map{ 
       'filter': 'name description'
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
  "jobrun": map{
     "name": "jobrun",
     "description": "About the running of a job",
     "access": map{ 
       "created": function($_ as element()) as xs:string {$_/json/dateTime },
       "id": function($_ as element()) as xs:string {$_/@id },
       "job": function($_ as element()) as xs:string {$_/json/job },
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
                        fn:data($_/json/dateTime)!element created {  .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: xs:string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "job": function($_ as element()) as element(job)? {
            (: xs:string :)
                        fn:data($_/json/job)!element job {  .} 
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
       
      "data": function() as element(jobrun)*
       { collection("vue-poc/jobrun")/jobrun
	 },
       
       "views": map{ 
       'filter': 'name description'
       }
   },
  "namespace": map{
     "name": "namespace",
     "description": "An XML namespace",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/description },
       "prefix": function($_ as element()) as xs:string {$_/@prefix },
       "xmlns": function($_ as element()) as xs:string {$_/@uri } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/@uri, $item/description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/description)!element description {  .} 
                 },
           "prefix": function($_ as element()) as element(prefix)? {
            (: xs:string :)
                        fn:data($_/@prefix)!element prefix {  .} 
                 },
           "xmlns": function($_ as element()) as element(xmlns)? {
            (: xs:string :)
                        fn:data($_/@uri)!element xmlns {  .} 
                 } },
       
      "data": function() as element(namespace)*
       { collection("vue-poc")/namespaces/namespace
	 },
       
       "views": map{ 
       'filter': 'xmlns description'
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
       "geo": function($_ as element()) as xs:boolean {$_/boolean(geo) },
       "height": function($_ as element()) as xs:integer {$_/height },
       "id": function($_ as element()) as xs:integer {$_/db:node-id(.) },
       "keywords": function($_ as element()) as xs:integer {$_/count(keywords/keyword) },
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
                        fn:data($_/boolean(geo))!element geo { attribute type {'boolean'}, .} 
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
                        fn:data($_/count(keywords/keyword))!element keywords { attribute type {'number'}, .} 
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
   },
  "user": map{
     "name": "user",
     "description": "A BaseX user ",
     "access": map{ 
       "name": function($_ as element()) as xs:string {$_/@name },
       "permission": function($_ as element()) as xs:string {$_/@permission } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "permission": function($_ as element()) as element(permission)? {
            (: xs:string :)
                        fn:data($_/@permission)!element permission {  .} 
                 } },
       
      "data": function() as element(user)*
       { user:list-details() },
       
       "views": map{ 
       
       }
   },
  "xqdoc": map{
     "name": "xqdoc",
     "description": "XQuery documentation set ",
     "access": map{ 
       "root": function($_ as element()) as xs:string {$_/@root },
       "time": function($_ as element()) as xs:string {$_/@time } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "root": function($_ as element()) as element(root)? {
            (: xs:string :)
                        fn:data($_/@root)!element root {  .} 
                 },
           "time": function($_ as element()) as element(time)? {
            (: xs:string :)
                        fn:data($_/@time)!element time {  .} 
                 } },
       
      "data": function() as element(entry)*
       { () },
       
       "views": map{ 
       
       }
   }
};

 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){
  $entity:list($entity)("access")
}; 
  