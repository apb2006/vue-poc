import module namespace vue = 'quodatum:vue.compile' at "../src/vue-poc/lib/vue-compile/vue-compile.xqm";

declare variable  $proj external :="C:/Users/andy/git/vue-poc/src/vue-poc/";  
vue:compile( $proj)