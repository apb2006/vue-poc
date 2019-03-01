<!DOCTYPE html>
<!-- 
 show notifications
 -->
<template id="vp-notifications">
   <v-card>
         <v-toolbar class="amber white--text" scroll-off-screen>
                <v-toolbar-title >Notifications </v-toolbar-title>
                {{ $notification.nextId }}
                 <v-btn  @click="refresh" icon><v-icon>refresh</v-icon></v-btn>
          <v-spacer></v-spacer>
          <v-btn  @click="set(false)" icon><v-icon>close</v-icon></v-btn>
          </v-toolbar>
          <v-card-text>
        <v-list three-line>
          <template v-for="msg in $notification.messages" >
           <v-list-tile avatar  v-bind:key="msg.index" @click="">
              <v-list-tile-avatar>
                   <v-icon color="red">swap_horiz</v-icon>
              </v-list-tile-avatar>
              
             <v-list-tile-content>
              <v-list-tile-title>{{  msg.created | fromNow("from") }}</v-list-tile-title>
              <v-list-tile-sub-title v-html="msg.html">msg</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action-text>
              <v-chip>#{{ msg.index }}</v-chip>
           </v-list-tile-action-text>
            <v-list-tile-action-text v-if="msg.elapsed"> ({{ msg.elapsed }} ms) </v-list-tile-action-text>
            
           
            </v-list-tile>
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
