// ace editor for vue.js
//https://jsfiddle.net/bc_rikko/gbpw2q9x/3/
Vue.component('vue-ace', {
    template: '<div :id="editorId" style="width: 100%; height: 100%;"></div>',
  props: ['editorId', 
          'content',
          'mode', 
          'theme',
          'wrap',
          'readOnly'
          ],
  data () {
    return {
      editor: Object,
      beforeContent: '',
      aceSettings:{
          enableSnippets:true,
          enableBasicAutocompletion:true,
          enableLiveAutocompletion:true},
      annots:{
        error:0,warning:0,info:0
        } 
      }
  },
  watch: {
    'content' (value) {
        if (this.beforeContent !== value) {
        this.editor.setValue(value, 1)
      }
    },
    'mode' (value) {
        var session=this.editor.getSession()
        session.setMode(`ace/mode/${value}`)
    },
    'wrap' (value) {
      var session=this.editor.getSession()
      session.setUseWrapMode(value)
  }
  },
  methods:{

    command(cmd){
      //alert("fold")
      var cm = this.editor.commands
      //console.log(cm.commands)
     cm.exec(cmd, this.editor)
    },
    
    testAnnotations(){
    this.editor.getSession().setAnnotations([{
      row: 1,
      column: 0,
      text: "Strange error",
      type: "error" // also warning and information
    }]);
    }
  },
  
  mounted () {
    const mode = this.mode || 'text'
    const theme = this.theme || 'github'
    const wrap = this.wrap || false

    const aceSettings=this.aceSettings
    
    const readOnly = this.readOnly || false
    ace.config.set("workerPath", "/vue-poc/ui/ace-workers") 
    this.editor = window.ace.edit(this.editorId)
    
    this.editor.$blockScrolling = Infinity
    this.editor.setValue(this.content, 1)
    
    // mode-xxx.js or theme-xxx.jsがある場合のみ有効
    var session=this.editor.getSession()
    session.setMode(`ace/mode/${mode}`)
    session.setUseWrapMode(wrap)
    this.editor.setTheme(`ace/theme/${theme}`)
    this.editor.setOptions({ readOnly:this.readOnly,
                        enableSnippets : aceSettings.enableSnippets,
                        enableBasicAutocompletion : aceSettings.enableBasicAutocompletion,
                        enableLiveAutocompletion : aceSettings.enableLiveAutocompletion,
                        tabSize: 2,
                        useSoftTabs: true
                        });
    this.editor.commands.addCommand({
      name: "showKeyboardShortcuts",
      bindKey: {win: "Ctrl-Alt-h", mac: "Command-Alt-h"},
      exec: function(editor) {
          ace.config.loadModule("ace/ext/keybinding_menu", function(module) {
              module.init(editor);
              editor.showKeyboardShortcuts()
          })
      }
  })
    this.editor.on('change', () => {
        this.beforeContent = this.editor.getValue()
      this.$emit('change-content', this.editor.getValue())
    });
    
    this.editor.getSession().on("changeAnnotation", ()=>{
      var annot = this.editor.getSession().getAnnotations();
      this.annots={error:0,warning:0,info:0};
      for (var key in annot){
          if (annot.hasOwnProperty(key)){
            this.annots[annot[key].type]+=1;
            //console.log("[" + annot[key].row + " , " + annot[key].column + "] - \t" + annot[key].type+ "# " +annot[key].text);
          }
      }
      //console.log(this.annots)
       this.$emit('annotation',this.annots)
    });
    
    Events.$on('eventFired', (cmd) => {
      if(cmd=="outline"){
        var row = this.editor.selection.getCursor().row
        var toks=this.editor.session.getTokens(row).filter(function(t) {
            return true
        })
        console.log(toks);
      }else this.command(cmd);
    });
  }
})
