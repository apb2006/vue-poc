<!DOCTYPE html>
<!-- 
display button that invokes a  select path form
 emits selectpath event
  {  type:this.type,
      name: "Newname",
      text:"Some text"
      }
 -->
<template id="vp-selectpath">
   <v-dialog v-model="frmfav" persistent max-width="800">
      <v-btn slot="activator" @click.stop="set(!frmfav)" icon flat title="Add ">
      <slot>
      <v-icon>add_circle</v-icon>
       </slot>
       </v-btn>
       <v-card >
          <v-toolbar > 
               <v-card-title>
                Content of new tab {{type}}
              </v-card-title>
          </v-toolbar>
          
         <v-card-text>
         Content:
         
          <v-tabs v-model="type" icons-and-text centered >
             <v-tab v-for="item in protocols" :key="item.name">
              {{item.name}}
                <v-icon>{{item.icon}}</v-icon>
              </v-tab>
    
 
              <v-tab-item v-for="item in protocols" :key="item.name">
                <v-card flat>
                  <v-card-text>
                    <v-text-field v-for="f in item.fields" :key="f.model"
                    :label="f.label" :v-model="f.model"></v-text-field>
                  </v-card-text>
                </v-card>
              </v-tab-item>
          </v-tabs>
          
         </v-card-text>
        <v-card-actions>
               <v-spacer></v-spacer>
               <v-btn color="primary" flat @click.stop="set(false)">Cancel</v-btn>
               <v-btn color="primary" flat @click.stop="favorite(); set(false)">Add tab</v-btn>
         </v-card-actions>
        </v-card>
   </v-dialog>
</template>
<script>{ 
  props: { 
    frmfav: Boolean
  },
  data(){
    return {
      type: 0, 
      xmldb: "",
      webfile:"",
      protocols:[
        {name: "new",icon: "fiber_new",fields: [{label: "test gg", model: "webfile"}]},
        {name:"xmldb",icon:"favorite", fields: [{label: "test2", model: "webfile"}]},
        {name:"webfile",icon:"account_box", fields: [{label: "test3", model: "webfile"}]},
        {name:"file",icon:"fiber_new", fields: [{label: "test 4", model: "webfile"}]} 
        ]
      }
  },
  methods:{
    set(v){
      this.$emit('update:frmfav', v)
    },
    
    favorite(){
      this.$emit('selectpath', {
          type:this.protocols[this.type],
          uri: this.xmldb,
          name: "doc" + moment().format("YYYY-MM-DDThh:mm:ss") ,
          text:"Some text"
          })
    }
  }
}</script>
