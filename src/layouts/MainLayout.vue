<template>
  <q-layout view="hHh Lpr lff">
    <q-header elevated class="bg-white text-primary">
      <q-toolbar>
      
        <q-toolbar-title style="    flex:2; cursor: pointer;">
          <q-img
          src="https://uploads-ssl.webflow.com/616c304ef1493f7d6005ee62/616d9d362627deb1ff49b1a9_logo-fintelligentia_Mesa%20de%20trabajo%201-p-500.png"
          loading="lazy"
          spinner-color="white"
          class="brandF"
          style="max-width: 190px"
          @click="toggleLeftDrawer"
          />
        </q-toolbar-title>
        <q-space/>
        <div class="q-gutter-sm row items-center no-wrap">
        
             <div class="btnConectarBilletera" v-if="$store.state.myStore.btnConectarBilletera == 1" @click="conectarBilletera">
              <span>Connect Wallet</span>
            </div>

            <div class="btnConectarBilletera" v-if="$store.state.myStore.btnConectarBilletera == 4" @click="conectarBilletera">
              <span>Red equivodada, cambiar a red Testnet</span>
            </div>

            <div class="btnAddress" v-if="$store.state.myStore.btnConectarBilletera == 2" >
              <span>{{$store.state.myStore.currentAccount}}</span> <span>{{$store.state.myStore.currentAccount}}</span>
            </div>
            

            <p v-if="$store.state.myStore.btnConectarBilletera == 0">No ethereum browser is installed. Try it installing MetaMask</p>



          <q-btn round dense flat  icon="notifications" size="20px">
            <q-badge color="red"  floating>
              5
            </q-badge>
            <q-menu
            >
              <q-list style="min-width: 100px">
                <messages></messages>
                <q-card class="text-center no-shadow no-border">
                  <q-btn label="View All" style="max-width: 120px !important;" flat dense
                         class="text-indigo-8"></q-btn>
                </q-card>
              </q-list>
            </q-menu>
          </q-btn>
          <q-btn round flat>
            <q-avatar size="30px">
              <img src="https://cdn.quasar.dev/img/boy-avatar.png">
            </q-avatar>
             <q-menu >
              <q-list >
                <q-item clickable v-close-popup @click="logOut">
                  <q-item-section>
                    <q-item-label>Salir</q-item-label>
                  </q-item-section>
                </q-item>
              </q-list>
            </q-menu>
          </q-btn>
        </div>
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      :width="250"
    >
      <q-list>
        
        <q-item to="/" active-class="qitemSidebar" :class="{'active': $route.path == '/'}">
          <q-item-section avatar>
            <q-icon name="home"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>Overview</q-item-label>
          </q-item-section>
        </q-item>

         <q-item to="/deposits" class="qitemSidebar" :class="{'active': $route.path == '/deposits'}">
          <q-item-section avatar>
            <q-icon name="account_balance_wallet"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>Deposits</q-item-label>
          </q-item-section>
        </q-item>

         <q-item to="/Swap" class="qitemSidebar" :class="{'active': $route.path == '/Swap'}">
          <q-item-section avatar>
            <q-icon name="swap_horiz"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>Swap</q-item-label>
          </q-item-section>
        </q-item>


         <q-item to="/Activity" class="qitemSidebar" :class="{'active': $route.path == '/Activity'}">
          <q-item-section avatar>
            <q-icon name="local_activity"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>Activity</q-item-label>
          </q-item-section>
        </q-item>

         <q-item to="/graficos" class="qitemSidebar" :class="{'active': $route.path == '/graficos'}">
          <q-item-section avatar>
            <q-icon name="show_chart"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>Charts</q-item-label>
          </q-item-section>
        </q-item>


        
      </q-list>
        
       
    </q-drawer>

    <q-page-container class="bg-white">
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import EssentialLink from 'components/EssentialLink.vue'
import Messages from "./Messages";
import { Cookies, Loading } from 'quasar'
import { defineComponent, ref } from 'vue'
import ContratoVenta from "../contratos/contratoVenta.js";
import Web3 from "web3/dist/web3.min.js";
export default defineComponent({
  name: 'MainLayout',

  components: {
    EssentialLink
  },
data() {
  return {
       btnConectarBilletera: 0,
      currentAccount: "",
      contratoVentaCargado: false,
      chainId: 0,
  }
},
  setup () {
    const leftDrawerOpen = ref(false)

    return {
      leftDrawerOpen,
      toggleLeftDrawer () {
        leftDrawerOpen.value = !leftDrawerOpen.value
      }
    }
  }, 

  methods: {


    async loadContract() {
        try {
           await ContratoVenta.init()
           console.log("contrato venta desde store", ContratoVenta)
          this.$store.commit("myStore/setContratoVenta", true);
                
           this.contratoVentaCargado = true;
        }catch(e){
          console.log("error", e)
          this.$q.notify({
          progress: true,
          type:'negative',
          message: e.message,
          timeout: 2000
          })
        }
        console.log("contaro venta desde store ahora si", this.$store.state.myStore.contratoVenta)
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
   conectarBilletera() {
      this.loadContract()
      
    },
   
    logOut(){
      Cookies.remove("authToken");
      this.$router.push("/login")
    }, 
 handleAccountsChanged(accounts) {
      if (this.chainId == 1337) {
        console.log("entrando al metodo", accounts);
        if (accounts.length == 0) {
          // MetaMask is locked or the user has not connected any accounts
          console.log("Please connect to MetaMask.");
          this.$store.commit("myStore/setBtnConectarBilletera", 1);
          Loading.hide()
        } else if (accounts[0] !== this.$store.state.myStore.currentAccount) {
           this.$store.commit("myStore/setProvider", window.web3.currentProvider);
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
            this.$store.commit("myStore/setProvider", window.web3.currentProvider);
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

 async chainChanged(chainId) {
      chainId = parseInt(chainId, 16);
      this.chainId = chainId;
      console.log("chainId", chainId);
      if (chainId != 1337) {
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
transactionHash(hash){
console.log("transaccion hash desde el dashboard", hash)
},
metamaskMensaje(msj){
      console.log("metamask mensaje", msj)
    },
  },
 async  mounted() {

      if (window.ethereum) {
        console.log("si hay metamask")
        var accounts = await window.ethereum.request({
          method: "eth_accounts",
        });
        if(accounts.length > 0){
          console.log("si hay cuentas")
          this.$store.commit("myStore/setCurrentAccount", accounts[0])
          var chainId = await window.ethereum.request({ method: "eth_chainId" });
          this.chainChanged(chainId);
          this.handleAccountsChanged(accounts);

          window.ethereum.on("accountsChanged", this.handleAccountsChanged);
          window.ethereum.on("chainChanged", this.chainChanged);
          window.ethereum.on("transactionHash", this.transactionHash);
          window.ethereum.on("message", this.metamaskMensaje);
          this.$store.commit("myStore/setProvider", window.web3.currentProvider);
        }else{
          console.log("no hay cuentas")
           console.log("Please connect to MetaMask.");
          this.$store.commit("myStore/setBtnConectarBilletera", 1);
          window.ethereum.on("accountsChanged", this.handleAccountsChanged);
          window.ethereum.on("chainChanged", this.chainChanged);
          window.ethereum.on("transactionHash", this.transactionHash);
          window.ethereum.on("message", this.metamaskMensaje);
        }
        
         Loading.hide()
      }else if (web3) {
        web3 = new Web3(window.web3.currentProvider);
        console.log("web3", web3);
        this.$store.commit("myStore/setBtnConectarBilletera", 1);
         Loading.hide()
      } else {
        this.$store.commit("myStore/setBtnConectarBilletera", 0);
        console.log(
          "No ethereum browser is installed. Try it installing MetaMask "
        );
         Loading.hide()
      }
  },
})
</script>
