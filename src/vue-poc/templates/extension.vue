<!DOCTYPE html>
<template id="extension">
 <v-container fluid>
  <v-layout >
 
  <table>
   <tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:3em;" @click="click(row,col)">{{cell}}</td>
   </tr>
  </table>
  </v-layout>
   
   <a href="http://homepages.cwi.nl/~steven/Talks/2017/06-10-iot/game-demo.html">demo</a>
 </v-container>
</template>

<script>{
  data:  function(){
    return {grid: [
      [1,5,8,12],
      [2,6,9,13],
      [3,7,10,14],
      [4,null,11,15] 
    ],
    empty:[3,1]
    }
  },
  methods: {
    click: function (row,col) {
      var g=this.grid
      var h=g[row][col]
      g[row][col]=null
      g[this.empty[0]][this.empty[1]]=h
      var e=[row,col]
      this.empty=e
      this.grid= g
      console.log("click",this.grid,e)
      this.$forceUpdate()
    }
  }
}

</script>
