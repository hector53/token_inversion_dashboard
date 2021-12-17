<template>
<q-dialog ref="dialogRef" @hide="onDialogHide" :ok="false">
    <q-card class="q-dialog-plugin">
       <div class="dodo__sc-9junse-6 lhqCVE" style="margin-top: 0">
      <div class="dodo__sc-13wxst1-0 kPSQsX">
        <div class="dodo__sc-13wxst1-1 jNNqtt" style="min-height: 483px">
          <div class="dodo__sc-9junse-7 jwOBbM">
            <div class="dodo__sc-9junse-25 hcYNws">
               <q-btn class="text-capitalize btnCustom"  icon="share"
                flat color="grey-4" text-color="white"  
                 unelevated style="background: rgb(38, 39, 41);     margin-right: 10px;"></q-btn>

                 <q-btn class="text-capitalize btnCustom"  icon="settings"
                flat color="grey-4" text-color="white"  
                 unelevated style="background: rgb(38, 39, 41);"></q-btn>
         
              
            </div>
            <div class="dodo__sc-9junse-8 Ezmgn">
              <div class="dodo__sc-9junse-9 dEmCTs">Pagar</div>
            </div>
            <div class="dodo__sc-74lcca-0 cfmNWP">
              <div class="dodo__sc-12irif8-0 eVPJAw dodo__sc-74lcca-2 hCeVkh">
                <div class="dodo__onyo6i-0 VlCrY">
                  <div
                    class="sc-csTbgd kglWtV"
                    style="width: 24px; height: 24px; margin-right: 8px"
                  >
                   <img src="https://cmp.dodoex.io/bH4DEFt9zh3egnuU3eEePDxtYaTX1BWRdijMbfobcc0/rs:fit:24:24:0/g:no/aHR0cHM6Ly9jZG4tbWVkaWEuZG9kb2V4LmlvL1VTRFRfZThiNzFiNWYyOS9VU0RUX2U4YjcxYjVmMjkucG5n.webp" class="sc-eGJWMs gQYBcx">
                  </div>
                  <div class="dodo__onyo6i-1 iwByGz">USDT</div>
                </div>
                <span class="dodo__sc-12irif8-1 fbjKLz"
                  ><svg
                    width="14px"
                    height="14px"
                    viewBox="0 0 14 14"
                    version="1.1"
                    xmlns="http://www.w3.org/2000/svg"
                    class="dodo__sc-1952kb8-0 iJZbZb"
                  >
                    <g
                      stroke="none"
                      stroke-width="1"
                      fill="none"
                      fill-rule="evenodd"
                    >
                      <g
                        transform="translate(3.000000, 4.000000)"
                        fill="currentColor"
                      >
                        <path
                          d="M4.41602515,0.624037721 L7.4817666,5.2226499 C7.63494283,5.45241425 7.5728559,5.76284892 7.34309155,5.91602515 C7.26095779,5.97078099 7.16445395,6 7.06574145,6 L0.934258546,6 C0.658116171,6 0.434258546,5.77614237 0.434258546,5.5 C0.434258546,5.40128751 0.46347756,5.30478366 0.518233399,5.2226499 L3.58397485,0.624037721 C3.73715108,0.394273376 4.04758575,0.332186442 4.2773501,0.485362672 C4.33227624,0.521980101 4.37940772,0.569111577 4.41602515,0.624037721 Z"
                          transform="translate(4.000000, 3.000000) scale(1, -1) translate(-4.000000, -3.000000) "
                        ></path>
                      </g>
                    </g></svg
                ></span>
              </div>
              <input
                font-weight="600"
                placeholder="0"
                type="number"
                inputmode="decimal"
                class="dodo__qu0amn-3 dodo__sc-74lcca-3 iWLZXK fqGJMi"
                value=""
              />
            </div>
            <div class="dodo__sc-9junse-12 diIJcg">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="26"
                height="26"
                viewBox="0 0 26 26"
                class="dodo__a983zd-0 kVnVaZ"
              >
                <g id="icon-token转换" transform="translate(0.5 0.5)">
                  <path
                    id="路径"
                    d="M25,12.5A12.5,12.5,0,1,1,12.5,0,12.5,12.5,0,0,1,25,12.5Z"
                    fill="transparent"
                    stroke-miterlimit="10"
                    stroke-width="1"
                  ></path>
                  <path
                    id="路径-2"
                    data-name="路径"
                    d="M6.251.781a.781.781,0,0,0-1.562,0V9.833L1.335,6.478A.782.782,0,0,0,.229,7.584l4.687,4.688a.781.781,0,0,0,1.106,0L10.71,7.584A.782.782,0,0,0,9.6,6.478L6.251,9.833Z"
                    transform="translate(7.03 6.25)"
                  ></path>
                </g>
              </svg>
            </div>
            <div class="dodo__sc-9junse-8 Ezmgn">
              <div class="dodo__sc-9junse-9 dEmCTs">Recibir (Estimado)</div>
            </div>
            <div class="dodo__sc-74lcca-0 cfmNWP">
              <div class="dodo__sc-12irif8-0 eVPJAw dodo__sc-74lcca-2 hCeVkh">
                <div class="dodo__onyo6i-0 VlCrY">
                  <div
                    class="sc-csTbgd kglWtV"
                    style="width: 24px; height: 24px; margin-right: 8px"
                  >
                    <img
                      src="https://cmp.dodoex.io/qr1exo9PpFYUeb71DOXJp9E16VdZpj-V9qpRo-fujok/rs:fit:24:24:0/g:no/aHR0cHM6Ly9jZG4tbWVkaWEuZG9kb2V4LmlvL3VzZGNfZWU1MmExZWQyYi91c2RjX2VlNTJhMWVkMmIucG5n.webp"
                      class="sc-eGJWMs gQYBcx"
                    />
                  </div>
                  <div class="dodo__onyo6i-1 iwByGz">USDC</div>
                </div>
                <span class="dodo__sc-12irif8-1 fbjKLz"
                  ><svg
                    width="14px"
                    height="14px"
                    viewBox="0 0 14 14"
                    version="1.1"
                    xmlns="http://www.w3.org/2000/svg"
                    class="dodo__sc-1952kb8-0 iJZbZb"
                  >
                    <g
                      stroke="none"
                      stroke-width="1"
                      fill="none"
                      fill-rule="evenodd"
                    >
                      <g
                        transform="translate(3.000000, 4.000000)"
                        fill="currentColor"
                      >
                        <path
                          d="M4.41602515,0.624037721 L7.4817666,5.2226499 C7.63494283,5.45241425 7.5728559,5.76284892 7.34309155,5.91602515 C7.26095779,5.97078099 7.16445395,6 7.06574145,6 L0.934258546,6 C0.658116171,6 0.434258546,5.77614237 0.434258546,5.5 C0.434258546,5.40128751 0.46347756,5.30478366 0.518233399,5.2226499 L3.58397485,0.624037721 C3.73715108,0.394273376 4.04758575,0.332186442 4.2773501,0.485362672 C4.33227624,0.521980101 4.37940772,0.569111577 4.41602515,0.624037721 Z"
                          transform="translate(4.000000, 3.000000) scale(1, -1) translate(-4.000000, -3.000000) "
                        ></path>
                      </g>
                    </g></svg
                ></span>
              </div>
              <input
                font-weight="600"
                placeholder="0"
                disabled=""
                type="number"
                inputmode="decimal"
                class="dodo__qu0amn-3 dodo__sc-74lcca-3 iWLZXK fqGJMi"
                value="0"
              />
            </div>
            <div class="dodo__sc-9junse-13 eGowmH">
              <span>1 ETH = 4029.6018 USDC</span>
              <div class="dodo__sc-9junse-14 NEDGi">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="20"
                  height="20"
                  viewBox="0 0 20 20"
                  class="dodo__b74gbo-0 dwLAsI"
                >
                  <circle cx="10" cy="10" r="10" fill="currentColor"></circle>
                  <g transform="translate(5 5)">
                    <path
                      d="M7.762,10.057a.226.226,0,0,1-.034-.121V9.045H3.368A3.449,3.449,0,0,1,0,5.57V3.921a.368.368,0,0,1,.736-.009v1.6a2.721,2.721,0,0,0,2.588,2.8h4.4V7.416a.226.226,0,0,1,.346-.192l2.009,1.261a.226.226,0,0,1,.071.311.218.218,0,0,1-.071.072l-2.009,1.26a.226.226,0,0,1-.312-.071ZM9.426,6.251v-1.6a2.721,2.721,0,0,0-2.588-2.8H2.689v.893a.226.226,0,0,1-.227.226.229.229,0,0,1-.121-.034L.334,1.679a.225.225,0,0,1-.071-.311A.218.218,0,0,1,.334,1.3L2.342.035a.227.227,0,0,1,.347.192v.892h4.1a3.45,3.45,0,0,1,3.368,3.475V6.242a.368.368,0,0,1-.735.009Z"
                    ></path>
                  </g>
                </svg>
              </div>
            </div>
            <button
              type="button"
              class="
                default
                dodo__sc-142t8zn-0 dodo__sc-1o1su6q-0 dodo__sc-1o1su6q-1
                knVUHO
                jkZCXP
                bysMrZ
              "
            >
              Conectar billetera
            </button>
            <div class="dodo__sc-9junse-40 dALGWz"></div>
            <div
              class="dodo__sc-1q6rmg2-9 dodo__sc-9junse-15 aCAYE ehnWDv"
            ></div>
            <div class="dodo__sc-9junse-39 bJyEPd"></div>
          </div>
        </div>
      </div>
    </div>
    
    </q-card>
  </q-dialog>
  
</template>

<script>
import { useDialogPluginComponent } from 'quasar'
export default {
  props: {
    // ...your custom props
  },

  emits: [
    // REQUIRED; need to specify some events that your
    // component will emit through useDialogPluginComponent()
    ...useDialogPluginComponent.emits
  ],
  setup() {
   const { dialogRef, onDialogHide, onDialogOK, onDialogCancel } = useDialogPluginComponent()
    return {
      dialogRef,
      onDialogHide,

      // other methods that we used in our vue html template;
      // these are part of our example (so not required)
      onOKClick () {
        // on OK, it is REQUIRED to
        // call onDialogOK (with optional payload)
        onDialogOK()
        // or with payload: onDialogOK({ ... })
        // ...and it will also hide the dialog automatically
      },

      // we can passthrough onDialogCancel directly
      onCancelClick: onDialogCancel
    };
  },
};
</script>
