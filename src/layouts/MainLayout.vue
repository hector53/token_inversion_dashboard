<template>
  <q-layout view="hHh Lpr lff">
    <q-header elevated class="bg-white text-primary">
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          @click="toggleLeftDrawer"
          icon="menu"
          aria-label="Menu"
        />
        <q-toolbar-title style="    font-size: 30px;    font-weight: bold;    color: black;">
          FintUSD
        </q-toolbar-title>
        <q-space/>
        <div class="q-gutter-sm row items-center no-wrap">
          <q-btn size="20px" round dense flat  :icon="$q.fullscreen.isActive ? 'fullscreen_exit' : 'fullscreen'"
                 @click="$q.fullscreen.toggle()"
                 v-if="$q.screen.gt.sm">
          </q-btn>
          
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
      width="200"
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


         <q-item to="/" class="q-item-no-link-highlighting qitemSidebar">
          <q-item-section avatar>
            <q-icon name="local_activity"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>Activity</q-item-label>
          </q-item-section>
        </q-item>

         <q-item to="/" class="q-item-no-link-highlighting qitemSidebar">
          <q-item-section avatar>
            <q-icon name="emoji_events"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>Rewards</q-item-label>
          </q-item-section>
        </q-item>

         <q-item to="/" class="q-item-no-link-highlighting qitemSidebar">
          <q-item-section avatar>
            <q-icon name="newspaper"/>
          </q-item-section>
          <q-item-section>
            <q-item-label>News</q-item-label>
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
    logOut(){
      Cookies.remove("authToken");
      this.$router.push("/login")
    }
  },
})
</script>
