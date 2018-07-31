<!DOCTYPE html>
<template id="login">
 <v-layout>
    <v-flex xs12 sm6 offset-sm3>
					<v-card class="grey lighten-4 elevation-0">
					
					      <v-card-title class="amber ">
					        <span class="white--text">Please login as user with permission is required</span>
					      </v-card-title>
					    <v-alert color="error" v-bind:value="showMessage">
					      {{message}}
					    </v-alert>
					     <v-card-actions>
					      <v-text-field
					              name="input-name"
					              label="User name"
					              hint="Enter your name"
					              v-model="name"
					              required
					             ></v-text-field>
					     </v-card-actions>
					  
					    <v-card-actions>    
					         <v-text-field
					              name="input-password"
					              label="Password"
					              hint="Enter your password"
					              v-model="password"
					              :append-icon="hidepass ? 'visibility' : 'visibility_off'"
					              @click:append="() => (hidepass = !hidepass)"
					              :type="hidepass ? 'password' : 'text'"
					              required
					            ></v-text-field>      
					    </v-card-actions>
					        
					    <v-divider></v-divider>
					    <v-card-actions >
					       <v-spacer></v-spacer>
					       <v-btn  color="primary"  @click="go()">Continue</v-btn>
					    </v-card-actions>
					</v-card>
    </v-flex>
</v-layout>
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
