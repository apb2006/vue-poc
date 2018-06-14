// Mimetype info
const MimeTypes={
 toMode:[
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
  mode:{
    "text": {},
    "javascript": {
      format(t){ return js_beautify(t, { indent_size: 2 })}
    },
    "xml": {
      format(t){ return html_beautify(t, { indent_size: 3 ,indent_inner_html:true})}
    },
    "css": {}
  },
  install(Vue){
      Object.defineProperty(Vue.prototype, '$MimeTypes', {
        get () { return MimeTypes }
    })  }

};
Vue.use(MimeTypes);