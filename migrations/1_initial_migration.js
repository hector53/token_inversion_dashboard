const tokenUsdt = artifacts.require("tokenUsdt.sol");
const tokenFintUsd = artifacts.require("tokenFintUsd.sol");
const tokenFintUsdSale = artifacts.require("tokenFintUsdSale.sol");
module.exports = function (deployer) {
   // deployer.deploy(tokenFintUsd);
 deployer.deploy(tokenFintUsdSale,  "0xb928a68E2200c2B8F12F9d3e8480B7a74a8dE6D6");
};
