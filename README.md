# vue-poc

A test of using `vue.js` as UI
Includes:
* material design (using `vuetify`)
* ace editor
* localforage for persistence

Edit via android 

## Settings
Global `settings` provides `getItem(name)` and `setItem(name.value)`
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