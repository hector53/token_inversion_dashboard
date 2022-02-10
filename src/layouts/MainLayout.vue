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
      width="250"
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

         <q-item to="/Deposits" class="qitemSidebar" :class="{'active': $route.path == '/Deposits'}">
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
import { Cookies } from 'quasar'
import { defineComponent, ref } from 'vue'
import ContratoVenta from "../contratos/contratoVenta.js";

export default defineComponent({
  name: 'MainLayout',

  components: {
    EssentialLink
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
   conectarBilletera() {
      this.loadContract()
    },
   
    logOut(){
      Cookies.remove("authToken");
      this.$router.push("/login")
    }, 


  },
  mounted() {
     
  },
})
</script>
