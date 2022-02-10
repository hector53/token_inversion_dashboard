<template>
  <q-page class="q-pa-sm" style="margin-bottom: 50px">
    <div class="row q-col-gutter-sm q-py-sm">
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px">
        <q-card flat>
          <q-card-section class="row">
            <div class="text-h6 text-weight-bolder text-grey-8">
              Balance 4,4998 USD
            </div>
            <q-space></q-space>

            <q-btn
              class="text-capitalize btnCustom"
              icon="add"
              color="black"
            ></q-btn>
          </q-card-section>
          <q-list>
            <lineChartsbalance />
          </q-list>
        </q-card>
      </div>
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px">
        <q-card flat>
          <q-card-section class="row">
            <div class="text-h6 text-weight-bolder text-grey-8">
              Deposit 100,254 USD
            </div>

            <q-space></q-space>
            <q-btn
              class="text-capitalize btnCustom"
              icon="north_east"
              color="black"
            ></q-btn>
          </q-card-section>
          <q-card-section class="row">
            <div
              class="text-h7 text-weight-bolder text-grey-8"
              style="width: 100%"
            >
              APY 15.3%
            </div>
            <p class="text-grey-8">Tenor 6 mon</p>
          </q-card-section>
          <div class="row">
            <div class="col-12 col-sm-3">
              <div class="module_APY" style="margin-top: 10px">
                <div class="item_APY">
                  <p style="margin-top: 10px">
                    <q-icon name="arrow_downward" />
                    <span style="font-weight: normal; font-size: 13px"
                      >Received</span
                    >
                  </p>
                  <p>
                    <span>150235.04</span>
                    <span style="font-size: 12px; margin-left: 5px">USD</span>
                  </p>
                </div>
                <div class="item_APY" style="margin-top: 20px">
                  <p style="margin-top: 10px">
                    <q-icon name="north_east" />
                    <span style="font-weight: normal; font-size: 13px"
                      >Invested</span
                    >
                  </p>
                  <p>
                    <span>150235.04</span>
                    <span style="font-size: 12px; margin-left: 5px">USD</span>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-9">
              <barChartDeposit />
            </div>
          </div>
        </q-card>
      </div>
    </div>

    <div class="row q-col-gutter-sm q-py-sm">
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px">
        <q-card flat>
          <q-card-section class="row" style="align-items: center">
            <div class="text-h6 text-weight-bolder text-grey-8">Balance</div>
            <q-space></q-space>
          </q-card-section>
          <q-list>
            <tableAssetsCoin
              v-if="
                $store.state.myStore.btnConectarBilletera == 2 &&
                contratoVentaCargado
              "
              :key="$store.state.myStore.keyTableBalance"
            />
          </q-list>
        </q-card>
      </div>

      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px">
        <q-card flat>
          <q-card-section class="row">
            <div class="text-h6 text-weight-bolder text-grey-8">Intercambiar Tokens</div>
       
            
          </q-card-section>
            <intercambiar-tokens v-if="contratoVentaCargado" ></intercambiar-tokens>
        </q-card>
      </div>
    </div>
  </q-page>
</template>

