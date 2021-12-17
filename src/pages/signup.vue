<template>
  <q-layout>
    <q-page-container>
      <q-page class="flex bg-image flex-center">
        <q-card v-bind:style="$q.screen.lt.sm?{'width': '80%'}:{'width':'30%'}">
          <q-card-section>
            <q-avatar size="103px" class="absolute-center shadow-10">
              <img src="profile.svg">
            </q-avatar>
          </q-card-section>
          <q-card-section>
            <div class="text-center q-pt-lg">
              <div class="col text-h6 ellipsis" style="padding: 10px;">
                Sign up
              </div>
            </div>
          </q-card-section>
          <q-card-section>
            <q-form
              class="q-gutter-md"
            >
             <q-input
                filled
                v-model="form.email"
                label="Email"
                lazy-rules
                type="email"
              />
              <q-input
                filled
                v-model="form.username"
                label="Username"
                lazy-rules
              />

              <q-input
                type="password"
                filled
                v-model="form.password"
                label="Password"
                lazy-rules

              />

              <div>
                <q-btn label="Sign up" @click="Signup" type="button" color="primary"/>
              </div>
            </q-form>
           <p class="q-mt-md">¿Ya tienes cuenta?
                <router-link to="login" >Inicia sesión aquí</router-link>
              </p>
          </q-card-section>
        </q-card>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script>
import { Loading, Notify} from "quasar";
import {defineComponent} from 'vue'
import {ref} from 'vue'
import { useStore } from 'vuex'
export default defineComponent({
  setup() {
   /// Loading.show();
      const $store = useStore()
    return {
    }
  },
  data() {
      return {
        form: {
        username: '',
        password: '',
        email: ''
        }
      }
  },
  methods: {
       async Signup() {
         Loading.show();
           console.log("signup ")
           try{
                const result = await this.$store.dispatch('myStore/register', this.form)
              //  console.log("la respuesta fue", result)
              Loading.hide();
              this.$q.notify({
                    progress: true,
                    type:'positive',
                    message: 'Registro con exito',
                    timeout: 2000
                    })
           var temporizador =     setTimeout(() => {
                    const { redirect = false } = this.$route.query
                    const path = redirect ? decodeURI(redirect) : '/login'
                    this.$router.push({ path })
                    
                }, 2000)
            }catch(e){
                Loading.hide()
                console.log("Error:")
                console.log(e)
            }
    }
  },
  mounted() {
    
  },
})
</script>

<style>

.bg-image {
  background-image: linear-gradient(135deg, #2d75ba 0%, #b2e4e5 100%);
}
</style>
