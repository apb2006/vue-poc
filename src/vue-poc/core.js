// base -----------------------

const AXIOS_CONFIG={
    baseURL: "/vue-poc/api/",
    headers: {
      'X-Custom-Header': 'vue-poc'
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
HTTP.interceptors.request.use(
		(config) => {
                config.qdStartTime=performance.now();
                return config;}
);

HTTP.interceptors.response.use(
		(response) => {
			  // Do something with response data
			  if( response && response.config && response.config.qdStartTime){
				var s=Math.floor(performance.now() - response.config.qdStartTime);  
				response.headers["X-response-ms"]= s // custom header
				//console.log("AXIOS H:",response.headers)
			   
			    var c=response.config;
			    var url=response.config.url + "?" + c.paramsSerializer(c.params);
			    //console.log("interceptors time:",s, response.config);
			    var b=`<a href="${url}" target="vp-notification" >${url}</a>`
			    Notification.add({html: b, elapsed: s});
			  }
			  return response;
			}
);


// errors hidden
const HTTPNE = axios.create(AXIOS_CONFIG);
const axios_json={ headers: {accept: 'application/json'}};


// Settings read and write list clear
localforage.config({
  name: 'vuepoc'
});
// https://vuejs.org/v2/guide/state-management.html
var Settings = {
    debug: false,
    defaults:{
      
      "settings/ace": {
                      theme: "github",
                      themeDark: "chaos",
                      keybinding: "ace",
                      fontsize: 16,
                      enableSnippets:true,
                      enableBasicAutocompletion:true,
                      enableLiveAutocompletion:true
                      },
       "settings/dark": false,
       "features/serviceworker": false,
       "edit/items":[
         {name:"web.txt", id:"1", mode:"text", dirty: false, 
           text:`Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi 
ut aliquip ex ea commodo consequat.`},
       
         {name:"shopping.xq", id:"2", mode: "xquery" ,dirty: false,
           text:`let $a:=1 to 5
return $a   `},
      
         {name:"videos.xml", id:"3", mode:"xml",dirty: false, uri: "xmldb:/vue-poc/aaa/bca/videos.xml",
           text:`<foo version="1.0">
  <node>hello</node>
</foo>`}
       ],
       "edit/currentId": "?",
       "images/thumbtask":`
<thumbnail>
    <size width="200" height="200"/>
    <filters>             
        <colorize color="green" alpha=".5"/>      
        <caption position="CENTER">Some Text here</caption>
        <rotate angle="15"/>
        <canvas height="300" width="300" position="TOP_LEFT" color="yellow"/> 
    </filters>
    <output format="gif"/>         
</thumbnail>
`,
      "edit/query": "todo edit/query"
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
   
   removeItem (key) {
     if (this.debug) console.log('deleteItem',key);
     return localforage.removeItem(key) 
     .then(value => {
        console.log('deleted ',key);
       
     }).catch(err => {
       console.log('delete failed');
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

Vue.component('treeselect', VueTreeselect.Treeselect);

var sockhost=('https:'==window.location.protocol?'wss:':'ws:')+'//'+ window.location.host +'/ws';
//Vue.use(VueNativeSock.default, sockhost);
//console.log("SOCK UP",VueNativeSock,sockhost);




//function install (Vue) {
//  Vue.component('form-schema', window["vue-json-schema"].default);
//};
//Vue.use({ install: install });
var EditTabs=new Vue(GEditTabs)
Vue.use(Vuetify);
Vue.use(VueMarkdown);
new Vuepoc().$mount('#app')
