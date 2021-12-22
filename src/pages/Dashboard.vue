<template>
  <q-page class="q-pa-sm">

     <div class="row q-col-gutter-sm q-py-sm">
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px;">

    <q-card flat >
      <q-card-section class="row">
        <div class="text-h6 text-weight-bolder text-grey-8">
         Balance 4,4998 USD
        </div>
        <q-space></q-space>
       
        <q-btn class="text-capitalize btnCustom"  icon="add" color="black"></q-btn>
      </q-card-section>
      <q-list >
        <lineChartsbalance />
      </q-list>
    </q-card>

      </div>
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px;">
 <q-card flat >
      <q-card-section class="row">
        <div class="text-h6 text-weight-bolder text-grey-8" >
         Deposit 100,254 USD
        </div>
        
        <q-space></q-space>
        <q-btn class="text-capitalize btnCustom"  icon="north_east" color="black"></q-btn>
      </q-card-section>
      <q-card-section class="row">
         <div class="text-h7 text-weight-bolder text-grey-8" style="width: 100%">
         APY 15.3%
        </div>
        <p class="text-grey-8">Tenor 6 mon</p>
      </q-card-section>
      <div class="row">
        <div class="col-12 col-sm-3">
          <div class="module_APY" style="margin-top: 10px;">
              <div class="item_APY">
                <p style="margin-top: 10px;">
                  <q-icon name="arrow_downward"/> <span style="    font-weight: normal;    font-size: 13px;" >Received</span>
                </p>
                  <p><span>150235.04</span> <span style="font-size: 12px;    margin-left: 5px;">USD</span></p>
              </div>
              <div class="item_APY" style="margin-top: 20px;">
                <p style="margin-top: 10px;">
                  <q-icon name="north_east"/> <span style="    font-weight: normal;    font-size: 13px;" >Invested</span>
                </p>
                  <p><span>150235.04</span> <span style="font-size: 12px;    margin-left: 5px;">USD</span></p>
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
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px;">
      <q-card flat >
        <q-card-section class="row">
          <div class="text-h6 text-weight-bolder text-grey-8">
          Assets 1 Coins
          </div>
          <q-space></q-space>
          <q-btn class="text-capitalize btnCustom"  icon="search" flat color="grey-4" text-color="black"   unelevated style="background: #ebebeb99;"></q-btn>
        </q-card-section>
        <q-list >
          <tableAssetsCoin />
        </q-list>
      </q-card>
      </div>

      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="padding: 20px;">
         <q-card flat > 
            <q-card-section class="row">
              <div class="text-h6 text-weight-bolder text-grey-8">
              SWAP
              </div>
              <q-space></q-space>
               <q-btn class="text-capitalize btnCustom"  icon="swap_horiz" flat color="grey-4" text-color="black"   unelevated style="background: #ebebeb99;"></q-btn>
            </q-card-section>
              <q-list >
              <widgetDashboard @openSwapModal="openSwapModal" />
            </q-list>
          </q-card>
      </div>
</div>

  </q-page>
</template>

<script>
import { useQuasar } from 'quasar'
import {defineComponent,defineAsyncComponent} from 'vue'
import { Loading } from "quasar";
import swapModal from '../components/swap/swapModal.vue';
export default defineComponent({
  name: 'PageIndex',
  components: {
    CardSocial: defineAsyncComponent(() => import('components/cards/CardSocial')),
    CardCharts: defineAsyncComponent(() => import('components/cards/CardCharts')),
    // CardCharts: () => import('components/cards/CardCharts'),
    TabSocial: defineAsyncComponent(() => import('components/tabs/TabSocial')),
    CardWithImage: defineAsyncComponent(() => import('components/cards/CardWithImage')),
    CardTimeLine: defineAsyncComponent(() => import('components/cards/CardTimeLine')),
    TodoList: defineAsyncComponent(() => import('components/list/TodoList')),
    TableVisits: defineAsyncComponent(() => import('components/tables/TableVisits')),
    lineChartsbalance: defineAsyncComponent(() => import('components/charts/lineChartsbalance')),
    barChartDeposit: defineAsyncComponent(() => import('components/charts/barChartDeposit')),
    tableAssetsCoin: defineAsyncComponent(() => import('components/tables/tableAssetsCoin')),
    tableRewards: defineAsyncComponent(() => import('components/tables/tableRewards')),
    widgetDashboard: defineAsyncComponent(() => import('components/swap/widgetDashboard')),
    swapModal,
    
    
  },
  setup() {
     const $q = useQuasar()
    Loading.hide();
    return {
      mode: 'list',
      messages: [
        {
          id: 5,
          name: 'Pratik Patel',
          msg: ' -- I\'ll be in your neighborhood doing errands this\n' +
            '            weekend. Do you want to grab brunch?',
          avatar: 'https://avatars2.githubusercontent.com/u/34883558?s=400&v=4',
          time: '10:42 PM'
        }, {
          id: 6,
          name: 'Winfield Stapforth',
          msg: ' -- I\'ll be in your neighborhood doing errands this\n' +
            '            weekend. Do you want to grab brunch?',
          avatar: 'https://cdn.quasar.dev/img/avatar6.jpg',
          time: '11:17 AM'
        }, {
          id: 1,
          name: 'Boy',
          msg: ' -- I\'ll be in your neighborhood doing errands this\n' +
            '            weekend. Do you want to grab brunch?',
          avatar: 'https://cdn.quasar.dev/img/boy-avatar.png',
          time: '5:17 AM'
        }, {
          id: 2,
          name: 'Jeff Galbraith',
          msg: ' -- I\'ll be in your neighborhood doing errands this\n' +
            '            weekend. Do you want to grab brunch?',
          avatar: 'https://cdn.quasar.dev/team/jeff_galbraith.jpg',
          time: '5:17 AM'
        }, {
          id: 3,
          name: 'Razvan Stoenescu',
          msg: ' -- I\'ll be in your neighborhood doing errands this\n' +
            '            weekend. Do you want to grab brunch?',
          avatar: 'https://cdn.quasar.dev/team/razvan_stoenescu.jpeg',
          time: '5:17 AM'
        }
      ],

 openSwapModal () {
        $q.dialog({
          component: swapModal,
          ok: false
        }).onOk(() => {
          // console.log('OK')
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      }

    }
  },

})
</script>
