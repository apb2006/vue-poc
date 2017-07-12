<!DOCTYPE html>
<template id="puzzle">
 <v-container fluid>
  <v-layout >
 
  <table>
   <tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:3em;" >
    <v-btn @click.native="click(row,col)" :disabled="disabled(row,col)">{{cell}}</v-btn>
    </td>
   </tr>
  </table>
   <br/>
   <table>
   <tr v-for="(item, row) in grid">
    <td v-for="(cell,col) in item" style="width:50px;height:50px;" >
    <v-btn @click.native="click(row,col)" :disabled="disabled(row,col)">
    <img :src="src(row,col)" style="width:50px;height:50px;"/>
</v-btn>
    </td>
   </tr>
  </table>
  </v-layout>
    Loosely inspired by <a href="http://homepages.cwi.nl/~steven/Talks/2017/06-10-iot/game-demo.html">demo</a>
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
    empty:[3,1],
    tiles:[{data:""}]
    }
  },
  methods: {
    click(row,col) {
      var g=this.grid
      var h=g[row][col]
      g[row][col]=null
      g[this.empty[0]][this.empty[1]]=h
      var e=[row,col]
      this.empty=e
      this.grid= g
      console.log("click",this.grid,e)
      this.$forceUpdate()
    },
    disabled(row,col){
      var ok=(row==this.empty[0]) && (col==this.empty[1]-1 ||col==this.empty[1]+1) 
      ok=ok || (col==this.empty[1]) && (row==this.empty[0]-1 ||row==this.empty[0]+1);
      return !ok 
    },
    gettiles(){
      HTTP.get("thumbnail/images")
      .then(r=>{
        this.tiles=r.data.items
        this.$forceUpdate()
        })
      
    },
    src(row,col){
      var v=this.grid[row][col]
      var d=""
      if(typeof this.tiles[v] !== 'undefined') d=this.tiles[v].data 
      
      return "data:image/jpeg;base64,"+d 
    }
   
  },
  created(){
    this.gettiles()
  }
}

</script>
