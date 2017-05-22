const Home = Vue.extend({  template: '#home'});

const Options = Vue.extend({  
  template: '#heart',
  data: function(){
    return {
        snackbar:false
    }
  }
    });

const Select = Vue.extend({
  template: '#select',
  components: { multiselect: VueMultiselect.Multiselect}, 
  data: function(){
      return {
          value: null,
          value2: null,
          options: [],
          isLoading: false
      }
    },
    created:function(){
      this.asyncFind("")
    },
    methods: {
      asyncFind: function(query){
        this.isLoading = true
        that=this;
        HTTP.get("test-select?q="+query,axios_json)
        .then(function(r){
          that.isLoading = false
          that.options=r.data.items;
          })
          .catch(function (error) {
            console.log(error);
            this.isLoading = false
            alert("Get query error")
          });
        }
      }
});

const People = Vue.extend({
  template: '#people',
  data:  function(){
    return {message: 'Hello Vue.js!'}
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
});

const Search = Vue.extend({
  template: '#search',
  data:  function(){
    return {
      message: 'Hello Vue.js!',
      q:this.$route.query.q
      }
  },
  created:function(){
    console.log("Serch",this.$route.query.q)
  }
});

const Edit = Vue.extend({
  template: '#edit',
  data () {
    return {
      contentA: 'declare function local:query($q as xs:string)\n{\n<json   type="object" >}',
      mode:'xquery',
      url:'',
      name:'',
      path:[],
      wrap:false,
      busy:false,
      clearDialog:false,
      annotations:null
    }
  },
  methods: {
    reset () {
        this.contentA = 'reset content for Editor A'
    },
    changeContentA (val) {
        if (this.contentA !== val) {
        this.contentA = val
      }
    },
    // load from url
    fetch(url){
      this.busy=true
      HTTP.get("raw?url="+url,axios_json)
      .then(r=>{
        //console.log(r)
        var a=acetype(r.data.mimetype)
        this.mode=a
        this.contentA=r.data.data
        var a=url.split("/")
        this.url=url
        this.name=a.pop()
        this.path=a
        this.busy=false
        //alert(mode)
        })
        .catch(error=> {
          console.log(error);
          this.busy=false
          alert("Get query error"+url)
        });
      
    },
    acecmd(cmd){
      Events.$emit('eventFired',cmd);
    },
    fold(){
      Events.$emit('eventFired',"foldall");
    },
    save(){
      alert("TODO save: "+this.path.join("/"));
    },
    showfiles(){
           router.push({ path: 'files', query: { url: this.path.join("/") }})
    },
    beautify(){
      this.busy=true
      var a=this.contentA
      switch(this.mode) {
      case "html":
      case "xml":  
          a=html_beautify(a, { indent_size: 3 ,indent_inner_html:true})
          break;
      case "javascript":
           a=js_beautify(a, { indent_size: 2 })
          break;
      case "css":
         a=css_beautify(a, { indent_size: 2 })
         break;     
      default:
        alert("beaut: " + this.mode)
     } 
      this.contentA=a
      this.busy=false
    },
    annotation(counts){
      this.annotations=counts
    }
  },
  created:function(){
    var url=this.$route.query.url
    console.log("Edit: ",url)
    if(url) this.fetch(url)
  }
});

const Files = Vue.extend({
  template: '#files',
  data:  function(){
    return {url: ".",
            folders:[],
            files:[],
            items:["root"]
    }
  },
  methods:{
    click (val) {
   // with query, resulting in /register?plan=private
      router.push({ path: 'edit', query: { url: this.url+"/" +val }})
    },
    folder (val) {
      this.url+="/"+ val
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    },
    load(url){
      HTTP.get("file?url="+url,axios_json)
      .then(r=>{
        console.log(r)
        this.folders=r.data.folders
        this.files=r.data.files
        })
        .catch(error=> {
          console.log(error);
          alert("Get query error"+url)
        });
      
    },
    root(){
      this.url="."
      this.$router.push({  query: { url: this.url }})
      this.load(this.url)
    }
  },
  created:function(){
    var url=this.$route.query.url
    this.url=url?url:".";
    console.log("files: ",this.$route.query.url)
    this.load(this.url)
  }
});

const Stepper = Vue.extend({
  template: '#stepper',
  data:  function(){
    return {e6: 0}
  }
});
// base -----------------------
const HTTP = axios.create({
  baseURL: "/vue-poc/api/",
  headers: {
    'X-Custom-Header': 'vue-poc',
    accept: 'application/json'
  }
});
const axios_json={ headers: {accept: 'application/json'}};


function acetype(mime){
  const mimemap={
      "text/xml":"xml",
      "application/xml":"xml",
      "application/xquery":"xquery",
      "text/ecmascript":"javascript",
      "text/html":"html"
  };
  var r=mimemap[mime]
  return r?r:"text"
};

Vue.component('my-component', {
  template: '<div>A custom component!</div>',
    created:function(){
      console.log("my-component");
    },  
});

var Events = new Vue({});


const router = new VueRouter({
  base:"/vue-poc/ui/",
  mode: 'history',
  routes: [
    { path: '/', component: Home },
    { path: '/people', component: People ,meta:{title:"People"}},
    { path: '/options', component: Options,meta:{title:"Options"} },
    { path: '/select', component: Select,meta:{title:"Select"} },
    { path: '/search', component: Search,meta:{title:"Search"} },
    { path: '/edit', component: Edit,meta:{title:"Ace editor"} },
    { path: '/stepper', component: Stepper,meta:{title:"Stepper"} },
    { path: '/files', component: Files,meta:{title:"Files"} } 
  ],
});
router.afterEach(function(route) {
  document.title = (route.meta.title?route.meta.title:"") + " VUE-Poc";
});

Vue.use(Vuetify);
const app = new Vue({
  router,
  data:function(){return {
    q:"",
    sidebar:false,
    items: [{
      href: '/',
      router: true,
      title: 'Home',
      icon: 'home'    
    }, {
      href: 'files',
      router: true,
      title: 'files',
      icon: 'folder' 
    }, {
      href: 'edit',
      router: true,
      title: 'edit',
      icon: 'mode_edit'    
    }, {
      href: 'search',
      router: true,
      title: 'search',
      icon: 'search'
  }, {
      href: 'people',
      router: true,
      title: 'People',
      icon: 'person'      
   }, {
      href: 'select',
      router: true,
      title: 'select',
      icon: 'extension'
  }, {
      href: 'options',
      router: true,
      title: 'options',
      icon: 'domain'
 
}, {
  href: 'stepper',
  router: true,
  title: 'stepper',
  icon: 'picture_in_picture'
}]
  }},
  methods: {
      openSidebar() {
          this.sidebar = !this.sidebar;
      },
      search(){
        this.$router.push({path: 'search',query: { q: this.q }})
      }
  }
  }).$mount('#app');
