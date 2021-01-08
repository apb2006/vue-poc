(:~ 
: test of parameter type handling
: @author andy bunce
:)


(:~ A simple string
 @default default string
 :)
declare variable $string1 as xs:string external :="my test string";

(:~ a boolean
 @default false
:)
declare variable $boolean1 as xs:boolean  external :=false();

(:~ an integer
 @default 42
:)
declare variable $integer1 as xs:integer  external := 99;

update:output("done")