// Mimetype info
// 
const MimeTypes=new function(){
 this.toMode=[
            {name: "text/plain", mode: "text"},
            {name: "text/xml", mode: "xml"},
            {name: "application/xml", mode:"xml"},
            {name: "application/xquery", mode:"xquery"},
            {name: "text/ecmascript", mode:"javascript"},
            {name: "application/sparql-query", mode:"sparql"},
            {name: "text/html", mode:"html"},
            {name: "text/turtle", mode:"turtle"},
            {name: "text/css", mode:"css"},
            {name: "image/svg+xml", mode:"svg"}
            ],
  this.formatdom= t=>html_beautify(t, { indent_size: 3 ,indent_inner_html:true});
  this.formatjs= t=>js_beautify(t, { indent_size: 2 });
  
  this.mode={
    "text": {},
    "javascript": {
      "format":this.formatjs
    },
   "xml": {
     "format":this.formatdom
    },
    "css": {}
  };
  
  this.install=function(Vue){
      Object.defineProperty(Vue.prototype, '$MimeTypes', {
        get () { return MimeTypes }
    })  }

};
Vue.use(MimeTypes);