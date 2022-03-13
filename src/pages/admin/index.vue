<template>
    <button @click="repartirGanancias">
        repartir ganancias 
    </button>
</template>

<script>
import Web3 from "web3/dist/web3.min.js";
import ContratoVenta from "../../contratos/contratoVenta.js";
    export default {
        methods: {
            
            repartirGanancias(){
                console.log("repartir ganancias clic")
              /*  var base = 1+0.22; 
                var exponente = 1/52; 
                var formula = Math.pow(base, exponente) - 1;
                console.log("formula", parseInt(formula*1000000))
                console.log(window.web3.currentProvider)*/
                ContratoVenta.tokenFintUsd
                .repartirGanancias({    
                from: this.$store.state.myStore.currentAccount,
                value: 0,
                })
              
            }
        },
    }
</script>

