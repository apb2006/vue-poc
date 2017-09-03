<!DOCTYPE html>
<template id="acesettings">
<v-container>

  <v-layout row>
    <v-flex xs12 sm8 offset-sm2>
      <v-card>
        <v-alert  warning value="true">Not fully implemented</v-alert>
      
      <v-container fluid>
        <v-layout row>
          <v-flex xs4>
            <v-subheader>Theme</v-subheader>
          </v-flex>
          <v-flex xs8>
            <v-select
              v-bind:items="themes"
              v-model="ace.theme"
              label="Theme"
            ></v-select>
          </v-flex>
        </v-layout>
        <v-layout row>
          <v-flex xs4>
            <v-subheader>Key binding</v-subheader>
          </v-flex>
          <v-flex xs8>
            <v-select
              v-bind:items="keybindings"
              v-model="ace.keybinding"
              label="Key binding"
            ></v-select>
           
          </v-flex>
        </v-layout>
        <v-layout row>
          <v-flex xs4>
            <v-subheader>Font size</v-subheader>
          </v-flex>
          <v-flex xs8>
            <v-text-field
              label="Font size (px)"
               v-model="ace.fontsize"
            ></v-text-field>
          </v-flex>
        </v-layout>
       <v-divider ></v-divider>
      </v-container>
        
        <v-list two-line subheader>
          <v-subheader>Ace editor settings</v-subheader>
   
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableSnippets</v-list-tile-title>
                <v-list-tile-sub-title>Allow 
                <a href="https://cloud9-sdk.readme.io/docs/snippets" target="docs">snippets</a></v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
    
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableBasicAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>Autocompletion via control-space</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
         
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableLiveAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>Autocompletion while typing</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
            
        </v-list>
        <v-card-text>
       
    </v-card-text>
      </v-card>
    </v-flex>
  </v-layout>
  </v-container>
</template>

<script>{
  data () {
    return {
			     xace: {
			        enableSnippets: true,
			        enableBasicAutocompletion: true,
			        enableLiveAutocompletion: true,
			        theme: "github",
			        keybinding: "ace",
			        fontsize: "14"
			    },
			    ace: {},
			    keybindings:[  'ace',  'vim', 'emacs', 'textarea', 'sublime' ],
			    themes: [ "github", "chaos","tomorrow"]
			    }
  },
  methods:{
    extend(obj, src) {
      Object.keys(src).forEach(function(key) { if(!obj[key]) obj[key] = src[key]; });
      return obj;
    }
  },
  beforeRouteEnter (to, from, next) {
    settings.getItem('settings/ace')
    .then( v =>{
      next(vm => { vm.ace = v; })
      })
     },
  
  mounted: function () {
 // console.log(this.ace,this.xace)
 // this.extend(this.storeace,this.storeace);
 // console.log("$$$",this.ace)
  },
  watch: {"ace":{
    handler:function(v){
      settings.setItem('settings/ace',this.ace)
      },
    deep:true
  }
}
}

</script>
