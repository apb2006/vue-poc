<!DOCTYPE html>
<template id="acesettings">
<v-container fluid>

  <v-layout row>
    <v-flex xs12 sm8 offset-sm2>
      <v-card>
        <v-alert  color="warning" value="true">Not fully implemented</v-alert>
      
      <v-container fluid>
       <v-layout row>
          <v-flex xs6 class="pa-3">
        <v-layout row >
          
          <v-flex >
            <v-select
              v-bind:items="themes"
              v-model="ace.theme"
              label="Theme"
            ></v-select>
          </v-flex>
        </v-layout>
       
        <v-layout row>
         
          <v-flex >
            <v-select
              v-bind:items="keybindings"
              v-model="ace.keybinding"
              label="Key binding"
            ></v-select>
           
          </v-flex>
        </v-layout>
        <v-layout row>
         
          <v-flex >
            <v-text-field
              label="Font size (px)"
               v-model="ace.fontsize"
            ></v-text-field>
          </v-flex>
        </v-layout>
         </v-flex>
        <v-flex xs6 style="height:30vh" class="grey pa-3" fill-height>
            <vue-ace mode="xquery" content="test"  :settings="ace"></vue-ace>
        </v-flex>
        </v-layout>
       <v-divider ></v-divider>
 
        
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
			     ace: {
			        enableSnippets: true,
			        enableBasicAutocompletion: true,
			        enableLiveAutocompletion: true,
			        theme: "github",
			        keybinding: "ace",
			        fontsize: "14"
			    },
			    keybindings:[  'ace',  'vim', 'emacs', 'textarea', 'sublime' ],
			    themes: [ "github","chrome" ,"tomorrow","-dark-","chaos","twilight"]
			    }
  },
  methods:{
    extend(obj, src) {
      Object.keys(src).forEach(function(key) { if(!obj[key]) obj[key] = src[key]; });
      return obj;
    }
  },
   beforeRouteLeave (to, from, next) {
     settings.setItem('settings/ace',this.ace)
     .then(v=>{
     next()
     })
   },
  mounted: function () {
  
 // console.log("$$$",this.ace)
  settings.getItem('settings/ace')
    .then( v =>{
              //alert("db\n"+JSON.stringify(v))
              this.ace = Object.assign({}, this.ace, v)
              //alert("op\n"+JSON.stringify(this.ace))
                  })

  }
}

</script>
