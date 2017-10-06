<!DOCTYPE html>
<template id="login">
<v-card class="grey lighten-4 elevation-0">

      <v-card-title class="green darken-1">
        <span class="white--text">Login</span>
      </v-card-title>
    <v-alert color="error" v-bind:value="showMessage">
      {{message}}
    </v-alert>
     <v-card-actions>
      <v-text-field
              name="input-name"
              label="Enter your name"
              hint="name??"
              v-model="name"
              required
             ></v-text-field>
     </v-card-actions>
  
    <v-card-actions>    
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
    </v-card-actions>
        
    <v-divider></v-divider>
    <v-card-actions class="blue-grey darken-1 mt-0">
       <v-btn primary @click="go()">Continue</v-btn>
       <v-spacer></v-spacer>
    </v-card-actions>
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
       var data={
             username: this.name, //gave the values directly for testing
             password: this.password,
             redirect: this.redirect
             }
       HTTP.post("login-check",Qs.stringify( data))
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