<script>
import { useQuasar } from "quasar";
import { defineComponent, defineAsyncComponent } from "vue";
import { Loading, Notify } from "quasar";
import swapModal from "../components/swap/swapModal.vue";
//const truContract = require('../../node_modules/@truffle/contract/dist/truffle-contract')
import Web3 from "web3/dist/web3.min.js";
import ContratoVenta from "../contratos/contratoVenta.js";
import { useStore } from "vuex";
export default defineComponent({
  name: "PageIndex",
  components: {
    lineChartsbalance: defineAsyncComponent(() =>
      import("components/charts/lineChartsbalance")
    ),
    barChartDeposit: defineAsyncComponent(() =>
      import("components/charts/barChartDeposit")
    ),
    tableAssetsCoin: defineAsyncComponent(() =>
      import("components/tables/tableAssetsCoin")
    ),

    widgetDashboard: defineAsyncComponent(() =>
      import("components/swap/widgetDashboard")
    ),
    swapDashboard: defineAsyncComponent(() =>
      import("components/swap/swapDashboard")
    ),
     intercambiarTokens: defineAsyncComponent(() =>
      import("components/swap/intercambiarTokens")
    ),
    swapModal,
  },

  data() {
    return {
      btnConectarBilletera: 0,
      currentAccount: "",
      contratoVentaCargado: false,
      chainId: 0,
      //0 = metamask no instalado
      //1 = cuenta no conectada
      //2 = cuenta conectada
    };
  },
  methods: {
    handleAccountsChanged(accounts) {
      if (this.chainId == 97) {
        console.log("entrando al metodo", accounts);
        if (accounts.length == 0) {
          // MetaMask is locked or the user has not connected any accounts
          console.log("Please connect to MetaMask.");
          this.$store.commit("myStore/setBtnConectarBilletera", 1);
          Loading.hide()
        } else if (accounts[0] !== this.$store.state.myStore.currentAccount) {
          this.$store.commit("myStore/setCurrentAccount", accounts[0]);
          console.log("current account ", accounts[0]);
          this.$store.commit("myStore/setBtnConectarBilletera", 2);
          this.$store.commit(
            "myStore/setKeyTableBalance",
            this.$store.state.myStore.keyTableBalance + 1
          );
          this.loadContract();
          this.guardarBilletera(accounts[0]);
          // Do any other work!
        }else{
           this.$store.commit("myStore/setCurrentAccount", accounts[0]);
          console.log("current account ", accounts[0]);
          this.$store.commit("myStore/setBtnConectarBilletera", 2);
          this.$store.commit(
            "myStore/setKeyTableBalance",
            this.$store.state.myStore.keyTableBalance + 1
          );
          this.loadContract();
        }
      }
    },

    async guardarBilletera(address) {
      try {
        const result = await this.$store.dispatch(
          "myStore/save_wallet_user",
          address
        );
      } catch (e) {
        console.log("Error:");
        console.log(e);
      }
    },
transactionHash(hash){
console.log("transaccion hash desde el dashboard", hash)
},
    conectarBilletera() {
      this.loadContract();
    },
    async loadContract() {
      try {
        await ContratoVenta.init();
        this.contratoVentaCargado = true;
        Loading.hide();
      } catch (e) {
        console.log("error", e);
        this.$q.notify({
          progress: true,
          type: "negative",
          message: e.message,
          timeout: 2000,
        });
      }
    },

    async chainChanged(chainId) {
      chainId = parseInt(chainId, 16);
      this.chainId = chainId;
      console.log("chainId", chainId);
      if (chainId != 97) {
        console.log("estas en la red equivocada");
        this.$store.commit("myStore/setBtnConectarBilletera", 4);
        this.contratoVentaCargado = false;
        Loading.hide();
      } else {
        var accounts = await window.ethereum.request({
          method: "eth_accounts",
        });
        this.handleAccountsChanged(accounts);
      }
    },
    metamaskMensaje(msj){
      console.log("metamask mensaje", msj)
    },
    async verificarConexion() {
      if (window.ethereum) {
        var accounts = await window.ethereum.request({
          method: "eth_accounts",
        });
        this.$store.commit("myStore/setCurrentAccount", accounts[0])
        var chainId = await window.ethereum.request({ method: "eth_chainId" });
        this.chainChanged(chainId);
        this.handleAccountsChanged(accounts);

        window.ethereum.on("accountsChanged", this.handleAccountsChanged);
        window.ethereum.on("chainChanged", this.chainChanged);
        window.ethereum.on("transactionHash", this.transactionHash);
          window.ethereum.on("message", this.metamaskMensaje);
        console.log("si esta conectado  a metamask");
      } else if (web3) {
        web3 = new Web3(window.web3.currentProvider);
        console.log("web3", web3);
        this.$store.commit("myStore/setBtnConectarBilletera", 1);
      } else {
        this.$store.commit("myStore/setBtnConectarBilletera", 0);
        console.log(
          "No ethereum browser is installed. Try it installing MetaMask "
        );
      }
    },
  },
  async mounted() {
    const web3 = new Web3('https://data-seed-prebsc-1-s1.binance.org:8545/')
    web3.eth.getTransactionReceipt('0xe0151d8d65207d1f7289582084d761406b6178e28083ffc5821e4903e0b6504b', function(err, tx){
    console.log(tx)
});
    await this.verificarConexion();
  },
});
</script>
