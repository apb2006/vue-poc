<!DOCTYPE html>
<!-- 
 show notifications
 -->
<template id="vp-notifications">
   <v-card>
         <v-app-bar dense class="amber white--text" >
              <v-toolbar-title > {{ $notification.nextId }} Notifications </v-toolbar-title>           
              <v-btn  @click="refresh" icon><v-icon>refresh</v-icon></v-btn>
	          <v-spacer></v-spacer>
	          <v-btn  @click="set(false)" icon><v-icon>close</v-icon></v-btn>
          </v-app-bar>
          
          <v-card-text>
        <v-list three-line>
          <template v-for="msg in $notification.messages" >
           <v-list-item  v-bind:key="msg.index" @click="">
              <v-list-item-avatar>
                   <v-icon color="red">swap_horiz</v-icon>
              </v-list-item-avatar>
              
             <v-list-item-content>
              <v-list-item-title>{{  msg.created | fromNow }}</v-list-item-title>
              <v-list-item-subtitle v-html="msg.html">msg</v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action-text>
              <v-chip>#{{ msg.index }}</v-chip>
           </v-list-item-action-text>
            <v-list-item-action-text v-if="msg.elapsed"> ({{ msg.elapsed }} ms) </v-list-item-action-text>
            
           
            </v-list-item>
           </template>
         </v-list>
      </v-card-text>

      </v-card>
</template>

<script>{
  props: { 
    showNotifications: Boolean
  },
  data:function(){
    return {timer:null};
  },
  methods:{
    set(v){
      this.$emit('update:showNotifications', v)
    },
    refresh(){
      this.$forceUpdate();
    }
  },
  watch:{showNotifications(v){
    if(v){
       this.refresh();
       if(!this.timer) this.timer=setInterval(()=>{ this.refresh() }, 1000);
    }
  },
  beforeDestroy(){
    if(this.timer) clearTimeout(this.timer);
    alert("notifi gone")
  }
    
  }
}</script>
