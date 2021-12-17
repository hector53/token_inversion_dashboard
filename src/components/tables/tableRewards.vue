<template>
 <q-table flat  class="" :rows="data3" :columns="column" hide-bottom>
      
        <template v-slot:body-cell-Task="props">
          <q-td :props="props">
            <q-item>
              <q-item-section>
                <q-item-label>
                    <span class="text-blue">
                      <q-icon name="bug_report" color="blue" size="20px" v-if="props.row.type=='error'"></q-icon>
                      <q-icon name="settings" color="blue" size="20px" v-if="props.row.type=='gold'"></q-icon>
                      <q-icon name="flag" color="blue" size="20px" v-if="props.row.type=='success'"></q-icon>
                      <q-icon name="fireplace" color="blue" size="20px" v-if="props.row.type=='warning'"></q-icon>
                      {{ props.row.name }}
                    </span>
                  <q-chip class="float-right text-white text-capitalize" :label="props.row.type" color="positive"
                          v-if="props.row.type=='success'"></q-chip>
                  <q-chip class="float-right text-white text-capitalize" :label="props.row.type" color="info"
                          v-if="props.row.type=='gold'"></q-chip>
                  <q-chip class="float-right text-white text-capitalize" :label="props.row.type" color="warning"
                          v-if="props.row.type=='warning'"></q-chip>
                  <q-chip class="float-right text-white text-capitalize" :label="props.row.type" color="negative"
                          v-if="props.row.type=='error'"></q-chip>
                </q-item-label>
                <q-item-label caption class="">
                  <q-linear-progress dark :color="getColor(props.row.Progress)" :value="props.row.Progress/100"
                  />
                </q-item-label>

                <q-item-label>
                    <span class="text-blue">
                     564 left
                    </span>
                    <span class="float-right text-capitalize">{{props.row.total}}</span>
                </q-item-label>
                 
              </q-item-section>
            </q-item>
          </q-td>
        </template>
      </q-table>
</template>

<script>
import {defineComponent} from 'vue'

const column = [
  {name: 'Task', label: '', field: 'task', sortable: true, align: 'left'},
];

const data3 = [
  {
    name: 'Platinum',
    position: 20,
    Progress: 70,
    type: 'gold',
    cant: '564',
    total: 1000,
  },
];


export default defineComponent({
  name: "TableProgress",
  setup() {

    return {
      column,
      data3,
      getColor(val) {
        if (val > 70 && val <= 100) {
          return 'green'
        } else if (val > 50 && val <= 70) {
          return 'blue'
        }
        return 'red'
      }
    }
  },

})
</script>

<style scoped>

</style>
