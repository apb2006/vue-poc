<!DOCTYPE html>
<template id="logadd">

 <v-card >
    <v-toolbar class="orange darken-1">
     <v-btn icon to="./"><v-icon>arrow_back</v-icon></v-btn>
     <v-card-title >
      <span class="white--text">Create log entry</span>      
    </v-card-title>
      <v-spacer></v-spacer>
     <v-btn
      :disabled="!valid"
      @click="submit"
    >
      submit
    </v-btn>
    <v-btn @click="clear">clear</v-btn>
    </v-toolbar>
    <v-card-text>
      <v-container fluid>
<v-form ref="form" v-model="valid" lazy-validation>
    <v-text-field
      v-model="name"
      :rules="nameRules"
      :counter="10"
      label="Name"
      required
    ></v-text-field>
   
    <v-select
      v-model="type"
      :items="types"
      :rules="[v => !!v || 'type is required']"
      label="Type"
      required
    ></v-select>
    <v-checkbox
      v-model="checkbox"
      label="Add more?"

    ></v-checkbox>

   
  </v-form>
 </v-container>
 </v-card-text>
 </v-card>

</template>

<script>{
  data: () => ({
    valid: true,
    name: '',
    nameRules: [
      v => !!v || 'Name is required',
      v => (v && v.length <= 10) || 'Name must be less than 10 characters'
    ],
    
    type: "INFO",
    types: [
      'INFO',
      'TEST'
    ],
    checkbox: false
  }),

  methods: {
    submit () {
      if (this.$refs.form.validate()) {
        // Native form submission is not yet supported
         HTTP.post("log/add",{
             name: this.name,
             type: this.type,
             checkbox: this.checkbox
           })
      .then(r=>{
        alert("ok")
        })
      }
    },
    clear () {
      this.$refs.form.reset()
    }
  },
 mounted:function(){
    console.log("logadd",this.$route.path)
  }
}
</script>
