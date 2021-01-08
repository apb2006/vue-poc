//Manage array of text sources  used for:edit tabs
// item{
//     name: file name
//     contentType: "text/xml",
//     mode: "xml",
//     text:
//     id: ids have the form "Tn"
//     uri: path to save to
// requires: Settings,HTTP
//
const GEditTabs={
    data(){
      return {
                items:[],
                length: 0,
                nextId: 1,
                currentId: null,
                restored: null
            }
    },
    
    methods: {
      // add tab return index
      addItem(tab,pos){
        //console.log("new: ",tab," ,pos:",pos);
        var def={name: "AA"+this.nextId, 
                 contentType: "text/xml",
                 mode: "xml",
                 text: "<foo>" +this.nextId +"</foo>",
                 uri: null
                 };
        var etab = Object.assign(def,tab);
        etab.id= "T" + this.nextId
        if(pos){
          this.items.splice(pos, 0, etab)
        }else{
          this.items.push (etab);
        }
        this.length++
        this.nextId++;
        var ind=this.items.indexOf(etab)
        return ind;
      },
      
      closeItem(item){
        //https://github.com/vuejs/vue/issues/5855
        this.items=this.items.filter(t => t.id !== item.id)
        this.length--;
      },
      
      // fetch content from server and create tab
      loadItem(url){
        HTTP.get("get",{params: {url:url}})
        .then(r=>{
            console.log(r)
            var tab={
              text: ""+ r.data.data,
              url: url,
              name: url.split(/.*[\/|\\]/)[1]
            };
            this.addItem(tab);
          })
          .catch(error=> {
            console.log(error);
            alert("Get query error:\n"+url)
          });
      },
      
      save(){
        Settings.setItem('edit/items',this.items);
      },
      
      restore(){
        var that=this
        this.restored=Settings.getItem('edit/items')
        .then(function (v){
           //console.log("items ",v)
           v.forEach(v =>that.addItem(v))
           })
         .catch(error=> {
             console.log(error);
             alert("load error")
           });   
      },
      
      sorted(q){ /* return sorted and filtered array of tab indices */
        var len=this.items.length
        var indices = new Array(len);
        for (var i = 0; i < len; ++i) indices[i] = i;
        var list=this.items;
        indices=indices.filter(a=>(!q) || list[a].name.toLowerCase().includes(q.toLowerCase()))
        indices.sort((a,b) =>list[a].name.localeCompare(list[b].name))
        return indices
      }
    },
    created(){
      console.log("EditTabs created")
    }
};

