<!DOCTYPE html>
<!-- 
 ok cancel dialog
 -->
<template id="qd-confirm">
  <v-dialog v-model="showDialog" >
       <v-card >
       <v-toolbar class="lime darken-1">
          <v-card-title>Confirm action</v-card-title>
          </v-toolbar>
          <v-card-text>Delete all edit text?</v-card-text>
        <v-card-actions>
        <v-spacer></v-spacer>
          <v-btn  v-on:click="$emit('cancel')">Cancel</v-btn>
          <v-btn  v-on:click="$emit('ok')">Ok</v-btn>
        </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>{
  data(){
    return {showDialog:false}
  },
}
</script>
