<template>
  <q-spinner
    style="width: 100%; text-align: center"
    color="primary"
    size="3em"
    :thickness="10"
    v-if="cargando"
  />
  <div v-else>
    <div class="intercambiarTokens" v-if="txPending == false">
      <div class="cubreIntercambios">
        <div class="cubreIntercambio">
          <span class="titleIntercambio">Pagar</span>
          <input type="number" v-model="moneySend" class="inputIntercambiar" />
          <q-btn-dropdown
            ref="btnSinFocus1"
            outline
            flat
            id="btnDropdownIntercambiarTokens"
            :ripple="false"
          >
            <template v-slot:label>
              <div class="row items-center no-wrap">
                <div
                  class="sc-csTbgd kglWtV"
                  style="width: 24px; height: 24px; margin-right: 8px"
                >
                  <img :src="itemTokens[0].img" class="sc-eGJWMs gQYBcx" />
                </div>
                <span class="titleTokenDropdown">
                  {{ itemTokens[0].label }}
                </span>
              </div>
            </template>
            <q-list>
              <q-item
                v-for="(item, index) in itemTokens"
                :key="index"
                class="itemDropdownIntercambiarTokens"
                clickable
                v-close-popup
                @click="onItemClick(0, index)"
              >
                {{ item.label }}
              </q-item>
            </q-list>
          </q-btn-dropdown>
        </div>

        <div class="cubreIntercambio">
          <span class="titleIntercambio">Recibir</span>
          <input type="number" v-model="moneySend" class="inputIntercambiar" />
          <q-btn-dropdown
            id="btnDropdownIntercambiarTokens"
            :ripple="false"
            outline
            flat
            ref="btnSinFocus2"
          >
            <template v-slot:label>
              <div class="row items-center no-wrap">
                <div
                  class="sc-csTbgd kglWtV"
                  style="width: 24px; height: 24px; margin-right: 8px"
                >
                  <img :src="itemTokens[1].img" class="sc-eGJWMs gQYBcx" />
                </div>
                <span class="titleTokenDropdown">
                  {{ itemTokens[1].label }}
                </span>
              </div>
            </template>
            <q-list>
              <q-item
                v-for="(item, index) in itemTokens"
                :key="index"
                class="itemDropdownIntercambiarTokens"
                clickable
                v-close-popup
                @click="onItemClick(1, index)"
              >
                {{ item.label }}
              </q-item>
            </q-list>
          </q-btn-dropdown>
        </div>
        <div  class="liquidezNecesaria">
            <q-spinner
            style="width: 100%; text-align: center"
            color="primary"
            size="1em"
            :thickness="4"
            v-if="cargandoLiquidez"
            />
            <p v-else>{{msjLiquidezNecesaria}}</p>
          
        </div>
        <q-btn
          class="text-capitalize btnComprarToken"
          flat
          :disabled="btnMetamaskEnable"
          text-color="white"
          @click="comprarTokens"
          unelevated
          >{{btnComprarTitle}}</q-btn
        >


        
      </div>
      <q-btn
        class="text-capitalize btnCustom"
        icon="swap_horiz"
        flat
        color="grey-4"
        text-color="black"
        unelevated
        style="background: #ebebeb99"
        @click="intercambiar"
      ></q-btn>
      
    </div>
    <div class="transaccionPendienteMsj" v-else>
      <p>Transacción Pendiente:</p>
      <p> <q-spinner
    style="width: 100%; text-align: center"
    color="primary"
    size="1em"
    :thickness="10"
  /></p>
      <p>
        <a
          :href="'https://testnet.bscscan.com/tx/' + hashPending"
          target="_blank"
          >Ver en BscScan</a
        >
      </p>
    </div>
  </div>
</template>

