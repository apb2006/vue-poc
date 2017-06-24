<!DOCTYPE html>
<template id="login">
<v-card class="grey lighten-4 elevation-0">

    <v-card-row class="green darken-1">
      <v-card-title>
        <span class="white--text">Login</span>
      </v-card-title>
    </v-card-row>
    <v-alert error v-bind:value="showMessage">
      {{message}}
    </v-alert>
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
        password: '',
        redirect: this.$route.query.redirect,
        message:"",
        showMessage:false
      }
    },
    methods:{
      go () {
       this.hidepass=true
       this.showMessage=false
       var data=Qs.stringify(
           {
             username: this.name, //gave the values directly for testing
             password: this.password,
             redirect: this.redirect
             })
       HTTP.post("login-check", data)
      .then(r=>{
        console.log("login",r.data)
        if(r.data.status){
          this.$auth.role="admin"
          this.$router.replace(this.redirect)
        }else{
          this.message=r.data.message
          this.showMessage=true;
        }
          
      }).catch(error=> {
        alert("err login")
      })
    }
  }
}
</script>
