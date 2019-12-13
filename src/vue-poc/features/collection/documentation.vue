<!DOCTYPE html>
<template id="documentation">
 <v-container fluid grid-list-md>
    <v-data-iterator
      :items="items"
      :items-per-page.sync="itemsPerPage"
      :search="search"
      hide-default-footer
    >

   <template v-slot:header>
        <v-toolbar>
       <v-toolbar-title>XQDocs</v-toolbar-title>
        <v-spacer></v-spacer>
          <v-text-field
            v-model="search"
            clearable
            flat
            solo-inverted
            hide-details
            prepend-inner-icon="search"
            label="Search"
          ></v-text-field>
           <v-spacer></v-spacer>
           <router-link :to="{path:'/tasks/xqdoca'}">
              <v-icon>add_circle</v-icon>
           </router-link>
           <v-btn @click="get" icon :loading="loading"
	      :disabled="loading"
	   ><v-icon>refresh</v-icon></v-btn>
          </v-toolbar>
      </template>
          
      <template v-slot:default="props">
        <v-layout wrap>
          <v-flex
            v-for="item in props.items"
            :key="item.name"
            xs12
            sm6
            md4
            lg3
          >
            <v-card    :hover="true"  >
		           <v-toolbar  color="blue lighten-3"  dense>
			           <v-card-title >{{ item.name }}</v-card-title>
			           <v-spacer></v-spacer>
			           <a :href="item.href" target="_new">go</a>
		           </v-toolbar>
		           <v-card-text>{{ item.id }}</v-card-text>
		            <v-card-text>
		              <span :title="item.created">{{ item.created | fromNow }}</span>
		              
		            </v-card-text>
		           <v-card-actions>
		           <v-btn>Run</v-btn>
		           </v-card-actions>
           </v-card>
            
          </v-flex>
        </v-layout>
      </template>

    </v-data-iterator>
  </v-container>
</template>

<script>{
  data:  function(){
    return {
      itemsPerPage: 100,
      page: 1,
      items:[],
      search: '',
      filter: {},
      loading: false
      }
  },
  methods:{
    get() {
      this.loading=true;
      HTTP.get('xqdocjob')
      .then((res) => {
        this.items = res.data;
        this.loading=false;
      });
    },
    doEdit(item){
      console.log("history: ",item)
        router.push({ path: 'edit', query: { url:item.url, protocol:item.protocol  }})
    }
  },
  created:function(){
    this.get()
    console.log("history")
  }
}
</script>
