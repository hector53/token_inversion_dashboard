require("@truffle/contract/dist/truffle-contract.js");
const contratoVentaJson = require("../../build/contracts/tokenFintUsdSale.json");
const contratoTokenFint = require("../../build/contracts/tokenFintUsd.json");
const contratoUsdt = require("../../build/contracts/tokenUsdt.json");
const ContratoVenta = {
    contracts: {},
    init: async () => {
      await ContratoVenta.loadWeb3();
      await ContratoVenta.loadAccount();
      await ContratoVenta.loadContractFintUsdSale();
      await ContratoVenta.loadContractTokenUsdt();
      await ContratoVenta.loadContractTokenFintUsd();

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
    loadContractFintUsdSale: async () => {
      try {
        const tokenFintUsdSaleJson = contratoVentaJson
        ContratoVenta.contracts.tokenFintUsdSale = TruffleContract(tokenFintUsdSaleJson);
        ContratoVenta.contracts.tokenFintUsdSale.setProvider(ContratoVenta.web3Provider);
        ContratoVenta.tokenFintUsdSale = await ContratoVenta.contracts.tokenFintUsdSale.deployed();
     //  console.log("contrato venta",ContratoVenta.tokenFintUsdSale)
      } catch (error) {
        console.error(error);
      }
    },

    loadContractTokenFintUsd: async () => {
      try {
        const tokenFintUsdJson = contratoTokenFint
        ContratoVenta.contracts.tokenFintUsd = TruffleContract(tokenFintUsdJson);
        ContratoVenta.contracts.tokenFintUsd.setProvider(ContratoVenta.web3Provider);
        ContratoVenta.tokenFintUsd = await ContratoVenta.contracts.tokenFintUsd.deployed();
    //    console.log("contrato fintusd",ContratoVenta.tokenFintUsd)
      } catch (error) {
        console.error(error);
      }
    },

    loadContractTokenUsdt: async () => {
      try {
        const tokenUsdtJson = contratoUsdt
        ContratoVenta.contracts.tokenUsdt = TruffleContract(tokenUsdtJson);
        ContratoVenta.contracts.tokenUsdt.setProvider(ContratoVenta.web3Provider);
        ContratoVenta.tokenUsdt = await ContratoVenta.contracts.tokenUsdt.deployed();
    //    console.log("contrato usdt",ContratoVenta.tokenUsdt)
      } catch (error) {
        console.error(error);
      }
    },
  
    comprarTokens: async (cantidad, account) => {
      try {
     //   console.log("contrato venta account". account)
        const result = await ContratoVenta.tokenFintUsdSale.buy(parseInt(cantidad), {
          from: account, value: 0
        });
        return result //.logs[0].args
      //  window.location.reload();
      } catch (error) {
        return error
      }
    },

    venderTokens: async (cantidad, account) => {
      try {
    //    console.log("contrato venta account". account)
        const result = await ContratoVenta.tokenFintUsdSale.sell(parseInt(cantidad), {
          from: account, value: 0
        });
        return result
      //  window.location.reload();
      } catch (error) {
        return error
      }

     
   


    },
  };
  

export default ContratoVenta