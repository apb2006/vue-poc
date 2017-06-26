<!DOCTYPE html>
<template id="settings">
  <v-layout row>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>

        <v-list two-line subheader>
          <v-subheader>Ace editor settings</v-subheader>
          <v-list-item>
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableSnippets"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableSnippets</v-list-tile-title>
                <v-list-tile-sub-title>Allow snippets</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
          <v-list-item>
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableBasicAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableBasicAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableBasicAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
          <v-list-item>
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.enableLiveAutocompletion"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>enableLiveAutocompletion</v-list-tile-title>
                <v-list-tile-sub-title>enableLiveAutocompletion</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
 
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
    // `this` points to the vm instance
    console.log('created: ')
    localforage.getItem('settings/ace').then((value) => {
      console.log('oh say can you see, ' + value);
      this.ace=value || this.ace
    }).catch((err) => {
      console.log('the rockets red glare has blinded me');
    });
  },
  updated: function () {
    // `this` points to the vm instance
    console.log('updated: ')
    localforage.setItem('settings/ace', this.ace).then((value) => {
      console.log('woot! we saved ' + value);
    }).catch((err) => {
      console.log('he\'s dead, jim!');
    });
  },
  methods: {
    reverseMessage: function () {
      alert("unused")
    }
  }
}

</script>
