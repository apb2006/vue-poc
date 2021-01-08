// Authorization Object
const Auth={
    user: "guest",
    role: null,
    session: null,
    created: null,
    remember: null, 
    
    update(data){
        Auth.user=data.user;
    	Auth.role=data.role
    	Auth.session=data.session
    	Auth.created=data.created
    	
    	Auth.remember=data.login
    },
    
    logout(){
      Auth.user="guest";
      Auth.role=null;
    },
    
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  
    }
};
Vue.use(Auth);
