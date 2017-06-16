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
              :append-icon="hidepass ? 'visibility' : 'visibility_off'"
              :append-icon-cb="() => (hidepass = !hidepass)"
              :type="hidepass ? 'password' : 'text'"
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
    data () {
      return {
        hidepass: true,
        name:'',
        password: ''
      }
    },
    methods:{
      go () {
       this.hidepass=true
       var data=Qs.stringify(
           {
             username: this.name, //gave the values directly for testing
             password: this.password,
             client_id: 'user-client'
             })
       HTTP.post("login-check", data,
         {
   headers: { 
     "Content-Type": "application/x-www-form-urlencoded"
   }})
      .then(r=>{
        console.log(r)
        alert("loh")
      }).catch(error=> {
        alert("err")
      })
    }
  }
}
</script>
