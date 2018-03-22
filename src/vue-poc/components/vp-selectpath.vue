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
  <v-menu :close-on-click="false"
      offset-x
      :close-on-content-click="false"
      :nudge-width="200"
      v-model="frmfav"
    >
      <v-btn slot="activator" @click.stop="set(!frmfav)" icon flat title="Add ">
      <slot>
      <v-icon>add_circle</v-icon>
       </slot>
       </v-btn>
       <v-card >
            <v-toolbar > 
        <v-card-title>
            Add a new tab
          </v-card-title>
          
          </v-toolbar>
          
         <v-card-text>
         Content:
          <v-tabs v-model="type" icons-and-text centered >
   
    <v-tab >
      Empty
      <v-icon>fiber_new</v-icon>
    </v-tab>
    <v-tab >
      XMLDB
      <v-icon>favorite</v-icon>
    </v-tab>
    <v-tab >
      Webfile
      <v-icon>account_box</v-icon>
    </v-tab>
    <v-tab-item>
      <v-card flat>
        <v-card-text>empty</v-card-text>
      </v-card>
    </v-tab-item>
     <v-tab-item>
      <v-card flat>
        <v-card-text>
            <v-text-field label="database url" v-model="xmldb"></v-text-field>
        </v-card-text>
      </v-card>
    </v-tab-item>
    <v-tab-item>
      <v-card flat>
        <v-card-text>
             <v-text-field label="webfile url" v-model="webfile"></v-text-field>
        </v-card-text>
      </v-card>
    </v-tab-item>
  </v-tabs>
         </v-card-text>
         
         <v-card-actions>
            <v-btn color="primary" flat @click.stop="set(false)">Cancel</v-btn>
            <v-spacer></v-spacer>
            <v-btn color="primary" flat @click.stop="favorite(); set(false)">Add tab</v-btn>
          </v-card-actions>
        </v-card>
   </v-menu>
</template>
<script>{ 
  props: { 
    frmfav: Boolean
  },
  data(){
    return {
      type: 0, 
      xmldb: "",
      webfile:""
      }
  },
  methods:{
    set(v){
      this.$emit('update:frmfav', v)
    },
    
    favorite(){
      this.$emit('selectpath', {
          type:this.type,
          name: "doc" + moment().format("YYYY-MM-DDThh:mm:ss") ,
          text:"Some text"
          })
    }
  }
}</script>
