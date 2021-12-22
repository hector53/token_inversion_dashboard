<template>
  <q-table flat  :rows="data" :columns="columns" hide-bottom>
        <template v-slot:body-cell-Name="props">
          <q-td :props="props">
            <q-item style="max-width: 420px">
              <q-item-section avatar>
                <q-avatar size="56px">
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
    name: 'FintUsd',
    avatar: 'https://i.ibb.co/jr0BDCZ/fintusd-icon.png',
    price: 1.000,
    value: 50000,
    balance: 50000,
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
