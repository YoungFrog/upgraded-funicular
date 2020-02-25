<template>
<div id="app">
  <div v-if= "this.humbug.board.squares.length">
    Number of moves : <input type="number" v-model.number="humbug.nMoves">
    
    <table id="squares" class="table">
      <tr v-for="(line, i) in humbug.board.squares" v-bind:key="`line-${i}`" class="row">
        <td v-for="(square, j) in line" v-bind:key="`square-${i}-${j}`" class="column">
          <select v-model="square.type">
            <option v-for="type in squareTypes"
                    :name="type"
                    :key="type"
                    >{{type}}</option>
          </select>
        </td>
      </tr>
    </table>
  </div>
    
    <div v-if="this.humbug.board.squares.length == 0">
      Number of rows : <input type="number" v-model="nRows">
      Number of columns : <input type="number" v-model="nCols">
      
      Reset to given dimensions : <button type="button" @click="resetSize">Define number of rows and columns</button>
    </div>
  <div id="vjp">
    <vue-json-pretty :data="javaJson"
                     :show-line="false">
    </vue-json-pretty>
  </div>
</div>
</template>

<script>
import VueJsonPretty from 'vue-json-pretty'

export default {
    name: 'App',
    components: {
        VueJsonPretty
    },
    methods: {
        resetSize() {
            let squares= [];
            for (let i = 0; i < this.nRows; i++) {
                let line = [];
                for (let j = 0; j < this.nCols; j++) {
                    line.push({});
                }
                squares.push(line);
            }
            this.humbug.board.squares = squares;
        }
        
    },
    computed:  {
        javaJson() {
            let current = this.humbug;
            let newJson = {
                board: { squares: [] },
                animals: [],
                nMoves: current.nMoves
            };
            let iLine = 0;
            for (let line of current.board.squares) {
                let iCol = 0;
                let newLine = [];
                for (let square of line) {
                    let newSquare = null;
                    let curType = square.type;
                    switch (square.type) {
                    case 'GRASS':
                    case 'STAR':
                        newSquare = { type: curType };
                        break;
                    case undefined:
                        break;
                    default: // animal
                        newSquare = { type: "GRASS" };
                        newJson.animals.push({type: curType, positionOnBoard: { row: iLine, column: iCol } })
                        break;
                    }
                    newLine.push(newSquare);
                    iCol++;
                }
                newJson.board.squares.push(newLine);
                iLine++;
            }
            
            return newJson;
        }
    },
    data: function () {
        return {
            nRows: 4,
            nCols: 3,
            squareTypes: ["GRASS", "STAR", "Snail", "Grasshopper", "Spider"],
            humbug: {
                "board": {
                    "squares": []
                },
                "nMoves": 4
            }
        }
        
    }
}
</script>

<style>
#app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
}
#vjp {
    border: 3px solid black;
    text-align: left;
}
</style>
