<template>
  <div>
    
    <button @click="getHolders">get holders tokens</button>
  </div>
</template>

<script>
import { api } from 'boot/axios'
import ContratoVenta from "../contratos/contratoVenta.js";
import Web3 from "web3/dist/web3.min.js";
export default {
    data() {
        return {
            cantAprobar: 0
        }
    },
  methods: {
    async getHolders() {
      web3 = new Web3(window.web3.currentProvider);
      var getTransofTokenByAddress = "https://api.covalenthq.com/v1/97/address/0xb1Aa6234BED697C3FF52060B16f5E6A7Fc464B27/transfers_v2/?quote-currency=USD&format=JSON&contract-address=0x24822536262f769CEB328ff61Edc4881e796332C&key=ckey_ebf3f9ab57b746cc9c5138b66a1"
      var getTrans = 'https://api.covalenthq.com/v1/97/address/0x24822536262f769CEB328ff61Edc4881e796332C/transactions_v2/?quote-currency=USD&format=JSON&block-signed-at-asc=true&no-logs=true&key=ckey_ebf3f9ab57b746cc9c5138b66a1'
      var getHoldersByAddress = 'https://api.covalenthq.com/v1/97/tokens/0x24822536262f769CEB328ff61Edc4881e796332C/token_holders/?quote-currency=USD&format=JSON&key=ckey_ebf3f9ab57b746cc9c5138b66a1'
     await api.get(getTransofTokenByAddress)
            .then( (result) => {
                console.log("result", result)

            } )

          /*  web3.eth.getPastLogs({ address:'0x24822536262f769CEB328ff61Edc4881e796332C'})
            .then(res => {
            res.forEach(rec => {
            console.log(rec.blockNumber, rec.transactionHash, rec.topics);
            });
            }).catch(err => console.log("getPastLogs failed", err));*/
        
    },
  },
  async mounted() {
  
  },
};
</script>
