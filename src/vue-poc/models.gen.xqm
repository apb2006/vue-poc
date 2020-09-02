(: entity access maps 
 : auto generated from xml files in entities folder at: 2020-07-08T23:08:03.678+01:00 
 :)

module namespace entity = 'quodatum.models.generated';
import module namespace cfg = "quodatum:media.image.configure" at "features/images/config.xqm";declare namespace ent='https://github.com/Quodatum/app-doc/entity';
declare namespace h='urn:quodatum:vue-poc.history';
declare namespace xqdoc='http://www.xqdoc.org/1.0';
declare namespace qns='https://github.com/Quodatum/namespaces';
declare namespace c='http://www.w3.org/ns/xproc-step';
          
declare variable $entity:list:=map { 
  "basex.job": map{
     "name": "basex.job",
     "description": "Active BaseX jobs on the server. From jobs:list-details",
     "access": map{ 
       "duration": function($_ as element()) as xs:string {$_/@duration },
       "id": function($_ as element()) as xs:string {$_/@id },
       "interval": function($_ as element()) as xs:string {$_/@interval },
       "reads": function($_ as element()) as xs:string {$_/@reads },
       "registered": function($_ as element()) as xs:string {$_/@time },
       "start": function($_ as element()) as xs:string {$_/@start },
       "state": function($_ as element()) as xs:string {$_/@state },
       "text": function($_ as element()) as xs:string {$_/. },
       "type": function($_ as element()) as xs:string {$_/@type },
       "user": function($_ as element()) as xs:string {$_/@user },
       "writes": function($_ as element()) as xs:string {$_/@writes } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "duration": function($_ as element()) as element(duration)? {
            (: xs:string :)
                        fn:data($_/@duration)!element duration {  .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: xs:string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "interval": function($_ as element()) as element(interval)? {
            (: xs:string :)
                        fn:data($_/@interval)!element interval {  .} 
                 },
           "reads": function($_ as element()) as element(reads)? {
            (: xs:string :)
                        fn:data($_/@reads)!element reads {  .} 
                 },
           "registered": function($_ as element()) as element(registered)? {
            (: xs:string :)
                        fn:data($_/@time)!element registered {  .} 
                 },
           "start": function($_ as element()) as element(start)? {
            (: xs:string :)
                        fn:data($_/@start)!element start {  .} 
                 },
           "state": function($_ as element()) as element(state)? {
            (: xs:string :)
                        fn:data($_/@state)!element state {  .} 
                 },
           "text": function($_ as element()) as element(text)? {
            (: xs:string :)
                        fn:data($_/.)!element text {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "user": function($_ as element()) as element(user)? {
            (: xs:string :)
                        fn:data($_/@user)!element user {  .} 
                 },
           "writes": function($_ as element()) as element(writes)? {
            (: xs:string :)
                        fn:data($_/@writes)!element writes {  .} 
                 } },
       
      "data": function() as element(job)*
       { jobs:list()[. != jobs:current()] !jobs:list-details(.)=>reverse()
	 },
       
       "views": map{ 
       'filter': 'name description'
       }
   },
  "basex.log": map{
     "name": "basex.log",
     "description": "BaseX log entries for today and yesterday from the running server",
     "access": map{ 
       "address": function($_ as element()) as xs:string {$_/@address },
       "ms": function($_ as element()) as xs:integer {$_/@ms },
       "text": function($_ as element()) as xs:string {$_/. },
       "time": function($_ as element()) as xs:string {$_/concat(@date,@date!'T',@time) },
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
                        fn:data($_/concat(@date,@date!'T',@time))!element time {  .} 
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
       { 
let $add-date:=function($logs as element(*)*,$d as xs:string){
    $logs!(. transform with { insert node attribute date {$d} into .})
}

return 
hof:top-k-by(admin:logs(), string#1, 2)  
!(reverse(admin:logs(.,true()))=>$add-date(.))
	 },
       
       "views": map{ 
       
       }
   },
  "basex.repo": map{
     "name": "basex.repo",
     "description": "Packages installed in the BaseX repository",
     "access": map{ 
       "name": function($_ as element()) as xs:string {$_/@name },
       "type": function($_ as element()) as xs:string {$_/@type },
       "version": function($_ as element()) as xs:string {$_/@version } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "version": function($_ as element()) as element(version)? {
            (: xs:string :)
                        fn:data($_/@version)!element version {  .} 
                 } },
       
      "data": function() as element(package)*
       { repo:list() },
       
       "views": map{ 
       
       }
   },
  "basex.service": map{
     "name": "basex.service",
     "description": "basex services. A list of all jobs that have been persistently registered as Services.",
     "access": map{ 
       "base-uri": function($_ as element()) as xs:string {$_/@base-uri },
       "id": function($_ as element()) as xs:string {$_/@id },
       "interval": function($_ as element()) as xs:string {$_/@interval },
       "query": function($_ as element()) as xs:string {$_/. },
       "running": function($_ as element()) as xs:boolean {$_/(@id = jobs:list-details()/@id) } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "base-uri": function($_ as element()) as element(base-uri)? {
            (: xs:string :)
                        fn:data($_/@base-uri)!element base-uri {  .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: xs:string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "interval": function($_ as element()) as element(interval)? {
            (: xs:string :)
                        fn:data($_/@interval)!element interval {  .} 
                 },
           "query": function($_ as element()) as element(query)? {
            (: xs:string :)
                        fn:data($_/.)!element query {  .} 
                 },
           "running": function($_ as element()) as element(running)? {
            (: xs:boolean :)
                        fn:data($_/(@id = jobs:list-details()/@id))!element running { attribute type {'boolean'}, .} 
                 } },
       
      "data": function() as element(job)*
       { jobs:services() },
       
       "views": map{ 
       
       }
   },
  "basex.user": map{
     "name": "basex.user",
     "description": "BaseX users ",
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
       { collection("doc-doc")/ent:entity/ent:fields/ent:field },
       
       "views": map{ 
       'filter': 'name description'
       }
   },
  "entity": map{
     "name": "entity",
     "description": "List of Entities i.e. things described in this framework
	",
     "access": map{ 
       "code": function($_ as element()) as xs:string? {$_/ent:data },
       "datalink": function($_ as element()) as xs:string {$_/fn:concat("/data/",@name,"") },
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
           "datalink": function($_ as element()) as element(datalink)? {
            (: xs:string :)
                        fn:data($_/fn:concat("/data/",@name,""))!element datalink {  .} 
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
       { collection("vue-poc")/ent:entity },
       
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
     "description": "List of jobs run. From collection(""vue-poc/jobrun"")/jobrun",
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
  "logxml": map{
     "name": "logxml",
     "description": " log entries in XML format",
     "access": map{ 
       "address": function($_ as element()) as xs:string {$_/@address },
       "end": function($_ as element()) as xs:string? {$_/@end },
       "ms": function($_ as element()) as xs:integer {$_/@ms },
       "start": function($_ as element()) as xs:string {$_/@start },
       "status": function($_ as element()) as xs:string {$_/@type },
       "text": function($_ as element()) as xs:string {$_/. },
       "time": function($_ as element()) as xs:string {$_/@time },
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
           "end": function($_ as element()) as element(end)? {
            (: xs:string? :)
                        fn:data($_/@end)!element end {  .} 
                 },
           "ms": function($_ as element()) as element(ms)? {
            (: xs:integer :)
                        fn:data($_/@ms)!element ms { attribute type {'number'}, .} 
                 },
           "start": function($_ as element()) as element(start)? {
            (: xs:string :)
                        fn:data($_/@start)!element start {  .} 
                 },
           "status": function($_ as element()) as element(status)? {
            (: xs:string :)
                        fn:data($_/@type)!element status {  .} 
                 },
           "text": function($_ as element()) as element(text)? {
            (: xs:string :)
                        fn:data($_/.)!element text {  .} 
                 },
           "time": function($_ as element()) as element(time)? {
            (: xs:string :)
                        fn:data($_/@time)!element time {  .} 
                 },
           "user": function($_ as element()) as element(user)? {
            (: xs:string :)
                        fn:data($_/@user)!element user {  .} 
                 } },
       
      "data": function() as element(entry)*
       { 
		db:open("vue-poc","/logs/")[1]/entries/entry (: test data  1st doc :)
	 },
       
       "views": map{ 
       
       }
   },
  "namespace": map{
     "name": "namespace",
     "description": "Known XML namespaces",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/qns:description },
       "prefix": function($_ as element()) as xs:string {$_/@prefix },
       "xmlns": function($_ as element()) as xs:string {$_/@uri } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/@uri, $item/qns:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/qns:description)!element description {  .} 
                 },
           "prefix": function($_ as element()) as element(prefix)? {
            (: xs:string :)
                        fn:data($_/@prefix)!element prefix {  .} 
                 },
           "xmlns": function($_ as element()) as element(xmlns)? {
            (: xs:string :)
                        fn:data($_/@uri)!element xmlns {  .} 
                 } },
       
      "data": function() as element(qns:namespace)*
       { db:open("vue-poc","namespaces.xml")/qns:namespaces/qns:namespace
	 },
       
       "views": map{ 
       'filter': 'xmlns description'
       }
   },
  "query": map{
     "name": "query",
     "description": "List of replx query. From collection(""replx/queries"")/query",
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
  "quodatum.logfile": map{
     "name": "quodatum.logfile",
     "description": "list of saved BaseX log files with entries in the vue-poc database",
     "access": map{ 
       "date": function($_ as element()) as xs:string {$_/@date },
       "entries": function($_ as element()) as xs:integer {$_/@entries },
       "max": function($_ as element()) as xs:integer {$_/@max },
       "name": function($_ as element()) as xs:string {$_/@file },
       "perhr": function($_ as element()) as xs:string {$_/@perhr } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "date": function($_ as element()) as element(date)? {
            (: xs:string :)
                        fn:data($_/@date)!element date {  .} 
                 },
           "entries": function($_ as element()) as element(entries)? {
            (: xs:integer :)
                        fn:data($_/@entries)!element entries { attribute type {'number'}, .} 
                 },
           "max": function($_ as element()) as element(max)? {
            (: xs:integer :)
                        fn:data($_/@max)!element max { attribute type {'number'}, .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@file)!element name {  .} 
                 },
           "perhr": function($_ as element()) as element(perhr)? {
            (: xs:string :)
                        fn:data($_/@perhr)!element perhr {  .} 
                 } },
       
      "data": function() as element(day)*
       { 
		let $hrs:=(0 to 23)!format-number(., "00")
		for $item in db:dir("vue-poc","logs")
		let $es:=db:open("vue-poc","logs/" || $item)/entries/entry
		let $max:=round(max($es/@ms) div 1000)
		let $times:=(for $e in $es
		group by $hr:=substring($e/@time,1,2)
		return map:entry($hr, max($e/@ms)))=>map:merge()
		let $c:=for $h in $hrs return if(map:contains($times,$h)) then map:get($times,$h) else 0
		
		return <day  file="{ $item }"
			date="{ fn:replace($item,".*(\d{4}-\d{2}-\d{2}).*","$1")}"
			entries="{ count($es) }" 
			max="{ $max }" 
			perhr="{ string-join($c,' ') }" 
		/>
	 },
       
       "views": map{ 
       
       }
   },
  "quodatum.task": map{
     "name": "quodatum.task",
     "description": "Predefined queries with parameters, listed in taskdef.xml ",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/fn:serialize(description/node()) },
       "title": function($_ as element()) as xs:string {$_/title },
       "to": function($_ as element()) as xs:string {$_/@name },
       "url": function($_ as element()) as xs:string {$_/@url } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/fn:serialize(description/node()))!element description {  .} 
                 },
           "title": function($_ as element()) as element(title)? {
            (: xs:string :)
                        fn:data($_/title)!element title {  .} 
                 },
           "to": function($_ as element()) as element(to)? {
            (: xs:string :)
                        fn:data($_/@name)!element to {  .} 
                 },
           "url": function($_ as element()) as element(url)? {
            (: xs:string :)
                        fn:data($_/@url)!element url {  .} 
                 } },
       
      "data": function() as element(task)*
       { doc("tasks/taskdef.xml")/tasks/task },
       
       "views": map{ 
       
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
  "taskhistory": map{
     "name": "taskhistory",
     "description": "vue-poc task view events ",
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
       { doc("vue-poc/history.xml")/h:history/h:event[task] },
       
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
  "xqdoc": map{
     "name": "xqdoc",
     "description": "List of XQuery documentation sets ",
     "access": map{ 
       "id": function($_ as element()) as xs:string {$_/@id },
       "root": function($_ as element()) as xs:string {$_/"file:///C:/tmp/xqdoc/" },
       "time": function($_ as element()) as xs:string {$_/@time } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "id": function($_ as element()) as element(id)? {
            (: xs:string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "root": function($_ as element()) as element(root)? {
            (: xs:string :)
                        fn:data($_/"file:///C:/tmp/xqdoc/")!element root {  .} 
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
  