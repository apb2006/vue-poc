//Manage array of text sources  used for:edit tabs
// item{
//     name:
//     contentType:
//     text:
//     id:
//     url:
//
const EditTabs=new Vue({
    data(){
      return {
                items:[],
                nextId: 1,
                currentId: null
            }
    },
    
    methods: {
      addItem(tab){
        console.log("new: ",tab);
        var def={name: "AA"+this.nextId, 
                 contentType: "text/xml",
                 mode: "xml",
                 text: "<foo>" +this.nextId +"</foo>",
                 url: null
                 };
        var etab = Object.assign(def,tab);
        etab.id= ""+this.nextId
        this.items.push (etab);
        this.nextId++;
        return etab;
      },
      
      closeItem(item){
        var index=this.items.indexOf(item);
        if (index > -1) {
          alert("index: "+index)
          this.items.splice(index, 1);
          index=(index==0)?0:index-1;
          this.currentId=(this.items.length)?"T"+this.items[index].id : null;
        }
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
        that=this
        Settings.getItem('edit/items')
        .then(function (v){
           console.log("items ",v)
           v.forEach(v =>that.addItem(v))
           })
         .catch(error=> {
             console.log(error);
             alert("load error")
           });   
      },
      
      sorted(){
        return this.items.slice(0).sort((a,b) => a.name.localeCompare(b.name))
      }
    }
});

