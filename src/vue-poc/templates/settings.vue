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
                <v-checkbox v-model="ace.notifications"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>Notifications</v-list-tile-title>
                <v-list-tile-sub-title>Allow notifications</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
          <v-list-item>
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.sound"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>Sound</v-list-tile-title>
                <v-list-tile-sub-title>Hangouts message</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
          <v-list-item>
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.video"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>Video sounds</v-list-tile-title>
                <v-list-tile-sub-title>Hangouts vidoe call</v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list-item>
          <v-list-item>
            <v-list-tile avatar>
              <v-list-tile-action>
                <v-checkbox v-model="ace.invites"></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>Invites</v-list-tile-title>
                <v-list-tile-sub-title>Notify when receiving invites</v-list-tile-sub-title>
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
      notifications: false,
      sound: false,
      video: false,
      invites: false
    }
    }
  },
  created: function () {
    // `this` points to the vm instance
    console.log('created: ')
    localforage.getItem('ace').then((value) => {
      console.log('oh say can you see, ' + value);
      this.ace=value || this.ace
    }).catch((err) => {
      console.log('the rockets red glare has blinded me');
    });
  },
  updated: function () {
    // `this` points to the vm instance
    console.log('updated: ')
    localforage.setItem('ace', this.ace).then((value) => {
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
