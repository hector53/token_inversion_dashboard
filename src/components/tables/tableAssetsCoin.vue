<template>
    <q-table flat  :rows="arrayWallets" v-if="arrayWallets.length>0" :columns="columns" hide-bottom>
    </q-table>
    <q-spinner
    style="width: 100%; text-align:center"
        color="primary"
        size="3em"
        :thickness="10"
        v-else
      />
</template>

<script>
import {defineComponent} from 'vue'
import ContratoVenta from "../../contratos/contratoVenta.js";


const columns = [
  {name: 'address', label: 'Address', field: 'address', sortable: true, align: 'left'},
  {name: 'price', label: 'Price', field: 'price', sortable: true, align: 'left'},
  {name: 'value', label: 'Value', field: 'value', sortable: true, align: 'left'},
  {name: 'balance', label: 'Balance ', field: 'balance', sortable: false, align: 'center'}
];


export default defineComponent({
  name: "TableActions",

  data() {
    return {
      spinnerLoading: true,
      arrayWallets: [], 
      columns: [
  {name: 'address', label: 'Address', field: 'address', sortable: true, align: 'left'},
  {name: 'price', label: 'Price', field: 'price', sortable: true, align: 'left'},
  {name: 'value', label: 'Value', field: 'value', sortable: true, align: 'left'},
  {name: 'balance', label: 'Balance ', field: 'balance', sortable: false, align: 'center'}
]
       
    }
  },

  methods: {
    
  },
  async mounted() {
    await   ContratoVenta.loadWeb3()
    await ContratoVenta.loadContractToken()
    var address = "0x5982CB141d0F6E9aACE7Acc61CaD0ABB6256b7FE"
    var balance = await ContratoVenta.hectorToken.balanceOf(address)
    console.log("balance", parseInt(balance))

    try{
    const result = await this.$store.dispatch('myStore/get_wallets_user')
    console.log(result)
    if(result.status == 1){
        for(var i=0; i<result.wallets.length; i++){
          console.log(result.wallets[i])
           var balance = await ContratoVenta.hectorToken.balanceOf( result.wallets[i].address )
           balance = balance /10**18
          this.arrayWallets.push({
            address: result.wallets[i].address,
            price: 1.000,
            value: balance,
            balance: balance * 1,
          })
        }
    }
    }catch(e){
    console.log("Error:")
    console.log(e)
    }


  },
})
</script>

<style scoped>

</style>
