const tokenUsdt = artifacts.require("tokenUsdt.sol");
const tokenFintUsd = artifacts.require("tokenFintUsd.sol");
const tokenFintUsdSale = artifacts.require("tokenFintUsdSale.sol");
module.exports = function (deployer) {
 //deployer.deploy(tokenFintUsd);
   deployer.deploy(tokenFintUsdSale,  "0x3Ed92B5d24cF2de91B8d930Da7aA3dB4B0EE99eD");
};
