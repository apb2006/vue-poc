module namespace _ = 'quodatum.test.about';
import module namespace entity = 'quodatum.models.generated' at "../../models.gen.xqm";
import module namespace dice = 'quodatum.web.dice/v4' at "../../lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at "../../lib/webutils.xqm";

(:~
 :  package.json
 :)
declare  
%rest:GET %rest:path("/vue-poc/api/package.json")
%output:method("text")
%output:media-type("application/json") 
function _:package()
as xs:string
{
unparsed-text("../../package.json")
};
