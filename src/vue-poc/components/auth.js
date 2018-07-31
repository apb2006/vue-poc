// Authorization Object
const Auth={
    user:"guest",
    permission:null,
    session:null,
    created:null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  
    },
    logout(){
      Auth.user="guest";
      Auth.permission=null;
    }
};
Vue.use(Auth);
