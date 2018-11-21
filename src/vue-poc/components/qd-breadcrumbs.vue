<!DOCTYPE html>
<!-- 
 bread crumb wrapper. crumbs = json array "[{},{}]"
 supports: text,
           to,
           icon,
           menu
 -->
<template id="qd-breadcrumbs">
		<v-breadcrumbs :items="crumbs" >
		    <template slot="item" slot-scope="props">
		        <v-breadcrumbs-item  :to="props.item.to" :disabled="props.item.disabled" :exact="true">
		        
		           <v-icon v-if="props.item.icon">props.item.icon</v-icon>
		                 {{ props.item.text }}
		                 <v-btn  icon v-if="props.item.menu" @click="$emit(props.item.menu)"
		                 :class="props.item.menu">
		                 <v-avatar>
				              <v-icon>arrow_drop_down</v-icon>
				              </v-avatar>
				            </v-btn>
				         
		         </v-breadcrumbs-item>
		     </template>
		</v-breadcrumbs>
</template>

<script>{
  props: ['crumbs'],
  created:function(){
      console.log("qd-crumbs");
    }
}
</script>
