<!DOCTYPE html>
<template id="xqdoc">
 <v-container fluid>
    <v-card >
     <v-toolbar  class="orange darken-1">
     <v-btn icon to="/tasks"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
      <span class="white--text">Task: Generate <code>xqdoc</code></span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn  color="primary"  @click="submit()"   :loading="waiting"
      :disabled="waiting">
      <v-icon>play_circle_outline</v-icon>
      Run</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid>
        <v-layout row wrap>
          
          <v-flex xs12>
            <v-text-field    v-model="params.efolder"
              label="Root Folder containing xq files"
            ></v-text-field>
          </v-flex>
        
          <v-flex xs12>
            <v-text-field v-model="params.target"
              label="Path for xqdoc files"  
            ></v-text-field>
          </v-flex>
        
        </v-layout>
  
      </v-container>
    </v-card-text>
   
     
    <v-alert color="success" v-model="alert.success">
    {{alert.timestamp}}:{{alert.msg}}
    </v-alert>
     <v-alert color="error" v-model="alert.error">
    {{alert.timestamp}}:<code>{{alert.msg}}</code>
    </v-alert>
  </v-card>
  <code>{{code}}</code>
 </v-container>
</template>

<script>{
  data:  function(){
    return {
      params:{
			      efolder:"C:/Users/andy/git/graphxq/src",
			      target:"C:/tmp/xqdoc/"
			 },
			waiting:false,
			alert:{msg:"",success:false,error:false},
    }
  },
  methods:{
    submit(){
      this.waiting=true
      this.alert={msg:"Loading..",success:false,error:false}
      HTTP.post("tasks/xqdoc",Qs.stringify(this.params))
      .then(r=>{
        this.waiting=false      
        this.alert={msg:r.data.msg,success:true,error:false}
        console.log(r.data)
         settings.setItem('tasks/xqdoc',this.params)
      })
      .catch(error=>{
        this.waiting=false
        this.alert={msg:error.response.data,success:false,error:true}
        console.log(error);
        alert("bad")
      });
   }
  },
  created: function () {
    settings.getItem('tasks/xqdoc')
    .then((v)=>{
      if(v)this.params=v
    })
  },
  
  computed:{
    code(){return 'generate xqdoc'}
  }
}
</script>
