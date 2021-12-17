export const  SET_USER =  (state, val) => {
    console.log("entrando al commit ")
    state.user = val
    console.log("state user", state.user)
}
export const  DELETE_USER =  (state, val) => {
    state.user = null
}
