<!DOCTYPE html>
<template id="login">
 <v-layout>
    <v-flex >
					<v-card >
					
					      <v-card-title class="red">
					        <span class="white--text">The current credentials do the give access this page, please login.</span>
					      </v-card-title>
					   
					     <v-card-actions>
					    <v-form v-model="valid" ref="form">
                        <v-text-field
                          label="Enter your user id "
                          v-model="name"
                          :rules="nameRules"
                          required
                        ></v-text-field>
                        <v-text-field
                          label="Enter your password"
                          v-model="password"
                          min="8"
                          :append-icon="hidepass ? 'visibility' : 'visibility_off'"
                          @click:append="() => hidepass = !hidepass"
                          :type="hidepass ? 'password' : 'text'"
                          :rules="passwordRules"
                          counter
                          required
                        ></v-text-field>
                        <v-switch 
                label="Remember me"  v-model="remember">
              </v-switch> 
                        <v-layout justify-space-between>
                           <v-spacer></v-spacer>
                            <v-btn @click="submit" :class=" { 'blue darken-4 white--text' : valid, disabled: !valid }">Login</v-btn>
                           
                        </v-layout>
              </v-form>
              </v-card-actions>
              <v-card-actions>
					     <a href="">Forgot Password</a>
					     <v-alert color="error" v-bind:value="showMessage">
                {{message}}
              </v-alert>
              </v-card-actions>
					   
					</v-card>
    </v-flex>
</v-layout>
</template>

<script>{
    data () {
      return {
        valid: false,
        password: '',
        passwordRules: [
          (v) => !!v || 'Password is required',
        ],
        name: '',
        nameRules: [
          (v) => !!v || 'Name is required'
        ],
        hidepass: true,
        remember: false,
        redirect: this.$route.query.redirect,
        message:"",
        showMessage:false
      }
    },
    methods:{
      submit () {
        if (this.$refs.form.validate()) {
          this.go()
        }
      },
      clear () {
        this.$refs.form.reset()
      },
      go () {
       this.hidepass=true
       this.showMessage=false
       var data={
             username: this.name, //gave the values directly for testing
             password: this.password,
             remember: this.remember,
             redirect: this.redirect
             }
       HTTP.post("login-check",Qs.stringify( data))
      .then(r=>{
        console.log("login",r.data)
        if(r.data.status){
          this.$auth.role="admin";
          this.$auth.user=this.name;
          console.log("redirect",this.redirect);
          this.$router.replace({path: this.redirect});
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
