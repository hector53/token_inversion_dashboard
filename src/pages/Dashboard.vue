<template>
  <q-page class="q-pa-sm" style="    margin-bottom: 50px;">
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
            <div class="text-h6 text-weight-bolder text-grey-8">
              FintUsd Balance
            </div>
            <q-space></q-space>

            <button
              type="button"
              class="default dodo__sc-142t8zn-0 dodo__sc-1o1su6q-0 dodo__sc-1o1su6q-1 knVUHO jkZCXP bysMrZ"
              style="width: auto"
              @click="conectarBilletera"
              v-if="btnConectarBilletera == 1 "
            >
              <span>Conectar Billetera</span>
            </button>
            <q-btn
              v-if="btnConectarBilletera == 2 "
              class="text-capitalize btnCustom"
              icon="search"
              flat
              color="grey-4"
              text-color="black"
              unelevated
              style="background: #ebebeb99"
            ></q-btn>
          </q-card-section>
          <q-list >
            <p v-if="btnConectarBilletera == 0">No ethereum browser is installed. Try it installing MetaMask</p>
            <tableAssetsCoin v-if="btnConectarBilletera == 2" :key="$store.state.myStore.keyTableBalance"/>
          </q-list>
        </q-card>
      </div>

      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px">
        <q-card flat>
          <q-card-section class="row">
            <div class="text-h6 text-weight-bolder text-grey-8">SWAP</div>
            <q-space></q-space>
            <q-btn
              class="text-capitalize btnCustom"
              icon="swap_horiz"
              flat
              color="grey-4"
              text-color="black"
              unelevated
              style="background: #ebebeb99"
            ></q-btn>
          </q-card-section>
          <q-list>
            <widgetDashboard @openSwapModal="openSwapModal" />
          </q-list>
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
    swapModal,
  },
  setup() {
    const $store = useStore();
    const $q = useQuasar();

  

    return {
      mode: "list",
      messages: [
        {
          id: 5,
          name: "Pratik Patel",
          msg:
            " -- I'll be in your neighborhood doing errands this\n" +
            "            weekend. Do you want to grab brunch?",
          avatar: "https://avatars2.githubusercontent.com/u/34883558?s=400&v=4",
          time: "10:42 PM",
        },
        {
          id: 6,
          name: "Winfield Stapforth",
          msg:
            " -- I'll be in your neighborhood doing errands this\n" +
            "            weekend. Do you want to grab brunch?",
          avatar: "https://cdn.quasar.dev/img/avatar6.jpg",
          time: "11:17 AM",
        },
        {
          id: 1,
          name: "Boy",
          msg:
            " -- I'll be in your neighborhood doing errands this\n" +
            "            weekend. Do you want to grab brunch?",
          avatar: "https://cdn.quasar.dev/img/boy-avatar.png",
          time: "5:17 AM",
        },
        {
          id: 2,
          name: "Jeff Galbraith",
          msg:
            " -- I'll be in your neighborhood doing errands this\n" +
            "            weekend. Do you want to grab brunch?",
          avatar: "https://cdn.quasar.dev/team/jeff_galbraith.jpg",
          time: "5:17 AM",
        },
        {
          id: 3,
          name: "Razvan Stoenescu",
          msg:
            " -- I'll be in your neighborhood doing errands this\n" +
            "            weekend. Do you want to grab brunch?",
          avatar: "https://cdn.quasar.dev/team/razvan_stoenescu.jpeg",
          time: "5:17 AM",
        },
      ],

      openSwapModal() {
        $q.dialog({
          component: swapModal,
          ok: false,
        })
          .onOk(() => {
            // console.log('OK')
          })
          .onCancel(() => {
            // console.log('Cancel')
          })
          .onDismiss(() => {
            // console.log('I am triggered on both OK and Cancel')
          });
      },
    };
  },
  data() {
    return {
      btnConectarBilletera: 0,
      currentAccount: ''
      //0 = metamask no instalado 
      //1 = cuenta no conectada 
      //2 = cuenta conectada 
    };
  },
  methods: {
    handleAccountsChanged(accounts){
      console.log("entrando al metodo",accounts)
         if (accounts.length == 0) {
    // MetaMask is locked or the user has not connected any accounts
    console.log('Please connect to MetaMask.');
    this.btnConectarBilletera = 1
  } else if (accounts[0] !== this.currentAccount) {
    this.currentAccount = accounts[0];
    console.log("current account ", this.currentAccount)
    this.btnConectarBilletera = 2
    this.guardarBilletera(accounts[0])
    // Do any other work!
  }
    },

async guardarBilletera(address){
      try{
      const result = await this.$store.dispatch('myStore/save_wallet_user', address)
      console.log(result)
         this.$store.commit(
            "myStore/setKeyTableBalance",
            this.$store.state.myStore.keyTableBalance + 1
          );
      }catch(e){
      console.log("Error:")
      console.log(e)
      }
},

    conectarBilletera() {
      this.loadContract()
    },
    async loadContract() {
   

    try {
  
    await ContratoVenta.init()
    
    }catch(e){
    console.log("error", e)
    this.$q.notify({
            progress: true,
            type:'negative',
            message: e.message,
            timeout: 2000
            })
    }

    
    },
  },
  async mounted() {
    if (window.ethereum) {
      var accounts = await window.ethereum.request({ method: 'eth_accounts' })
      console.log("accounts", accounts)
      if(accounts.length == 0){
          this.btnConectarBilletera = 1
      }else{
          this.btnConectarBilletera = 2
      }
      window.ethereum.on('accountsChanged', this.handleAccountsChanged);
      console.log("si esta conectado  a metamask");
      
    } else if (web3) {
      web3 = new Web3(window.web3.currentProvider);
      console.log("web3", web3);
      this.btnConectarBilletera = 1
    } else {
      this.btnConectarBilletera = 0
      console.log(
        "No ethereum browser is installed. Try it installing MetaMask "
      );
    }

      Loading.hide();
  },
});
</script>
