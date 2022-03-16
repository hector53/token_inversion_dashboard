<template>
  <div>
    <q-btn
      class="text-capitalize btnComprarToken"
      style="margin-top: 20px"
      flat
      text-color="white"
      unelevated
      :icon="iconFondo"
      @click="iniciarVesting"
      >{{ btnVestingText }}</q-btn
    >
  </div>
</template>

<script>
import ContratoVenta from "../../contratos/contratoVenta.js";
import { Loading } from "quasar";
export default {
  data() {
    return {
      btnVestingText: "",
      btnVesting: false,
      iconFondo: 'lock'
    };
  },
  methods: {
      async addVestingDb(addr){
     try {
        const result = await this.$store.dispatch(
          "myStore/iniciarVesting", {"addr": addr}
        );
        console.log(result);
       
      } catch (e) {
  
        console.log("Error:");
        console.log(e);
      }
  },
  async deleteVestingDb(addr){
    
     try {
        const result = await this.$store.dispatch(
          "myStore/deleteVesting", {"addr": addr}
        );
        console.log(result);
       
      } catch (e) {
  
        console.log("Error:");
        console.log(e);
      }

  },
    transactionReceipt(receipt) {
        Loading.hide()
      console.log("receipt", receipt);
      if (receipt.logs[0].event == "iniciarVesting") {
        //inicie vesting
        if (receipt.status == true) {
          this.btnVesting = true;
          this.btnVestingText = "Salir del fondo";
          this.iconFondo = "lock_open"
          this.addVestingDb(receipt.logs[0].args[1]);
        }
      }
      if (receipt.logs[0].event == "deleteVesting") {
        //inicie vesting
        if (receipt.status == true) {
          this.btnVesting = false;
          this.btnVestingText = "Entrar al fondo";
          this.iconFondo = "lock"
          this.deleteVestingDb(receipt.logs[0].args[1]);
        }
      }
    },
    transactionError(error, receipt) {
        Loading.hide()
      console.log("errlr", error, receipt);
      this.$q.notify({
        progress: true,
        type: "negative",
        message: error.message,
        timeout: 2000,
      });
    },
    transactionHash(hash){
      console.log("hash", hash);
      var textLoading = ''
      if(this.btnVesting){
          textLoading = 'Saliendo del fondo'
      }else{
          textLoading = 'Entrando del fondo'
      }
       Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">
        ${textLoading}</p> 
        <p>esperando confirmación...</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
        });
    },
    iniciarVesting() {

      if (this.btnVesting) {
        Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">
        Saliendo del fondo</p> 
        <p>esperando aprobación...</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
        });
        ContratoVenta.tokenFintUsd
          .removeVesting({
            from: this.$store.state.myStore.currentAccount,
            value: 0,
          })
          .on("transactionHash", this.transactionHash)
          .on("receipt", this.transactionReceipt)
          .on("error", this.transactionError);
      } else {
            Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">
        Entrando al fondo</p> 
        <p>esperando aprobación...</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
        });
        ContratoVenta.tokenFintUsd
          .tokenVesting({
            from: this.$store.state.myStore.currentAccount,
            value: 0,
          })
           .on("transactionHash", this.transactionHash)
          .on("receipt", this.transactionReceipt)
          .on("error", this.transactionError);
      }
    },
  },
  async mounted() {
    //get vesting tambien aqui mismo
    var getVesting = await ContratoVenta.tokenFintUsd.getVesting(
      this.$store.state.myStore.currentAccount
    );
    console.log("vesting", getVesting);
    if (getVesting) {
      this.btnVesting = true;
      this.btnVestingText = "Salir del fondo";
      this.iconFondo = "lock:open"
    } else {
      this.btnVesting = false;
      this.btnVestingText = "Entrar al fondo";
      this.iconFondo = "lock"
    }
  },
};
</script>

