# vue-poc

A test of using https://vuetifyjs.com/en/ as UI
Includes:

* material design (using `vuetify`)
* ace editor
* localforage for persistence

## Icons
* https://vuetifyjs.com/en/customization/icons/
## Tests

### Cypress

https://github.com/cypress-io/cypress
```
cd ~\git\vue-poc\tests>
npx cypress open

or...

npx cypress run
```
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
##