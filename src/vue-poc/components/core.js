// base -----------------------
localforage.config({
  name: 'vuepoc'
});
const AXIOS_CONFIG={
    baseURL: "/vue-poc/api/",
    headers: {
      'X-Custom-Header': 'vue-poc',
      accept: 'application/json'
    },
    paramsSerializer: function(params) {
      return Qs.stringify(params)
    }
  };

// errors displayed by interceptor
const HTTP = axios.create(AXIOS_CONFIG);
// errors hidden
const HTTPNE = axios.create(AXIOS_CONFIG);
const axios_json={ headers: {accept: 'application/json'}};

const Auth={
    user:"guest",
    permission:null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  }
};
Vue.use(Auth);

// read and write settings 
// https://vuejs.org/v2/guide/state-management.html
var settings = {
    debug: false,
    getItem (key) {
      if (this.debug) console.log('getItem',key);
      return new Promise((resolve, reject) => {
        localforage.getItem(key)
        .then((value) => {
          //console.log('GET setting', key,value);
          resolve(value)
        }).catch((err) => {
          console.log('GET failed');
          reject(err)
      });
      });
    },
    setItem (key,value) {
      if (this.debug) console.log('setItem',key,value);
      return new Promise((resolve, reject) => {
      localforage.setItem(key, value) 
      .then((value) => {
        //console.log('SET ',key, value);
        return new Promise((resolve, reject) => {resolve(value);})
      }).catch((err) => {
        console.log('set failed');
        return new Promise((resolve, reject) => {reject(err);})
      });
    })
},
    keys(){
      return localforage.keys() // returns array of keys 
 
  },
  clear(){
    localforage.clear()
  }
};



//Returns a function, that, as long as it continues to be invoked, will not
//be triggered. The function will be called after it stops being called for
//N milliseconds. If `immediate` is passed, trigger the function on the
//leading edge, instead of the trailing. https://gist.github.com/nmsdvid/8807205
function debounce(func, wait, immediate) {
 var timeout;
 return function() {
     var context = this, args = arguments;
     clearTimeout(timeout);
     timeout = setTimeout(function() {
         timeout = null;
         if (!immediate) func.apply(context, args);
     }, wait);
     if (immediate && !timeout) func.apply(context, args);
 };
};

// https://stackoverflow.com/questions/36672561/how-to-exit-fullscreen-onclick-using-javascript
const Fullscreen={
    isInFullScreen(){
      return (document.fullscreenElement && document.fullscreenElement !== null) ||
      (document.webkitFullscreenElement && document.webkitFullscreenElement !== null) ||
      (document.mozFullScreenElement && document.mozFullScreenElement !== null) ||
      (document.msFullscreenElement && document.msFullscreenElement !== null);
    },
    toggle(){
      var docElm = document.documentElement;
      if (!this.isInFullScreen()) {
          if (docElm.requestFullscreen) {
              docElm.requestFullscreen();
          } else if (docElm.mozRequestFullScreen) {
              docElm.mozRequestFullScreen();
          } else if (docElm.webkitRequestFullScreen) {
              docElm.webkitRequestFullScreen();
          } else if (docElm.msRequestFullscreen) {
              docElm.msRequestFullscreen();
          }
      } else {
          if (document.exitFullscreen) {
              document.exitFullscreen();
          } else if (document.webkitExitFullscreen) {
              document.webkitExitFullscreen();
          } else if (document.mozCancelFullScreen) {
              document.mozCancelFullScreen();
          } else if (document.msExitFullscreen) {
              document.msExitFullscreen();
          }
      }
    },
    install: function(Vue){
      Object.defineProperty(Vue.prototype, '$fullscreen', {
        get () { return Fullscreen }
    })  }
};
Vue.use(Fullscreen);
Vue.use(Vuetify);
new Vuepoc().$mount('#app')
