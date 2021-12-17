<template>
  <div>
      <div class="stacked-cards_cardGroups__2H_qS">
    <div
      class="stacked-cards_card__o4kFR"
      style="transform: translate(0px, 0%) scale(1, 1); z-index: 4" @click="openSwapModal"
    >
      <div class="stacked-cards_pairsImg__32Pjk">
        <img
          src="https://cdn-media.dodoex.io/USDT_e8b71b5f29/USDT_e8b71b5f29.png"
        /><img
          src="https://cdn-media.dodoex.io/usdc_ee52a1ed2b/usdc_ee52a1ed2b.png"
        />
      </div>
      <div class="stacked-cards_content__1tVtX">
        <p>Pay <span class="stacked-cards_number__3WZIa">1000</span> USDT</p>
        <p>
          Receive
          <span class="stacked-cards_number__3WZIa">1000.4944</span> USDC
        </p>
      </div>
      <p class="stacked-cards_tips__2SS2n stacked-cards_hidden__iBK7n">
        <span>0%</span> more than Uniswap
      </p>
    </div>
    <div class="stacked-cards_switchButtons__21RqP"><i class="stacked-cards_buttonUp__pVfLF"></i><i class="stacked-cards_buttonDown__2dnOl"></i></div>
      </div>
  </div>
</template>

<script>
export default {
  setup() {
    return {};
  },
  methods: {
    openSwapModal(){
      this.$emit("openSwapModal")
    }
  },
};
</script>
