<!DOCTYPE html>
<!-- 
ace editor for vue.js
//https://jsfiddle.net/bc_rikko/gbpw2q9x/3/
events:
event fired cmd outline
 --> 
<template id="vue-ace">
<div  style="width: 100%; height: 100%;"></div>
</template>
<script>{
  props: [ 'content',
          'mode', 
          'wrap',
          'readOnly',
          'events',
          'settings',
          'minLines',
          ],
  data () {
    return {
      editor: Object,
      beforeContent: '',
      aceSettings:{
          theme: "github",
          keybinding: "ace",
          fontsize: 16,
          enableSnippets:true,
          enableBasicAutocompletion:true,
          enableLiveAutocompletion:true
          },
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
    },
    "settings":{
      handler:function(vnew,vold){
        this.applySettings(vnew)
       // alert("setting")
        },
      deep:true
    }
  },
  methods:{

    command(cmd){
      //alert("fold")
      var cm = this.editor.commands
      //console.log(cm.commands)
     cm.exec(cmd, this.editor)
    },
    
    outline(){
      var row = this.editor.selection.getCursor().row
      var toks=this.editor.session.getTokens(row).filter(function(t) {
          return true
      })
      console.log("tokens: ",toks);
    },
    
    testAnnotations(){
    this.editor.getSession().setAnnotations([{
      row: 1,
      column: 0,
      text: "Strange error",
      type: "error" // also warning and information
    }]);
    },
    
    applySettings(aceSettings){
      this.editor.setTheme(`ace/theme/${aceSettings.theme}`)
      //this.editor.setKeyboardHandler(`ace/keyboard//${aceSettings.keybinding}`)
      this.editor.setFontSize(parseInt(aceSettings.fontsize,10))
      this.editor.setOptions({ 
                          enableSnippets : aceSettings.enableSnippets,
                          enableBasicAutocompletion : aceSettings.enableBasicAutocompletion,
                          enableLiveAutocompletion : aceSettings.enableLiveAutocompletion,
                          tabSize: 2,
                          useSoftTabs: true
                          });
    }
  },
  
  mounted () {
    const mode = this.mode || 'text'
    const wrap = this.wrap || false

    const readOnly = this.readOnly || false
    ace.config.set("workerPath", "/vue-poc/ui/ace-workers") 
    this.editor = window.ace.edit(this.$el)
    this.applySettings(this.aceSettings)
    this.editor.$blockScrolling = Infinity
   //console.log("setValue: ",this.content)
    this.editor.setValue((this.content == null)?"NULL":this.content, 1);
    this.editor.setOptions({ readOnly:this.readOnly });
    if(this.minLines){
      this.editor.setOptions({ minLines: this.minLines})
    };
    var session=this.editor.getSession()
    session.setMode(`ace/mode/${mode}`)
    session.setUseWrapMode(wrap)
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
      this.$emit('change-content', this.beforeContent)
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
       this.$emit('annotation',{error: this.annots["error"]+0, warning: this.annots["warning"]+0})
    });
    if(this.events){
      this.events.$on('eventFired', (cmd) => {
      if(cmd=="outline"){
       this.outline();
      }else this.command(cmd);
    });
    }
  }
}</script>
