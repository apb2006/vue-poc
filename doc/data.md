# Data storage
`core.js` defines settings
## Vuex

state.js

## Localforage
localforage.config({
  name: 'vuepoc'
});

### Other 
Global `settings` provides `getItem(name)` and `setItem(name,value)`
Example usage
```
 created: function () {
    settings.getItem('settings/ace')
    .then((v)=>{
      this.ace=v
    })

  },
  watch: {"ace":{
    handler:function(v){
      settings.setItem('settings/ace',this.ace)
      },
    deep:true
  } 

```