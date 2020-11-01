// Mimetype info as vue extension. defines $MimeTypes

// $MimeTypes.mode(acemode) ->{icon,formatfn}
//  $MimeTypes.contentType(mimetype) ->{mode}

const MimeTypes=new function(){
  var formatdom= t=>html_beautify(t, { indent_size: 3 ,indent_inner_html:true});
  var formatjs= t=>js_beautify(t, { indent_size: 2 });
  var formatcss= t=>css_beautify(t, { indent_size: 2 });
 
 // mimetype to ace mode
 this.contentType={
     "text/plain":{ mode: "text"},
     "text/xml":{ mode: "xml"},
     "application/xml":{ mode:"xml"},
     "application/xquery":{ mode:"xquery"},
     "text/ecmascript":{ mode:"javascript"},
     "application/sparql-query": {mode:"sparql"},
     "text/html":{ mode:"html"},
     "text/turtle":{ mode:"turtle"},
     "text/css": {mode:"css"},
    "image/svg+xml":{ mode:"svg"}
 };

  
  this.mode={
    "text": {
      "icon": "library_books"
    },
    "javascript": {
      "format": formatjs
    },
   "xml": {
     "format": formatdom
    },
    "html": {
      "format": formatdom
    },
    "css": {
      "format": formatcss,
      "icon": "school"
    },
    "xquery": {
      "icon": "spa"
    }
  };
  // return [{name:.. mode:..}..]
  this.list=function(){
    var that=this
    var h= Object.keys(this.contentType).map(
        function(k){ return {name: k, mode: that.contentType[k].mode}}
        )
    return h
  };
  
  this.icon=function(mode){
    var i= this.mode[mode] && this.mode[mode].icon
    return  i || "insert_drive_file"
  };
  
  this.install=function(Vue){
      Object.defineProperty(Vue.prototype, '$MimeTypes', {
        get () { return MimeTypes }
    })  }

};
Vue.use(MimeTypes);