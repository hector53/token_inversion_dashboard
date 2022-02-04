const hectorToken = artifacts.require("hectorToken.sol");
const hectorTokenSale = artifacts.require("hectorTokenSale.sol");
module.exports = function (deployer) {
 //deployer.deploy(hectorToken);
 deployer.deploy(hectorTokenSale, 10000000000000, "0xda601d0ee2ac51d2e07c64d600695daf45d1ded5");
};
