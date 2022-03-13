import { route } from 'quasar/wrappers'
import { createRouter, createMemoryHistory, createWebHistory, createWebHashHistory } from 'vue-router'
import routes from './routes'
import { Cookies, Loading } from 'quasar'
/*
 * If not building with SSR mode, you can
 * directly export the Router instantiation;
 *
 * The function below can be async too; either use
 * async/await or return a Promise which resolves
 * with the Router instance.
 */

export default route(function ( { store, ssrContext } ) {
  const createHistory = process.env.MODE === 'ssr'
    ? createMemoryHistory
    : process.env.VUE_ROUTER_MODE === 'history' ? createWebHistory : createWebHashHistory

  const Router = createRouter({
    scrollBehavior: () => ({ left: 0, top: 0 }),
    routes,

    // Leave this as is and make changes in quasar.conf.js instead!
    // quasar.conf.js -> build -> vueRouterMode
    // quasar.conf.js -> build -> publicPath
    history: createHistory(process.env.MODE === 'ssr' ? void 0 : process.env.VUE_ROUTER_BASE)
  })

  Router.beforeEach(async (to, from, next) => {
    
    const token = Cookies.get('authToken')
    if (to.matched.some(record => record.meta.requiresAuth)) {
      
      if (!token) {
        next({
          path: '/login',
          query: { redirect: to.fullPath }
        })
      } else {
        Loading.show();
        console.log("consulto el validate")
        // we have a state.user object but
        // we need to check if the token is still valid
        try{
          const { status } = await store.dispatch('myStore/validate')
          // user is logged in with a valid token
          //inicio el metatrader 
     
          Loading.hide()
          next()
        }catch(e){
          console.log("error route protect", e)
          // the token is invalid so we will have the user login again
          // clear the token and user info
          store.commit('myStore/DELETE_USER')
          next({
            path: '/login',
            query: { redirect: to.fullPath }
          })
        }
      }
    

      
    } else {
      // this is not a protected route
    next()
    }
  })




  return Router
})