<script>
import Web3 from "web3/dist/web3.min.js";
import ContratoVenta from "../../contratos/contratoVenta.js";
import { Loading, Notify } from "quasar";
export default {
  data() {
    return {
      cargando: true,
      cargandoLiquidez: false,
      msjLiquidezNecesaria: '',
      imgSend:
        "https://cdn-media.dodoex.io/USDT_e8b71b5f29/USDT_e8b71b5f29.png",
      imgReceived: "https://i.ibb.co/jr0BDCZ/fintusd-icon.png",
      labelSend: "USDT",
      labelReceived: "FintUsd",
      moneySend: 0,
      moneyReceived: 0,
      itemTokens: [
        {
          img: "https://cdn-media.dodoex.io/USDT_e8b71b5f29/USDT_e8b71b5f29.png",
          label: "USDT",
          cant: 0,
        },
        {
          img: "https://i.ibb.co/jr0BDCZ/fintusd-icon.png",
          label: "FintUsd",
          cant: 0,
        },
      ],
      btnMetamaskEnable: false,
      txPending: false,
      hashPending: "",
      confirmationTransaction: 0,
      intervalPending: 0,
      typeTx: 0, 
      btnComprarTitle: 'comprar fintusd', 
      btnVesting: false, 
      btnVestingText: ''
    };
  },
  watch: {
   moneySend() {
       this.verificarLiquidezNecesaria()
    },
  },
  methods: {
      async aprobarFintUsd(){

   Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">Necesitamos que apruebe los siguientes permisos para usar su Token FintUsd</p> 
        <p>esperando aprobación</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
      });
          
      try {
        var approve = await ContratoVenta.tokenFintUsd.approve(
          ContratoVenta.tokenFintUsdSale.address,
          BigInt(200000000000000000 * 10 ** 18),
          {
            from: this.$store.state.myStore.currentAccount,
            value: 0,
          }
        );
      } catch (e) {
        console.log("error al aprobar FintUsd", e.message);
        this.$q.notify({
          progress: true,
          type: "negative",
          message: e.message,
          timeout: 2000,
        });
        Loading.hide();
        this.btnMetamaskEnable = false;
        return false;
      }

      },
    async aprobarUsdt() {
      
         Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">Necesitamos que apruebe los siguientes permisos para usar su Token USDT</p> 
        <p>esperando aprobación</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
      });
      try {
        var approve = await ContratoVenta.tokenUsdt.approve(
          ContratoVenta.tokenFintUsdSale.address,
          BigInt(200000000000000000 * 10 ** 18),
          {
            from: this.$store.state.myStore.currentAccount,
            value: 0,
          }
        );

        

      } catch (e) {
        console.log("error al aprobar USDT", e.message);
        this.$q.notify({
          progress: true,
          type: "negative",
          message: e.message,
          timeout: 2000,
        });
        Loading.hide();
        this.btnMetamaskEnable = false;
        return false;
      }
    },


    async comprarFintUsd() {
        this.typeTx = 0
      this.btnMetamaskEnable = true;
      Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">Intercambiando ${this.moneySend} USDT por  ${this.moneySend} FintUsd</p> 
        <p>confirme esta transacción en su wallet</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
      });

      //antes de hacer la compra debo verificar el allowance y de no tener aprobado pedirlo por un numero infinito para no pedirlo mas
      var balanceAllow = await ContratoVenta.tokenUsdt.getAllowance(
        this.$store.state.myStore.currentAccount,
        ContratoVenta.tokenFintUsdSale.address
      );
      balanceAllow = balanceAllow.toString();
      balanceAllow = parseInt(balanceAllow) / 10 ** 18;
      console.log("balanceSale", balanceAllow);

      if (balanceAllow < this.moneySend) {
        console.log("pido aprobar ");
        await this.aprobarUsdt();
           Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">Intercambiando ${this.moneySend} USDT por  ${this.moneySend} FintUsd</p> 
        <p>confirme esta transacción en su wallet</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
      });
      }
      
      ContratoVenta.tokenFintUsdSale
        .buy(parseInt(this.moneySend), {
          from: this.$store.state.myStore.currentAccount,
          value: 0,
        })
        .on("transactionHash", this.transactionHash)
        .on("confirmation", this.transactionConfirmation)
        .on("receipt", this.transactionReceipt)
        .on("error", this.transactionError);
    },
    transactionError(error, receipt) {
      Loading.hide();
      console.log("errlr", error, receipt);
      this.txPending = false;
      this.btnMetamaskEnable = false;
      console.log("error al comprar FintUsd", error.message);
      this.$q.notify({
        progress: true,
        type: "negative",
        message: error.message,
        timeout: 2000,
      });
    },

  
    
    transactionReceipt(receipt) {
      console.log("receipt", receipt);
     
      if(receipt.status == true){
            this.updateTransaccionHash(this.hashPending);
            this.moneySend = 0
      }
      
      this.$store.commit(
        "myStore/setKeyTableBalance",
        this.$store.state.myStore.keyTableBalance + 1
      );
      this.txPending = false
      this.hashPending = ""
      this.btnMetamaskEnable = false
      this.confirmationTransaction = 0;
    },
    transactionConfirmation(confirmationNumber, receipt) {
      console.log("confirmacion", confirmationNumber, receipt);
      this.confirmationTransaction = confirmationNumber;
    },
    transactionHash(hash) {
        this.hashPending = hash
      console.log("hash", hash);
      this.enviarTransaccionPendiente(hash, 0, this.moneySend);
       this.txPending = true;
      Loading.hide();
     
    },
    activarTransaccionPendiente() {
      console.log("activar transaccion pendinete");
    },

    async enviarTransaccionPendiente(hash, type, value) {
      try {
        const result = await this.$store.dispatch(
          "myStore/enviarTransaccionPendiente",
          {
            hash: hash,
            type: this.typeTx,
            value:value
          }
        );
        console.log(result);
      } catch (e) {
        console.log("Error:");
        console.log(e);
      }
    },
    async comprarUsdt() {

 this.typeTx = 1

      this.btnMetamaskEnable = true;
      Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">Intercambiando ${this.moneySend} FintUsd por  ${this.moneySend} USDT</p> 
        <p>confirme esta transacción en su wallet</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
      });

      //antes de hacer la compra debo verificar el allowance y de no tener aprobado pedirlo por un numero infinito para no pedirlo mas
      var balanceAllow = await ContratoVenta.tokenFintUsd.getAllowance(
        this.$store.state.myStore.currentAccount,
        ContratoVenta.tokenFintUsdSale.address
      );
      balanceAllow = balanceAllow.toString();
      balanceAllow = parseInt(balanceAllow) / 10 ** 18;
      console.log("balanceSale", balanceAllow);

      if (balanceAllow < this.moneySend) {
        console.log("pido aprobar ");
        await this.aprobarFintUsd();
          Loading.show({
        message: ` <p style="font-size: 16px; font-weight: bold;">Intercambiando ${this.moneySend} FintUsd por  ${this.moneySend} USDT</p> 
        <p>confirme esta transacción en su wallet</p>
        `,
        html: true,
        boxClass: "bg-white text-grey-9",
        spinnerColor: "info",
      });
      }
      ContratoVenta.tokenFintUsdSale
        .sell(parseInt(this.moneySend), {
          from: this.$store.state.myStore.currentAccount,
          value: 0,
        })
        .on("transactionHash", this.transactionHash)
        .on("confirmation", this.transactionConfirmation)
        .on("receipt", this.transactionReceipt)
        .on("error", this.transactionError);
    },
    comprarTokens() {
      if (this.moneySend == 0) {
        this.$q.notify({
          progress: true,
          type: "negative",
          message: "Cantidad a pagar debe ser mayor que cero",
          timeout: 2000,
        });
        return false;
      }
      if (this.itemTokens[0].label == "USDT") {
        //comprar FintUsd
        console.log("comprar fintusd");
        this.comprarFintUsd();
      } else {
        //cambiar FIntusd por usdt
        this.comprarUsdt();
      }
    },
    async verificarLiquidezNecesaria(){
             if(this.moneySend > 0){
           this.msjLiquidezNecesaria = ''

            if (this.itemTokens[0].label == "USDT") {
                this.btnComprarTitle = 'comprar fintusd'
                this.cargandoLiquidez = true
                //entonces voy a comprar FIntUsd
                console.log("verificar liquidez de fintUsd")
                var balance = await ContratoVenta.tokenFintUsd.getBalanceOf(
                ContratoVenta.tokenFintUsdSale.address
                );
                balance = balance.toString();
                balance = parseInt(balance) / 10 ** 18;
                console.log("balanceSale", balance);
                if(balance > this.moneySend){
                     this.cargandoLiquidez = false
                    this.msjLiquidezNecesaria = 'Existe la liquidez necesaria para realizar esta operación correctamente'
                   
                }else{
                     this.cargandoLiquidez = false
                     this.msjLiquidezNecesaria = 'NO Existe la liquidez necesaria para realizar esta operación correctamente'
                     this.btnComprarTitle = 'solicitar'
                }
            } else {
                 this.btnComprarTitle = 'vender fintusd'
                //entonces voy a compra USDT
                console.log("verificar liquidez de USDT")
                 var balance = await ContratoVenta.tokenUsdt.getBalanceOf(
                ContratoVenta.tokenFintUsdSale.address
                );
                balance = balance.toString();
                balance = parseInt(balance) / 10 ** 18;
                console.log("balanceSale", balance);
                if(balance > this.moneySend){
                    this.msjLiquidezNecesaria = 'Existe la liquidez necesaria para realizar esta operación correctamente'
                }else{
                     this.msjLiquidezNecesaria = 'NO Existe la liquidez necesaria para realizar esta operación correctamente'
                     this.btnComprarTitle = 'solicitar'
                }
            }

       }else{
           this.msjLiquidezNecesaria = ''
           this.cargandoLiquidez = false
       }
    },
    intercambiar() {
        
        this.verificarLiquidezNecesaria()
      var ArrayNuevo = [];
      ArrayNuevo.push(this.itemTokens[1]);
      ArrayNuevo.push(this.itemTokens[0]);
      this.itemTokens = ArrayNuevo;

       if (this.itemTokens[0].label == "USDT") {
          //entonces voy a comprar FIntUsd
          console.log("voy a comprar tokens FintUsd");
          this.btnComprarTitle = 'comprar fintusd'
        } else {
             this.btnComprarTitle = 'vender fintusd'
          //entonces voy a compra USDT
          console.log(
            "voy a cambiar FintUsd por USDT voy a cambiar mis tokens por $"
          );
        }
    },
    onItemClick(index, posicion) {
      if (index == 0) {
        //es el de arriba
        if (posicion == 1) {
          //entonces toy dando clic en el otro debo intercambiar
          console.log("intercambiar");
          var ArrayNuevo = [];
          ArrayNuevo.push(this.itemTokens[1]);
          ArrayNuevo.push(this.itemTokens[0]);
          this.itemTokens = ArrayNuevo;
        }
      } else {
        console.log("index = 1 fintusd");
        if (posicion == 0) {
          //entonces toy dando clic en el otro debo intercambiar
          console.log("intercambiar");
          var ArrayNuevo = [];
          ArrayNuevo.push(this.itemTokens[1]);
          ArrayNuevo.push(this.itemTokens[0]);
          this.itemTokens = ArrayNuevo;
        }
        //es el de abajo
      }
    },
    async get_transacciones_pendientes() {
   

      try {
        const result = await this.$store.dispatch(
          "myStore/getTransaccionesPendientes"
        );
        console.log(result);
        this.cargando = false;
        if (result.status == 0) {
          //si hay pendientes
          this.txPending = true;
          this.hashPending = result.tx[0].hash;
          this.intervalPending = setInterval(
            function () {
              console.log("consultando el hash en el intervalo");
              this.consultarHashPendiente();
            }.bind(this),
            5000
          );
        } else {
          this.$refs["btnSinFocus1"].$el.classList.remove("q-hoverable");
          this.$refs["btnSinFocus1"].$el.classList.remove("q-focusable");
          this.$refs["btnSinFocus2"].$el.classList.remove("q-hoverable");
          this.$refs["btnSinFocus2"].$el.classList.remove("q-focusable");
        }
      } catch (e) {
        this.cargando = false;
        console.log("Error:");
        console.log(e);
      }
    },
    async consultarHashPendiente() {
      var vm = this;
      const web3 = new Web3("https://data-seed-prebsc-1-s1.binance.org:8545/");
      var tx = await web3.eth.getTransactionReceipt(this.hashPending);
      console.log("tx result", tx);
      if (tx.status == true) {
        console.log("si es igual a true");
        this.updateTransaccionHash(this.hashPending);
        clearInterval(this.intervalPending);
        this.txPending = false;
        this.hashPending = "";
        
      }
    },
    async updateTransaccionHash(hash) {
      try {
        const result = await this.$store.dispatch(
          "myStore/updateTransaccionHash", {
              hash: hash
          }
        );
        console.log(result);
      } catch (e) {
        console.log("Error:");
        console.log(e);
      }
    },
  },
  async mounted() {
    console.log(ContratoVenta);
    console.log("mounted");

    //preguntar si no hay transacciones pendientes
    await this.get_transacciones_pendientes();
  },
};
</script>
