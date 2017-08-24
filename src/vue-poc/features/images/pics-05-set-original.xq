(: set original:)
for $i in collection("/vue-poc/image")/image
where $i[file/@path=>contains('original')]
return  insert node attribute { 'original' } { true() } into $i