<template>
  <q-table
    flat
    :rows="arrayWallets"
    v-if="arrayWallets.length > 0"
    :columns="columns"
    hide-bottom
  >
  </q-table>

  <q-spinner
    style="width: 100%; text-align: center"
    color="primary"
    size="3em"
    :thickness="10"
    v-else
  />
</template>

<script>
import { defineComponent } from "vue";
import ContratoVenta from "../../contratos/contratoVenta.js";

export default defineComponent({
  name: "TableActions",

  data() {
    return {
      spinnerLoading: true,
      arrayWallets: [],
      columns: [
        {
          name: "token",
          label: "Token",
          field: "token",
          sortable: true,
          align: "left",
        },
        {
          name: "precio",
          label: "Precio",
          field: "precio",
          sortable: true,
          align: "left",
        },
        {
          name: "APY",
          label: "apy",
          field: "apy",
          sortable: true,
          align: "left",
        },
        {
          name: "balance",
          label: "Balance ",
          field: "balance",
          sortable: false,
          align: "center",
        },
      ],
    };
  },

  methods: {},
  async mounted() {
    
    console.log("account ", this.$store.state.myStore.currentAccount);
    var balance = await ContratoVenta.tokenFintUsd.balanceOf(
      this.$store.state.myStore.currentAccount
    );
      balance = balance / 10 ** 18;
      this.arrayWallets.push({
        token: "FintUsd",
        precio: "1$",
        apy: "22.5%",
        balance: balance,
      });
  },
});
</script>

<style scoped></style>
