<!DOCTYPE html>
<!-- 
 ok cancel dialog
 -->
<template id="qd-confirm">
  <v-dialog v-model="value" >
       <v-card >
       <v-toolbar class="orange darken-1">
          <v-card-title>Confirm action</v-card-title>
          </v-toolbar>
          <v-card-text>
            <slot>Test message</slot>
          </v-card-text>
        <v-card-actions>
        <v-spacer></v-spacer>
          <v-btn  v-on:click="$emit('confirm',false)">Cancel</v-btn>
          <v-btn  v-on:click="$emit('confirm',true)">Ok</v-btn>
        </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>{
  props: ['value']
}
</script>
