const tokenUsdt = artifacts.require("tokenUsdt.sol");
const tokenFintUsd = artifacts.require("tokenFintUsd.sol");
const tokenFintUsdSale = artifacts.require("tokenFintUsdSale.sol");
module.exports = function (deployer) {
   //  deployer.deploy(tokenFintUsd);
   deployer.deploy(tokenFintUsdSale,  "0x24822536262f769CEB328ff61Edc4881e796332C");
};
