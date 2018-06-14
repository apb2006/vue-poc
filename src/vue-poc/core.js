// base -----------------------

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

// time requests

// Add a response interceptor
axios.interceptors.response.use(function (response) {
    // Do something with response data
  //console.log("AXIOS",response);
    return response;
  }, function (error) {
    // Do something with response error
    return Promise.reject(error);
  });

// errors displayed by interceptor
const HTTP = axios.create(AXIOS_CONFIG);
HTTP.interceptors.request.use((config) => {
  config.qdStartTime=performance.now();
  return config;
});
HTTP.interceptors.response.use((response) => {
  // Do something with response data
  if(response.config && response.config.qdStartTime){
    var s=Math.floor(performance.now() - response.config.qdStartTime);
    var c=response.config;
    var url=response.config.url + "?" + c.paramsSerializer(c.params);
    //console.log("interceptors time:",s, response.config);
    var b=`<a href="${url}" target="vp-notification" >${url}</a> Time: ${s}`
    Notification.add(b);
  }
  return response;
});

// errors hidden
const HTTPNE = axios.create(AXIOS_CONFIG);
const axios_json={ headers: {accept: 'application/json'}};


// Authorization Object
const Auth={
    user:"guest",
    permission:null,
    install: function(Vue){
        Object.defineProperty(Vue.prototype, '$auth', {
          get () { return Auth }
      })  }
};
Vue.use(Auth);

//Notification Object
const Notification={
    messages:[],
    nextId: 0,
    unseen:0,
    add(msg){
      var data={
          text: msg,
          index: ++this.nextId,
          created: new Date()
      };
      this.messages.unshift(data);
      this.messages.length = Math.min(this.messages.length, 30);
      ++this.unseen;

    },
    install(Vue){
        Object.defineProperty(Vue.prototype, '$notification', {
          get () { return Notification }
      })  }
};
Vue.use(Notification);


// Settings read and write list clear
localforage.config({
  name: 'vuepoc'
});
// https://vuejs.org/v2/guide/state-management.html
var settings = {
    debug: false,
    defaults:{
      
      "settings/ace": {
                      theme: "github",
                      keybinding: "ace",
                      fontsize: 16,
                      enableSnippets:true,
                      enableBasicAutocompletion:true,
                      enableLiveAutocompletion:true
                      },
        
       "features/serviceworker": true,
       "edit/items":[
         {name:"web.txt", id:"1", mode:"text", dirty: false, 
           text:`Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi 
ut aliquip ex ea commodo consequat.`},
       
         {name:"Shopping.xq", id:"2", mode: "xquery" ,dirty: false,
           text:`let $a:=1 to 5
return $a   `},
      
         {name:"videos.xml", id:"3", mode:"xml",dirty: false, location: "/aaa/bca/",
           text:`<foo version="1.0">
  <node>hello</node>
</foo>`}
       ],
       "edit/currentId": "?",
       "system/serviceworker": true
    },
    
    
    
    getItem (key) {
      if (this.debug) console.log('getItem',key);
      return localforage.getItem(key)
        .then(value => {
          value=value?value:this.defaults[key];
          //console.log('GET setting', key,value);
          return value;
     
        }).catch(err => {
          console.log('GET failed');

      });
    },
    setItem (key,value) {
      if (this.debug) console.log('setItem',key,value);
      return localforage.setItem(key, value) 
      .then(value => {
        //console.log('SET ',key, value);
        return value
        
      }).catch(err => {
        console.log('set failed');
      });
   },
    keys(){
      return localforage.keys() // returns array of keys 
 
  },
  clear(){
    localforage.clear()
  }
};

// error help 
// https://stackoverflow.com/questions/18391212/is-it-not-possible-to-stringify-an-error-using-json-stringify/18391400#18391400
if (!('toJSON' in Error.prototype))
  Object.defineProperty(Error.prototype, 'toJSON', {
      value: function () {
          var alt = {};

          Object.getOwnPropertyNames(this).forEach(function (key) {
              alt[key] = this[key];
          }, this);

          return alt;
      },
      configurable: true,
      writable: true
  });

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

Vue.component('treeselect', VueTreeselect.Treeselect);

//Vue.use( VueFormJsonSchema);
function install (Vue) {
 Vue.component('vue-form-json-schema', VueFormJsonSchema);
};
Vue.use({ install: install });

//leaflet
//Vue.component('v-map', Vue2Leaflet.Map);
//Vue.component('v-tilelayer', Vue2Leaflet.TileLayer);
//Vue.component('v-marker', Vue2Leaflet.Marker);
//function install (Vue) {
//  Vue.component('form-schema', window["vue-json-schema"].default);
//};
//Vue.use({ install: install });
Vue.use(Vuetify);
new Vuepoc().$mount('#app')
