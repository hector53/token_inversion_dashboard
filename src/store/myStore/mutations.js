export const  SET_USER =  (state, val) => {
    console.log("entrando al commit ")
    state.user = val
    console.log("state user", state.user)
}
export const  DELETE_USER =  (state, val) => {
    state.user = null
}


export const  setMetamaskStatus =  (state, val) => {
    state.metamaskStatus = val
}

export const  setContratoVenta =  (state, val) => {
    state.contratoVenta = val
}

export const  setKeyTableBalance =  (state, val) => {
    state.keyTableBalance = val
}

export const  setBtnConectarBilletera =  (state, val) => {
    state.btnConectarBilletera = val
}

export const  setCurrentAccount =  (state, val) => {
    state.currentAccount = val
}


