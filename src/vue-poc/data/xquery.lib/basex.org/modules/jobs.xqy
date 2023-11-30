xquery version "3.1";
(:~
 : BaseX Jobs Module functions
 :
 : @see http://docs.basex.org/wiki/Jobs_Module
 :)
module namespace jobs = "http://basex.org/modules/jobs";

declare namespace a = "http://reecedunn.co.uk/xquery/annotations";
declare namespace o = "http://reecedunn.co.uk/xquery/options";

declare option o:requires "basex/8.5";

declare %a:since("basex", "8.5") function job:current() as xs:string external;
declare %a:since("basex", "8.5") function job:list() as xs:string* external;
declare %a:since("basex", "8.5") function job:list-details() as element(job)* external;
declare %a:since("basex", "8.5") function job:list-details($id as xs:string) as element(job)* external;
declare %a:since("basex", "8.5") function job:finished($id as xs:string) as xs:boolean external;
declare %a:since("basex", "8.5") function job:services() as element(job)* external;
declare %a:since("basex", "8.5") function job:eval($query as xs:string) as xs:string external;
declare %a:since("basex", "8.5") function job:eval($query as xs:string, $bindings as map(*)?) as xs:string external;
declare %a:since("basex", "8.5") function job:eval($query as xs:string, $bindings as map(*)?, $options as map(*)?) as xs:string external;
declare %a:since("basex", "9.0") function job:invoke($uri as xs:string) as xs:string external;
declare %a:since("basex", "9.0") function job:invoke($uri as xs:string, $bindings as map(*)?) as xs:string external;
declare %a:since("basex", "9.0") function job:invoke($uri as xs:string, $bindings as map(*)?, $options as map(*)?) as xs:string external;
declare %a:since("basex", "8.5") function job:result($id as xs:string) as item()* external;
declare %a:since("basex", "8.5") function job:stop($id as xs:string) as empty-sequence() external;
declare %a:since("basex", "8.5") function job:wait($id as xs:string) as empty-sequence() external;
