<template>
  <div>
      <swapPrimary />
  </div>
</template>

<script>
import {defineComponent,defineAsyncComponent} from 'vue'
export default defineComponent({
     components: {
          swapPrimary: defineAsyncComponent(() => import('components/swap/swapPrimary')),
     },
    setup () {
        return {

        }
    }
})
</script>
