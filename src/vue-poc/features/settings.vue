<!DOCTYPE html>
<template id="settings">
  <v-layout row>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>

        <v-list two-line subheader>
          <v-subheader>Ace editor settings</v-subheader>
   
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableSnippets</v-list-tile-title>
                <v-list-tile-sub-title>Allow snippets</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
    
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableBasicAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableBasicAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
         
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableLiveAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableLiveAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
 
        </v-list>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>{
  data () {
    return {
      ace: {
        enableSnippets: true,
        enableBasicAutocompletion: true,
        enableLiveAutocompletion: true
    }
    }
  },
  created: function () {
    settings.getItem('settings/ace')
    .then((v)=>{
      console.log("AAAA",v)
      this.ace=v
    })

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
