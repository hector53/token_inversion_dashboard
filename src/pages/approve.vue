<template>
  <div>
    <input type="number"  v-model="cantAprobar" />
    <button @click="aprobar">Aprobar</button>
  </div>
</template>

<script>
import ContratoVenta from "../contratos/contratoVenta.js";
export default {
    data() {
        return {
            cantAprobar: 0
        }
    },
  methods: {
    async aprobar() {
      var approve = await ContratoVenta.tokenUsdt.approve(
        ContratoVenta.tokenFintUsdSale.address,
        BigInt(this.cantAprobar * 10 ** 18),
        {
          from: ContratoVenta.account,
          value: 0,
        }
      );
    },
  },
  async mounted() {
    await ContratoVenta.init();
  },
};
</script>
