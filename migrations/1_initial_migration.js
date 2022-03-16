const tokenUsdt = artifacts.require("tokenUsdt.sol");
const tokenFintUsd = artifacts.require("tokenFintUsd.sol");
const tokenFintUsdSale = artifacts.require("tokenFintUsdSale.sol");
module.exports = function (deployer) {
//deployer.deploy(tokenUsdt);
 deployer.deploy(tokenFintUsdSale,  "0xe476375be079cb5fB333d2388CaefC83317B396b");
};
