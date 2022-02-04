require("@truffle/contract/dist/truffle-contract.js");
const contratoVentaJson = require("../../build/contracts/hectorTokenSale.json");
const contratoToken = require("../../build/contracts/hectorToken.json");
const ContratoVenta = {
    contracts: {},
    init: async () => {
      await ContratoVenta.loadWeb3();
      await ContratoVenta.loadAccount();
      await ContratoVenta.loadContract();
      },
    loadWeb3: async () => {
      if (window.ethereum) {
        ContratoVenta.web3Provider = window.ethereum;
      var con =  await window.ethereum.request({ method: "eth_requestAccounts" });
      return con;
      } else if (web3) {
        web3 = new Web3(window.web3.currentProvider);
        return web3
      } else {
        console.log(
          "No ethereum browser is installed. Try it installing MetaMask "
        );
      }
    },
    loadAccount: async () => {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
   //   console.log("load account",accounts)
      ContratoVenta.account = accounts[0];
    },
    loadContract: async () => {
      try {
        const hectorTokenSaleJSON = contratoVentaJson
        ContratoVenta.contracts.hectorTokenSale = TruffleContract(hectorTokenSaleJSON);
        ContratoVenta.contracts.hectorTokenSale.setProvider(ContratoVenta.web3Provider);
        ContratoVenta.hectorTokenSale = await ContratoVenta.contracts.hectorTokenSale.deployed();
       console.log(ContratoVenta.hectorTokenSale)
      } catch (error) {
        console.error(error);
      }
    },

    loadContractToken: async () => {
      try {
        const hectorTokenJson = contratoToken
        ContratoVenta.contracts.hectorToken = TruffleContract(hectorTokenJson);
        ContratoVenta.contracts.hectorToken.setProvider(ContratoVenta.web3Provider);
        ContratoVenta.hectorToken = await ContratoVenta.contracts.hectorToken.deployed();
        console.log(ContratoVenta.hectorToken)
      } catch (error) {
        console.error(error);
      }
    },
  
    comprarTokens: async (cantidad, account) => {
      try {
        console.log("contrato venta account". account)
        const result = await ContratoVenta.hectorTokenSale.buy(cantidad, {
          from: account, value: cantidad * 10000000000000
        });
        return result //.logs[0].args
      //  window.location.reload();
      } catch (error) {
        console.error(error);
      }
    },
  };
  

export default ContratoVenta