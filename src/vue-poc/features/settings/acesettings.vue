<!DOCTYPE html>
<template id="acesettings">
<v-container fluid>

  <v-layout row>
    <v-flex xs12 sm8 offset-sm2>
      <v-card>
       <v-toolbar class="orange">
        <v-card-title  > <qd-breadcrumbs 
         :crumbs="[{to: '/settings', text:'Settings'}, {text: 'Common Ace editor settings.', disabled: true }]"
         >crumbs</qd-breadcrumbs></v-card-title>
        </v-toolbar>
      <v-card-text>
      <v-container fluid>
       <v-layout row>
          <v-flex xs6 class="pa-3">
        <v-layout row >
          
          <v-flex >
            <v-select 
             :disabled= "$vuetify.theme.dark"
              v-bind:items="themes"
              v-model="ace.theme"
              label="Theme"
            ></v-select>
          </v-flex>
          <v-flex >
            <v-select   :disabled= "!$vuetify.theme.dark"
              v-bind:items="themesDark"
              v-model="ace.themeDark"
              label="Dark Theme"
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
          <v-subheader>Ace editor behaviour</v-subheader>
   
            <v-list-item >
              <v-list-item-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>enableSnippets</v-list-item-title>
                <v-list-item-subtitle>Allow 
                <a href="https://cloud9-sdk.readme.io/docs/snippets" target="docs">snippets</a></v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
    
            <v-list-item >
              <v-list-item-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>enableBasicAutocompletion</v-list-item-title>
                <v-list-item-subtitle>Autocompletion via control-space</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
         
            <v-list-item >
              <v-list-item-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>enableLiveAutocompletion</v-list-item-title>
                <v-list-item-subtitle>Autocompletion while typing</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
            
        </v-list>
        
       
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
			        themeDark: "twilight",
			        keybinding: "ace",
			        fontsize: "14"
			    },
			    keybindings:[  'ace',  'vim', 'emacs', 'textarea', 'sublime' ],
			    themes: [ "github","chrome" ,"tomorrow"],
			    themesDark: ["chaos","twilight"]
			    }
  },
  methods:{
    extend(obj, src) {
      Object.keys(src).forEach(function(key) { if(!obj[key]) obj[key] = src[key]; });
      return obj;
    }
  },
  
   beforeRouteLeave (to, from, next) {
     Settings.setItem('settings/ace',this.ace)
     .then(v=>{
     next()
     })
   },
  mounted: function () {
  
 // console.log("$$$",this.ace)
  Settings.getItem('settings/ace')
    .then( v =>{
              //alert("db\n"+JSON.stringify(v))
              this.ace = Object.assign({}, this.ace, v)
              //alert("op\n"+JSON.stringify(this.ace))
                  })

  }
}

</script>
