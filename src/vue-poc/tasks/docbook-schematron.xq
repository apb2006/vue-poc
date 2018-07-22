import module namespace schematron = "http://github.com/Schematron/schematron-basex";
let $sch := schematron:compile(doc('C:\Users\andy\git\vue-poc\src\vue-poc\static\resources\schematron\docbook-mods.sch'))
let $xml := fn:doc('C:\Users\andy\git\vue-poc\src\vue-poc\static\resources\schematron\test.xml')
let $validation := schematron:validate($xml, $sch)

return $validation

