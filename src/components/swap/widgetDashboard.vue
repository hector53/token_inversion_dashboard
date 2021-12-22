<template>
  <div>
    <div class="stacked-cards_cardGroups__2H_qS">
      <div
        class="stacked-cards_card__o4kFR"
        style="transform: translate(0px, 0%) scale(1, 1); z-index: 4"
        @click="openSwapModal"
      >
        <div class="stacked-cards_pairsImg__32Pjk">
          <img :src="imgSend" />
          <img :src="imgReceived" />
        </div>
        <div class="stacked-cards_content__1tVtX">
          <p>
            Pay
            <span class="stacked-cards_number__3WZIa">{{ moneySend }}</span>
            {{ labelSend }}
          </p>
          <p>
            Receive
            <span class="stacked-cards_number__3WZIa">{{ moneyReceived }}</span>
            {{ labelReceived }}
          </p>
        </div>
        <p class="stacked-cards_tips__2SS2n stacked-cards_hidden__iBK7n">
          Existe la cantidad de liquidez necesaria con slippage menor al <span>1%</span>
        </p>
      </div>
      <div class="stacked-cards_switchButtons__21RqP">
        <i class="stacked-cards_buttonUp__pVfLF" @click="intercambiar"></i
        ><i class="stacked-cards_buttonDown__2dnOl" @click="intercambiar"></i>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  setup() {
    return {};
  },
  data() {
    return {
      imgSend:
        "https://cdn-media.dodoex.io/USDT_e8b71b5f29/USDT_e8b71b5f29.png",
      imgReceived: "https://i.ibb.co/jr0BDCZ/fintusd-icon.png",
      labelSend: "USDT",
      labelReceived: "FintUsd",
      moneySend: 1000,
      moneyReceived: 1000.4944,
    };
  },
  methods: {
    intercambiar(){
      var iconSend = this.imgSend
      var iconReceived = this.imgReceived
      var labelSend = this.labelSend
      var labelReceived = this.labelReceived
      var moneySend = this.moneySend
      var moneyReceived = this.moneyReceived

      this.imgSend = iconReceived
      this.imgReceived = iconSend
      this.labelSend = labelReceived
      this.labelReceived = labelSend
      this.moneySend = moneyReceived
      this.moneyReceived = moneySend
    },
    openSwapModal() {
      this.$emit("openSwapModal");
    },
  },
};
</script>
