# vue-poc

A test of using https://vuetifyjs.com/en/ as UI
Includes:

* material design (using `vuetify`)
* ace editor
* localforage for persistence

## Icons
* https://material.io/resources/icons/?style=baseline
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
Required BaseX options https://docs.basex.org/wiki/Options
```
CHOP = false
LOGTRACE = false
RESTXQERRORS = false
GZIP = true
```
### Other 
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