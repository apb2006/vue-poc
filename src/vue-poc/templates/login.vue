<!DOCTYPE html>
<template id="login">
<v-card class="grey lighten-4 elevation-0">
    <v-card-row class="green darken-1">
      <v-card-title>
        <span class="white--text">Login</span>
      </v-card-title>
    </v-card-row>
   
     <v-card-row>
      <v-text-field
              name="input-name"
              label="Enter your name"
              hint="name??"
              v-model="name"
              required
             ></v-text-field>
     </v-card-row>
  
    <v-card-row>    
         <v-text-field
              name="input-password"
              label="Enter your password"
              hint="Enter your password"
              v-model="password"
              :append-icon="e1 ? 'visibility' : 'visibility_off'"
              :append-icon-cb="() => (e1 = !e1)"
              :type="e1 ? 'password' : 'text'"
              required
            ></v-text-field>      
    </v-card-row>
        
    <v-divider></v-divider>
    <v-card-row actions class="blue-grey darken-1 mt-0">
       <v-btn primary @click.native="go()">Continue</v-btn>
       <v-spacer></v-spacer>
    </v-card-row>
</v-card>
</template>

<script>{
  template: '#login',
    data () {
      return {
        e1: true,
        name:'',
        password: ''
      }
    },
    methods:{
      go () {
        alert("not yet")
      }
    }
  }
</script>
