// ace customisations
const AceExtras={
    rhymeCompleter:  {
      // test completer
      getCompletions: function(editor, session, pos, prefix, callback) {
        if (prefix.length === 0) { callback(null, []); return }
        axios.get("http://rhymebrain.com/talk",{params:{function:"getRhymes",word:prefix}})
        .then(
            function(wordList) {
                // wordList like [{"word":"flow","freq":24,"score":300,"flags":"bc","syllables":"1"}]
                var r=wordList.data.map(function(ea) {
                  return {name: ea.word, value: ea.word, score: ea.score, meta: "rhyme"}
                })
                callback(null,r)
                })
 
      }
    },
    
    //basex functions
    basexCompleter: {
      getCompletions: function(editor, session, pos, prefix, callback) {
        if (prefix.length === 0) { callback(null, []); return }
        console.log("dd",prefix)
        callback(null, [{
              caption: "archive:create#2",
              snippet: "archive:create(${1:entries}, ${2:contents})",
              score: 100,
              meta: "archive",
              completer: this
          }, {
              caption: "archive:create#3",
              snippet: "archive:create(${1:entries}, ${2:contents}, ${3:options})",
              score: 100,
              meta: "archive",
              completer: this
          }])
      }
  },

    
    snippets:[
          {
            name: "test",
            content: "something",
            tabTrigger: "test:"
          },
          {
            name: "test2",
            content: "some2",
            tabTrigger: "he"
          }
    ],
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$aceExtras', {
          get () { return AceExtras }
      })  
    }
};
Vue.use(AceExtras);
