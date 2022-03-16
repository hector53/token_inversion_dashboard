<template>
<div class="q-py-md q-pl-sm">
    <div class="text-h6 text-weight-bolder text-grey-8 ">Direcciones en el fondo: </div>

    <q-table class="q-py-md q-pr-md q-mt-md "
    flat
    :rows="arrayAddress"
    :columns="columns" :visible-columns="visibleColumns"
    v-if="visibleTable"
    >
     <template v-slot:header="props">
          <q-tr :props="props" style="background: #dfdfe9">
            <q-th
              v-for="col in props.cols"
              :key="col.name"
              :props="props"
              class="thSize"
            >
              {{ col.label }}
            </q-th>
          </q-tr>
        </template>
        <template v-slot:body="props">
          <q-tr :props="props">
            <q-td key="address" :props="props">
                <q-item-label>{{ props.row.address }}</q-item-label>
            </q-td>
            <q-td key="username" :props="props">
                <q-item-label>{{ props.row.username }}</q-item-label>
            </q-td>
            <q-td key="balance" :props="props">
                <q-item-label>{{ props.row.balance /10**18 }}</q-item-label>
            </q-td>
              <q-td  key="opciones" :props="props">
                        <div class=" q-gutter-md text-center" style="font-size: 2em; ">
                        <q-icon name="visibility" @click="seeAmounts(props.row.address)" class="text-info" style="cursor:pointer"  />
                        
                        </div>
                </q-td>
          </q-tr>
        </template>
    </q-table>



<q-dialog v-model="modalAmountsAddress" >
    <q-card class="q-dialog-plugin " style="width: 100%;">

        <div class="q-pa-md">
            <q-table 
            flat
            :rows="arrayAmounts"
            :columns="columnsAmounts"
            >
            <template v-slot:header="props">
            <q-tr :props="props" style="background: #dfdfe9">
            <q-th
            v-for="col in props.cols"
            :key="col.name"
            :props="props"
            class="thSize"
            >
            {{ col.label }}
            </q-th>
            </q-tr>
            </template>
            <template v-slot:body="props">
            <q-tr :props="props">
                <q-td key="amount" :props="props">
                <q-item-label>{{ props.row.amount / 10**18 }}</q-item-label>
                </q-td>
                <q-td key="fecha" :props="props">
                <q-item-label>{{ props.row.fecha }}</q-item-label>
                </q-td>
            </q-tr>
            </template>
            </q-table>
        </div>
      
    </q-card>
  </q-dialog>
 <q-btn
      class="text-capitalize btnComprarToken"
      style="margin-top: 20px"
      flat
      text-color="white"
      unelevated
      icon="paid"
      @click="repartirGanancias"
      >Repartir Ganancias</q-btn
    >
    </div>
  

</template>

<script>
import { Loading } from "quasar";
import ContratoVenta from "../../contratos/contratoVenta.js";
    export default {
        data() {
            return {
                visibleTable: false,
                contadorGanancias: 0,
                visibleColumns: ['address', 'username', 'balance', 'opciones'],
                modalAmountsAddress: false,
                addr:'', 
                arrayAddress: [
                    {address: "asaddsasadadssadsadsda", username: "asaddsasadadssadsadsda"}, 
                   
                ],
                columns: [
                    {
                    name: "address",
                    label: "Address",
                    field: "address",
                    sortable: true,
                    align: "left",
                     required: true
                    },
                    {
                    name: "username",
                    label: "Username",
                    field: "username",
                    sortable: true,
                    align: "left",
                     required: true
                    },
                    {
                    name: "balance",
                    label: "balance",
                    field: "balance",
                    sortable: true,
                    align: "left",
                     required: true
                    },
                     {
                    name: "opciones",
                    label: "Opciones",
                    field: "opciones",
                    sortable: true,
                    align: "center",
                     required: true
                    },
                    
                ],
                columnsAmounts: [
                    {
                    name: "amount",
                    label: "amount",
                    field: "amount",
                    sortable: true,
                    align: "left",
                    },
                     {
                    name: "fecha",
                    label: "fecha",
                    field: "fecha",
                    sortable: true,
                    align: "left",
                    },
                ],
                arrayAmounts: []
            }
        },
        methods: {
             timeConverter(UNIX_timestamp){
            var a = new Date(UNIX_timestamp * 1000);
            var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            var year = a.getFullYear();
            var month = months[a.getMonth()];
            var date = a.getDate();
            var hour = a.getHours();
            var min = a.getMinutes();
            var sec = a.getSeconds();
            var time = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec ;
            return time;
            },

        async    seeAmounts(addr){
            this.arrayAmounts = []
                var vestingAddr = await ContratoVenta.tokenFintUsd.vesting(
                addr
                );
                console.log("vesting", vestingAddr.counter.toNumber());
                for(var i = 0; i<vestingAddr.counter.toNumber(); i++){
                    var vestingAmounts = await ContratoVenta.tokenFintUsd.getVestingAddr(
                    addr, i
                    );
                    console.log("i", i)
                    console.log("vestingAmounts", vestingAmounts.timestamp);
                    this.arrayAmounts.push(
                        {"amount": vestingAmounts.amount, "fecha": this.timeConverter(vestingAmounts.timestamp)}
                    )
                }

                
               this.modalAmountsAddress = true
            },
            
            repartirGanancias(){
            Loading.show({
            message: ` <p style="font-size: 16px; font-weight: bold;">
            Repartir Ganancias</p> 
            <p>esperando aprobación...</p>
            `,
            html: true,
            boxClass: "bg-white text-grey-9",
            spinnerColor: "info",
            });
              /*  var base = 1+0.22; 
                var exponente = 1/52; 
                var formula = Math.pow(base, exponente) - 1;
                console.log("formula", parseInt(formula*1000000))
                console.log(window.web3.currentProvider)*/
               
                for(var i = 0; i<this.arrayAddress.length; i++){
                    ContratoVenta.tokenFintUsd
                    .distributeProfitsVesting(this.arrayAddress[i].address, {    
                    from: this.$store.state.myStore.currentAccount,
                    value: 0,
                    })
                    .on("transactionHash", this.transactionHash)
                    .on("receipt", this.transactionReceipt)
                    .on("error", this.transactionError);
                }
                
              
            }, 
            transactionHash(hash){
                console.log(hash)
            }, 
            transactionReceipt(receipt){
                console.log("receipt", receipt)
                this.contadorGanancias++
                if(this.contadorGanancias == this.arrayAddress.length){
                    this.getAddressVestingTable()
                    Loading.hide()
                }
            }, 
            transactionError(error, receipt) {
            Loading.hide()
            console.log("errlr", error, receipt);
            this.$q.notify({
            progress: true,
            type: "negative",
            message: error.message,
            timeout: 2000,
            });
            },
            async getAddressVestingTable(){
                 try {
            const result = await this.$store.dispatch(
            "myStore/getAddressInVesting"
            );
            console.log("result", result)
             this.arrayAddress = []
             for(var i = 0; i<result.length; i++){
                 var balance = await ContratoVenta.tokenFintUsd.balanceOf(
                result[i].address
                );
                console.log("balance", balance.toString())
               
                this.arrayAddress.push({
                    "address": result[i].address, 
                    "username": result[i].username, 
                    "balance": balance.toString()
                })
             }
            
            this.visibleTable = true
            Loading.hide()
            } catch (e) {

            console.log("Error:");
            console.log(e);
            }
            }
        },

     async   mounted () {
                await ContratoVenta.init()
            this.getAddressVestingTable()
        },
    }
</script>

