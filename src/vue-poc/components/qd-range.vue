<!DOCTYPE html>
<!-- 
 dropdown with dice range
   props
    'query' object with start and limit
 -->
<template id="qd-range">
  <v-menu left bottom  :close-on-content-click="false" >
  <template v-slot:activator="{ on }">
    <v-chip  v-on="on"> 
    Range
      <v-icon right>arrow_drop_down</v-icon>
    </v-chip>
   </template>
      
   <v-card>
    <v-card-title  class="headline grey lighten-2" primary-title>Range</v-card-title>
     
	<v-card-text>
	 <v-text-field  type="number" v-model.number="query.window"  label="window (secs)" > </v-text-field>
	 <v-text-field  type="number" v-model.number="query.start"  label="start" > </v-text-field>
    <v-text-field  type="number" v-model.number="query.limit"  label="limit" > </v-text-field> 
  </v-card-text>
  <v-card-actions>
  <v-btn>Reset</v-btn>
  </v-card-actions>
</v-card>
</v-menu>
</template>

<script>{
  props: ['query' ]
}</script>
