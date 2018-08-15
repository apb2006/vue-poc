// Authorization Object
const Auth={
    user: "guest",
    role: null,
    session: null,
    created: null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  
    },
    logout(){
      Auth.user="guest";
      Auth.role=null;
    }
};
Vue.use(Auth);
