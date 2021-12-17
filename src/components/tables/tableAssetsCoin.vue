<template>
  <q-table flat  :rows="data" :columns="columns" hide-bottom>
        <template v-slot:body-cell-Name="props">
          <q-td :props="props">
            <q-item style="max-width: 420px">
              <q-item-section avatar>
                <q-avatar>
                  <img :src="props.row.avatar">
                </q-avatar>
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ props.row.name }}</q-item-label>
              </q-item-section>
            </q-item>
          </q-td>
        </template>
        <template v-slot:body-cell-Action="props">
          <q-td :props="props">
            <q-btn icon="edit" size="sm" flat dense/>
            <q-btn icon="delete" size="sm" class="q-ml-sm" flat dense/>
          </q-td>
        </template>
      </q-table>
</template>

<script>
import {defineComponent} from 'vue'


const data = [
  {
    name: 'BTC',
    avatar: 'data:image/png;base64,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',
    price: 43986.90,
    value: 2496.3,
    balance: 0.05154,
  }
  
];

const columns = [
  {name: 'Name', label: 'Name', field: 'name', sortable: true, align: 'left'},
  {name: 'Price', label: 'Price', field: 'price', sortable: true, align: 'left'},
  {name: 'Value', label: 'Value', field: 'value', sortable: true, align: 'left'},
  {name: 'Balance', label: 'Balance ', field: 'balance', sortable: false, align: 'center'}
];


export default defineComponent({
  name: "TableActions",
  setup() {
    return {
      data,
      columns,
    }
  }
})
</script>

<style scoped>

</style>
