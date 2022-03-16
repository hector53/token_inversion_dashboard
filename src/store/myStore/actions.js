import { api } from 'boot/axios'
import { Cookies } from 'quasar'


export function login ({ commit, state }, payload) {
    return new Promise(async (resolve, reject) => {
        try {
          const { data } = await api.post('jwt-auth/v1/token', payload)
          Cookies.set('authToken', data)
          resolve(data)
        }catch(e){
          reject(e)
        }
      })
}

export function register ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
      //  console.log("parametros", payload)
        const { data } = await api.post('registrar/usuario', payload)
     //   console.log("la data fue", data)
        resolve(data)
      }catch(e){
        console.log("error", e)
        reject(e)
      }
    })
}








export function validate ({ state }) {
  const token = Cookies.get('authToken')
  console.log("token", token.token)
    return api({
        url: 'jwt-auth/v1/token/validate', 
        method: 'post',
        headers: {
          'Authorization': `Bearer ${token.token}`
        }
      })
}


//guardar wallet o comprobar si ya existe 







export function updateTransaccionHash ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
      
       const token = Cookies.get('authToken')
       var param = {
        hash: payload.hash, 
         email: token.user_email
       }
       console.log("parametros", param)
        const { data } = await api.post('send/update_hash', param)
       console.log("la data fue", data)
        return data
      }catch(e){
      
        reject(e)
      }
    })
}

export function enviarTransaccionPendiente ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
      
       const token = Cookies.get('authToken')
       var param = {
        hash: payload.hash, 
        type: payload.type,
        value: payload.value,
         email: token.user_email
       }
       console.log("parametros", param)
        const { data } = await api.post('send/transaccion_pendiente', param)
       console.log("la data fue", data)
        return data
      }catch(e){
      
        reject(e)
      }
    })
}



export function save_wallet_user ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
      
       const token = Cookies.get('authToken')
       var param = {
        address: payload, 
         email: token.user_email
       }
       console.log("parametros", param)
        const { data } = await api.get('save/walletuser?email='+param.email+'&address='+param.address)
       console.log("la data fue", data)
        return data
      }catch(e){
      
        reject(e)
      }
    })
}






export function getTransaccionesPendientes ({ commit, state }) {
  return new Promise(async (resolve, reject) => {
      try {
        const token = Cookies.get('authToken')
        const { data } = await api.get('get/transacciones_pendientes?email='+token.user_email)
        resolve(data)
      }catch(e){
        reject(e)
      }
    })
}


export function get_transacciones ({ commit, state }) {
  return new Promise(async (resolve, reject) => {
      try {
        const token = Cookies.get('authToken')
        const { data } = await api.get('get/transacciones_realizadas?email='+token.user_email)
        resolve(data)
      }catch(e){
        reject(e)
      }
    })
}




//get wallets of user
export function get_wallets_user ({ commit, state }) {
  return new Promise(async (resolve, reject) => {
      try {
       const token = Cookies.get('authToken')
        const { data } = await api.get('get/walletuser?email='+token.user_email)
        resolve(data)
      }catch(e){
        reject(e)
      }
    })
}

export function iniciarVesting ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
       const token = Cookies.get('authToken')
       var param = {
        addr: payload.addr, 
        email: token.user_email
       }
       console.log("parametros", param)
        const { data } = await api.post('save/address_vesting', param)
       console.log("la data fue", data)
        return data
      }catch(e){
      
        reject(e)
      }
    })
}

export function deleteVesting ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
       const token = Cookies.get('authToken')
       var param = {
        addr: payload.addr, 
        email: token.user_email
       }
       console.log("parametros", param)
        const { data } = await api.post('delete/address_vesting', param)
       console.log("la data fue", data)
        return data
      }catch(e){
      
        reject(e)
      }
    })
}

export function adminDashboard ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
       const token = Cookies.get('authToken')
       var param = {
        email: token.user_email
       }
       console.log("parametros", param)
        const { data } = await api.post('get/admin_user', param)
       console.log("la data fue", data)
       resolve(data)
      }catch(e){
      
        reject(e)
      }
    })
}

export function getAddressInVesting ({ commit, state }, payload) {
  return new Promise(async (resolve, reject) => {
      try {
        const { data } = await api.get('get/get_address_in_vesting')
       resolve(data)
      }catch(e){
        reject(e)
      }
    })
}