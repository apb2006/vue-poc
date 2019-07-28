<!DOCTYPE html>
<template id="select">
 <v-container fluid>
<v-card>
    <v-toolbar class="green darken-1">
    <v-card-title >
      <span class="white--text">Selection2</span>     
    </v-card-title>
    <v-spacer></v-spacer>    
       <v-btn  text icon @click="showInfo = !showInfo"><v-icon>info</v-icon></v-btn>
  </v-toolbar>

  <qd-panel :show="showInfo">
  

    <v-layout  slot="body" row wrap>
     
      <v-flex xs12 >
          <v-treeview
          v-model="tree"
          :open="open"
          :items="items"
          activatable
          item-key="name"
          open-on-click
        >
          <template slot="prepend" slot-scope="{ item, open, leaf }">
            <v-icon v-if="!item.file">
              {{ open ? 'mdi-folder-open' : 'mdi-folder' }}
            </v-icon>
            <v-icon v-else>
              {{ files[item.file] }}
            </v-icon>
          </template>
        </v-treeview> 
     </v-flex>
        
    <v-flex xs6>
    <p>some text</p>
   
  
     <v-autocomplete
              label="Select"
              v-bind:items="options"
              v-model="value"
               item-text="name"
              item-value="name"
              chips
              max-height="auto"
              clearable
              deletable-chips
            >      
           
       </v-autocomplete>
         <pre>{{$data.value }}</pre>
    </v-flex>

    <v-flex xs6 >
    <p>multi select</p>
    
      <v-select
              label="Select"
              v-bind:items="options"
              v-model="value2"
              item-text="name"
              item-value="name"
              multiple
              chips
              deletable-chips
              max-height="auto"
              autocomplete
            >v-select</v-select>
            <pre>{{$data.value2 }}</pre>
    </v-flex>
   
   </v-layout>
   
   <v-card slot="aside" flat> 
       <v-card-actions >
      <v-toolbar-title >test aside</v-toolbar-title>
      <v-spacer></v-spacer>    
       <v-btn text icon @click="showInfo = false"><v-icon>highlight_off</v-icon></v-btn>
    </v-card-actions>
    <v-card-text> 
 todo
  </v-card-text> 
    </v-card>
  </qd-panel>

</v-card-text>
<v-card>
 </v-container>
</template>

<script>{
  data: function(){
      return {
          value: null,
          value2: null,
          options: [],
          isLoading: false,
          showInfo:true,
          open: ['public'],
          files: {
            html: 'mdi-language-html5',
            js: 'mdi-nodejs',
            json: 'mdi-json',
            md: 'mdi-markdown',
            pdf: 'mdi-file-pdf',
            png: 'mdi-file-image',
            txt: 'mdi-file-document-outline',
            xls: 'mdi-file-excel'
          },
          tree: [],
          items: [
            {
              name: '.git'
            },
            {
              name: 'node_modules'
            },
            {
              name: 'public',
              children: [
                {
                  name: 'static',
                  children: [{
                    name: 'logo.png',
                    file: 'png'
                  }]
                },
                {
                  name: 'favicon.ico',
                  file: 'png'
                },
                {
                  name: 'index.html',
                  file: 'html'
                }
              ]
            },
            {
              name: '.gitignore',
              file: 'txt'
            },
            {
              name: 'babel.config.js',
              file: 'js'
            },
            {
              name: 'package.json',
              file: 'json'
            },
            {
              name: 'README.md',
              file: 'md'
            },
            {
              name: 'vue.config.js',
              file: 'js'
            },
            {
              name: 'yarn.lock',
              file: 'txt'
            }
          ]
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
          console.log("data::::",r.data);
          that.options=r.data.items;
          })
          .catch(function (error) {
            console.log(error);
            this.isLoading = false
            alert("Get query error")
          });
        }
      }
}

</script>
