<template>
    <q-table
        dark
        class="bgTableDecks"
        :rows="arrayDepositos"
        :columns="columnas"
        hide-bottom
        v-if="mostrarTabla"
      >
        <template v-slot:header="props">
          <q-tr :props="props" style="background: #3d3d4c">
            <q-th
              v-for="col in props.cols"
              :key="col.name"
              :props="props"
              class="text-white thSize"
            >
              {{ col.label }}
            </q-th>
          </q-tr>
        </template>
        <template v-slot:body="props">
          <q-tr :props="props">
            

            <q-td key="hash" :props="props">
              <q-item-label>{{ props.row.hash }}</q-item-label>
            </q-td>
            <q-td key="date" :props="props">
              <q-item-label>{{ props.row.date }}</q-item-label>
            </q-td>
            <q-td key="value" :props="props">
              <q-item-label>{{ props.row.value }}</q-item-label>
            </q-td>
          </q-tr>
        </template>
      </q-table>
</template>

<script>
import { defineComponent } from "vue";
import { useStore } from "vuex";
export default defineComponent({
  name: "Deposits",
  data() {
    return {
      arrayDepositos: [],
      mostrarTabla: false,
      columnas: [
        {
          hash: "hash",
          label: "Hash",
          field: "hash",
          align: "left",
        },
        {
          name: "date",
          label: "Date",
          field: "date",
          sortable: false,
          align: "left",
        },
        {
          name: "value",
          label: "Value",
          field: "value",
          sortable: true,
          align: "left",
        },
      ],
    };
  },
  methods: {},
  async mounted() {
    try {
      const result = await this.$store.dispatch("myStore/get_transacciones");
      console.log("result", result);
      if(result.status == 1){
        for(var i=0; i<result.tx.length; i++){
          this.arrayDepositos.push(
            {
              "hash" : result.tx[i].hash, 
              "date": result.tx[i].date_confirm, 
              "value": result.tx[i].value
            }
          )
        }
        this.mostrarTabla = true
      }
    } catch (e) {
      console.log("Error:");
      console.log(e);
    }
  },
});
</script>

<style>
.table-bg {
  background-color: #162b4d;
}
</style>
