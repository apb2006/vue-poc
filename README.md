# Vue-poc

An experiment using https://vuetifyjs.com/en/ as UI for BaseX
Includes:

* material design (using `vuetify`)
* ace editor
* localforage for persistence

## Topics
* [Basex requirements](doc/basex.md)
* [Testing](doc/testing.md)
* [Vuetify](doc/vuetify.md)
* [data](doc/data.md)
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
##